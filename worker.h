#pragma once

#include "QObject"
#include <QMutex>
#include <QVariant>

class Worker : public QObject
{
    Q_OBJECT

public:
    explicit Worker(QObject *parent = nullptr);
    virtual ~Worker() = default;

    void numberGeneration();
    void setRange(const int range);
    void pauseRequest();

signals:
    void progressChanged(const QVariant point);

private:
    int m_range;
    bool m_isPauseRequested{false};
    QMutex m_mutex;
};
