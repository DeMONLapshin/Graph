#include "graphcontroller.h"

#include <QDebug>
#include <QQmlContext>

#include "graphprivate.h"

class GraphController::Implementation
{
public:
    explicit Implementation(GraphController *q);

    GraphController *q = nullptr;
    GraphPrivate *graphPrivate = nullptr;
};

GraphController::Implementation::Implementation(GraphController *q)
    : q(q)
    , graphPrivate(new GraphPrivate(q))
{
}

// ****

GraphController::GraphController(QObject *parent)
    : QObject(parent)
    , d(new Implementation(this))
{
}

GraphController::~GraphController() = default;

void GraphController::setupContext(QQmlContext *rootContext)
{
    rootContext->setContextProperty("grapController", d->graphPrivate);
}
