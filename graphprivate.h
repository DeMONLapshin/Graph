#pragma once

#include <QObject>

class GraphPrivate : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int maximumValue MEMBER m_maximumValue NOTIFY maximumValueChanged)
    //    Q_PROPERTY(int currentValue MEMBER m_currentValue NOTIFY currentValueChanged)
    //    Q_PROPERTY(double progress MEMBER m_progress NOTIFY progressChanged)

public:
    explicit GraphPrivate(QObject *parent);
    ~GraphPrivate() override = default;

    void setMaximumValue(const int maximumValue);
    //    void setCurrentValue(const int currentValue);

private:
    void handleKeyPressed(int key);

signals:
    void maximumValueChanged();
    //    void currentValueChanged();
    //    void progressChanged();

private:
    int m_maximumValue = 0;
    //    int m_currentValue = 0;
    //    double m_progress = 0;
};
