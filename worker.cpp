#include "worker.h"

#include <QAbstractEventDispatcher>
#include <QDebug>
#include <QPoint>
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
        m_mutex.lock();
        int x = QRandomGenerator::global()->bounded(m_range);
        int y = QRandomGenerator::global()->bounded(m_range);
        m_mutex.unlock();
        QVariantList list;
        list << QPoint(x, y) << QPoint(x - 1, y - 1);
        emit progressChanged(QVariant::fromValue(list));

        if (m_isPauseRequested) {
            qDebug() << "Worker: childe Thread paused";
            m_isPauseRequested = false;
            m_mutex.unlock();
            break;
        }

        if (thread()->isInterruptionRequested()) {
            qDebug() << "Worker: childe Thread interrupted";
            thread()->quit();
            break;
        }

        thread()->eventDispatcher()->processEvents(QEventLoop::AllEvents); // check events to handle
        thread()->msleep(1000);
    }
}

void Worker::setRange(const int range)
{
    QMutexLocker locker(&m_mutex);
    m_range = range;
}

void Worker::pauseRequest()
{
    m_isPauseRequested = true;
}
