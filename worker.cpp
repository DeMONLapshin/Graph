#include "worker.h"

#include <QDebug>
#include <QRandomGenerator>
#include <QThread>
#include <QVariant>
#include <QVariantList>

Worker::Worker(QObject *parent)
    : QObject(parent)
{
}

void Worker::numberGeneration()
{
    while (1) {
        int x = QRandomGenerator::global()->bounded(m_range);
        int y = QRandomGenerator::global()->bounded(m_range);
        QVariantList list;
        list << x << y;
        emit progressChanged(QVariant::fromValue(list));

        QMutexLocker locker(&m_mutex);
        if (m_isPauseRequested) {
            qDebug() << "Worker: childe Thread paused";
            m_isPauseRequested = false;
            break;
        }
        if (thread()->isInterruptionRequested()) {
            qDebug() << "Worker: childe Thread interrupted";
            thread()->quit();
            break;
        }

        thread()->msleep(1000);
    }
}

void Worker::setRange(const int range)
{
    m_range = range;
}

void Worker::pauseRequested()
{
    QMutexLocker locker(&m_mutex);
    m_isPauseRequested = true;
}
