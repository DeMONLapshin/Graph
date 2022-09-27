#include "graphcontroller.h"

#include <QDebug>
#include <QQmlContext>
#include <QThread>
#include <QVariant>

#include "graphview.h"
#include "worker.h"

class GraphController::Implementation
{
public:
    explicit Implementation(GraphController *q);

    void numberGeneration();

    GraphController *q = nullptr;
    GraphView *graphView = nullptr;
    QThread workerThread;
    Worker *worker;
};

GraphController::Implementation::Implementation(GraphController *q)
    : q(q)
    , graphView(new GraphView(q))
    , worker(new Worker)
{
    worker->moveToThread(&workerThread);
    worker->setRange(graphView->range());

    connect(graphView, &GraphView::startButtonClicked, worker, &Worker::numberGeneration);
    connect(graphView, &GraphView::pauseButtonClicked, q,
            [worker = worker]() { worker->pauseRequested(); });
    connect(graphView, &GraphView::stopButtonClicked, q,
            [worker = worker]() { worker->thread()->requestInterruption(); });
    connect(worker, &Worker::progressChanged, graphView, &GraphView::progressChanged);

    connect(&workerThread, &QThread::finished, worker, &QObject::deleteLater);
    workerThread.start();
}

void GraphController::Implementation::numberGeneration()
{
}

// ****

GraphController::GraphController(QObject *parent)
    : QObject(parent)
    , d(new Implementation(this))
{
}

GraphController::~GraphController()
{
    d->workerThread.quit();
    d->workerThread.wait();
};

void GraphController::setupContext(QQmlContext *rootContext)
{
    rootContext->setContextProperty("graphController", d->graphView);
}
