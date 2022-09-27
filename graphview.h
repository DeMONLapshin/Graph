#pragma once

#include <QObject>
#include <QVariant>

class GraphView : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int range MEMBER m_range CONSTANT)

public:
    explicit GraphView(QObject *parent);
    ~GraphView() override = default;

    int range() const noexcept;

signals:
    void startButtonClicked();
    void pauseButtonClicked();
    void stopButtonClicked();
    void progressChanged(const QVariant point);

private:
    int m_range{15};
};
