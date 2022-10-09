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
    class WorkerThread : public QThread
    {
        void run() override
        {
            exec();
        }
    };

    explicit Implementation(GraphController *q);

    void numberGeneration();

    GraphController *q = nullptr;
    GraphView *graphView = nullptr;
    WorkerThread workerThread;
    Worker *worker;
};

GraphController::Implementation::Implementation(GraphController *q)
    : q(q)
    , graphView(new GraphView(q))
    , worker(new Worker)
{
}

void GraphController::Implementation::numberGeneration()
{
}

// ****

GraphController::GraphController(QObject *parent)
    : QObject(parent)
    , d(new Implementation(this))
{
    d->worker->moveToThread(&d->workerThread);
    d->worker->setRange(d->graphView->range());

    connect(d->graphView, &GraphView::startButtonClicked, d->worker, &Worker::numberGeneration);
    connect(d->graphView, &GraphView::pauseButtonClicked, d->worker, &Worker::pauseRequest);
    connect(d->graphView, &GraphView::stopButtonClicked, d->worker,
            [worker = d->worker]() { worker->thread()->requestInterruption(); });
    connect(d->worker, &Worker::progressChanged, d->graphView, &GraphView::progressChanged);

    connect(&d->workerThread, &QThread::finished, d->worker, &QObject::deleteLater);
    d->workerThread.start();
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
