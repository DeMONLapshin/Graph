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

    // signals:
    //    void removeSelectedFilesPressed();
    //    void moveSelectedFilesPressed();
    //    void copySelectedFilesPressed();
    //    void cancelSelectionPressed();
    //    void setMovingModePressed();

private:
    class Implementation;
    QScopedPointer<Implementation> d;
};
