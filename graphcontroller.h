#pragma once

#include <QObject>

class QQmlContext;

class GraphController : public QObject
{
    Q_OBJECT
public:
    explicit GraphController(QObject *paren = nullptr);
    ~GraphController() override;

    void setupContext(QQmlContext *rootContext);

private:
    class Implementation;
    QScopedPointer<Implementation> d;
};
