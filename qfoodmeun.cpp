#include "qfoodmeun.h"
#include <QTextStream>
#include <QDebug>

QFoodMeun::QFoodMeun(QObject *parent)
    : QObject{parent}
{
    m_file.setFileName(QString("menu.txt"));
    if (!m_file.exists()) {
        if (m_file.open(QFile::WriteOnly)) {
            m_file.close();
        }
    }
    else {
        getMenuRate();
    }
}

QFoodMeun::~QFoodMeun()
{

}

void QFoodMeun::fillMenuMap(const QString &strMenu, const int &nScore)
{
    QDateTime date = QDateTime::currentDateTime();
    TFoodMenu foodMenu;

    if (!strMenu.isEmpty() && !strMenu.contains("...") && (nScore >= 1) && (nScore <= 5))
    {
        foodMenu.strDay = date.toString("yyyy-MM-dd");
        foodMenu.nScore = nScore;
        m_mapMenuRate.insert(strMenu, foodMenu);
    }
    saveMenuRate();
}

QString QFoodMeun::getHistoryMenu()
{
    QTextStream in(&m_file);
    QString strData;

    if (!m_file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "无法打开文件进行写入";
        return "";
    }
    while (!in.atEnd()) {
        strData += in.readLine();
        strData += "\n"; // 如果希望保留换行符，这里添加换行符，若不需要可省略
    }
    m_file.close();
    return strData;
}

void QFoodMeun::saveMenuRate()
{
    QTextStream out(&m_file);
    QMultiMap<QString, TFoodMenu>::const_iterator iter;

    if (!m_file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qDebug() << "无法打开文件进行写入";
        return;
    }
    for (iter = m_mapMenuRate.constBegin(); iter!= m_mapMenuRate.constEnd(); ++iter) {
        out <<  iter.key() << ": " << iter.value().strDay << ": " << iter.value().nScore << Qt::endl;
    }
    m_file.close();
}

void QFoodMeun::getMenuRate()
{
    QTextStream in(&m_file);

    if (!m_file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "无法打开文件进行读取";
        return;
    }
    m_mapMenuRate.clear();
    while (!in.atEnd()) {
        QString line = in.readLine();
        QStringList parts = line.split(":");
        if (parts.size() == 3) {
            TFoodMenu foodMenu;
            QString key = parts[0].trimmed();
            foodMenu.strDay = parts[1].trimmed();
            foodMenu.nScore =  parts[2].trimmed().toInt();
            m_mapMenuRate.insert(key, foodMenu);
        }
    }
    m_file.close();
}

QMap<QString, AverageData> QFoodMeun::calculateAverage(const QMultiMap<QString, int> &multiMap)
{
    QMap<QString, AverageData> averageMap;

    // 遍历 QMultiMap 中的每个键
    QMultiMap<QString, int>::const_iterator it = multiMap.constBegin();
    while (it!= multiMap.constEnd()) {
        QString key = it.key();
        // 获取具有相同键的所有值的列表
        QList<int> values = multiMap.values(key);

        // 计算这些值的总和
        int sum = 0;
        for (int value : values) {
            sum += value;
        }

        // 计算平均值并存储到 averageMap 中，同时记录总和次数
        double average = static_cast<double>(sum) / values.size();
        int sumCount = values.size();
        averageMap.insert(key, {average, sumCount});

        ++it;
    }

    return averageMap;
}

QStringList QFoodMeun::genResult(const QMap<QString, AverageData> &map)
{
    QStringList strResultList;
    QString strResult;
    QString strKey;
    int nSum = 0;
    double dAverage = 0;
    QMap<QString, AverageData>::const_iterator iter;

    for (iter = map.constBegin(); iter!= map.constEnd(); ++iter) {
        strKey = iter.key();
        nSum = iter.value().sumCount;
        dAverage = iter.value().average;
        strResult = "菜品<b>\"" + strKey + "\"</b>共烹饪<b>\"" + QString::number(nSum) + "\"</b>次，平均得分为:<b>\"" +  QString::number(dAverage, 'f', 2) + \
                    QString("\"</b>");
        strResultList.append(strResult);
    }

    return strResultList;
}
