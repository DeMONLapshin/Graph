#include "graphprivate.h"

GraphPrivate::GraphPrivate(QObject *parent)
    : QObject(parent)
{
}

int GraphPrivate::range() const noexcept
{
    return m_range;
}
