#include "graphview.h"

GraphView::GraphView(QObject *parent)
    : QObject(parent)
{
}

int GraphView::range() const noexcept
{
    return m_range;
}
