#ifndef WINDOWCONTROL_HH
#define WINDOWCONTROL_HH

#include <QObject>
#include <QVariant>
#include <vector>

/**
 * @brief The WindowControl class
 * Notice that the rectangle selected after deleting another one is always
 * the lastly created rectangle.
 */

class WindowControl : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString boxesamount READ boxesamount NOTIFY boxesamountChanged)
    Q_PROPERTY(QString getColor READ getColor WRITE setGetcolor
               NOTIFY getColorChanged)

public:
    explicit WindowControl(QObject *parent = nullptr);

    // Functions that can be used straigth from QML
    // They can get parameters and return values

    /**
     * @brief changes _selectedindex to parameter index
      */
    Q_INVOKABLE void activeboxchange(int index);

    /**
     * @brief adds box to vector and emitts getColorChanged and
     * boxesamountChanged
      */
    Q_INVOKABLE void addbox();
    /**
     * @brief deletesbox from vector and emitts getColorChanged (and
     * boxesamountChanged if needed)
      */
    Q_INVOKABLE void deletebox();
    /**
     * @brief returns _selectedindex + 1
      */
    Q_INVOKABLE int getselectedindex();
    /**
     * @brief returns color of _boxes.at(index)
      */
    Q_INVOKABLE QString getIndexColor(int index);

    /**
     * @brief setGetcolor sets a color to rectangle
     * @param color, the color of choice
     */
    void setGetcolor(QString color);

signals:
    /**
     * @brief boxesamountChanged, Emitted when there is channge in
     * rectangle amount
     * @param amount, new amount of rectangles
     */
    void boxesamountChanged(int amount);
    /**
     * @brief getColorChanged, Emitted when a rectangles color is changed
     * @param color, color what is changed to selected box
     */
    void getColorChanged(QString color);

private:
    /**
     * @brief boxesamount returns string that is needed
     */
    QString boxesamount();

    /**
     * @brief getColor returns color from  _boxes at (_selectedIndex)
     */
    QString getColor();



    // if _selectedIndex = -1, there is notihing selected
    int _selectedIndex;

    // vector for boxes
    std::vector<QString> *_boxes;
};

#endif // WINDOWCONTROL_HH
