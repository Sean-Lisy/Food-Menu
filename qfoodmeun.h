#ifndef QFOODMEUN_H
#define QFOODMEUN_H

#include <QObject>
#include <QFile>
#include <QMultiMap>

typedef struct TAverageData {
    double average;
    int sumCount;
}AverageData;

/**
 * @brief The QFoodMeun class
 */
class QFoodMeun : public QObject
{
    Q_OBJECT
public:
    explicit QFoodMeun(QObject *parent = nullptr);
    ~QFoodMeun();

    Q_INVOKABLE void  fillMenuMap (const QString &strMenu, const int &nScore);

    /**
     * @brief saveMenuRate 将数据保存到file中
     */
    void saveMenuRate();

    void getMenuRate();

    QMap<QString, AverageData> calculateAverage(const QMultiMap<QString, int>& multiMap);

    QStringList genResult(const QMap<QString, AverageData>& map);

private:
    QMultiMap <QString, int> m_mapMenuRate;
    QFile m_file;

signals:
};

#endif // QFOODMEUN_H
