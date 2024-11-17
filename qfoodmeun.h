#ifndef QFOODMEUN_H
#define QFOODMEUN_H

#include <QObject>
#include <QFile>
#include <QMultiMap>
#include <QDateTime>

typedef struct TAverageData {
    double average;
    int sumCount;
}AverageData;

typedef struct T_FoodMenu {
    int nScore;
    QString strDay;
}TFoodMenu;

/**
 * @brief The QFoodMeun class
 */
class QFoodMeun : public QObject
{
    Q_OBJECT
public:
    explicit QFoodMeun(QObject *parent = nullptr);
    ~QFoodMeun();

    Q_INVOKABLE void fillMenuMap (const QString &strMenu, const int &nScore);
    Q_INVOKABLE QString getHistoryMenu ();

    /**
     * @brief saveMenuRate 将数据保存到file中
     */
    void saveMenuRate();

    void getMenuRate();

    QMap<QString, AverageData> calculateAverage(const QMultiMap<QString, int>& multiMap);

    QStringList genResult(const QMap<QString, AverageData>& map);

private:
    QMultiMap <QString, TFoodMenu> m_mapMenuRate;
    QFile m_file;

signals:
};

#endif // QFOODMEUN_H
