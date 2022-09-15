#pragma once

#include <QObject>
#include <QVariant>

class GraphPrivate : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int range MEMBER m_range CONSTANT)

public:
    explicit GraphPrivate(QObject *parent);
    ~GraphPrivate() override = default;

    int range() const noexcept;

signals:
    void startButtonClicked();
    void pauseButtonClicked();
    void stopButtonClicked();
    void progressChanged(const QVariant point);

private:
    int m_range{15};
};
