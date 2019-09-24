#include "windowcontrol.hh"
#include <QDebug>

WindowControl::WindowControl(QObject *parent) : QObject(parent)
{
    // nothing selected
    _selectedIndex = -1;
    // initing vector
    _boxes = new std::vector<QString>;
}

void WindowControl::activeboxchange(int index)
{
    _selectedIndex = index;
    // Emits this, because getcolor info is always selected rectange's color.
    emit getColorChanged(_boxes->at(_selectedIndex));
}

void WindowControl::addbox()
{
    // Creates new box to vector.
    _boxes->push_back("RED");
    // Set activebox index to last index.
    activeboxchange(_boxes->size() - 1);

    // Emits this because amount of boxes has changed.
    emit boxesamountChanged(_boxes->size());
    // Emits this, because getcolor info is always selected rectange's color.
    emit getColorChanged(_boxes->at(_selectedIndex));
}

void WindowControl::deletebox()
{
    // Checks if there is any boxes left.
    // _selectedIndex = -1 means that there is no boxes left.
    if(_selectedIndex != -1)
    {
        // Deletes the box that is at _selectedndex part of vector.
        _boxes->erase(_boxes->begin() + _selectedIndex);
        // Sets the active index to the last.
        _selectedIndex = _boxes->size()-1;
        // Emits this because amount of boxes has changed.
        emit boxesamountChanged(_boxes->size());

        // Checks if there is any boxes left.
        if(_boxes->size()!= 0)
        {
            // Emits this, because getcolor info is always selected rectange's color.
            emit getColorChanged(_boxes->at(_selectedIndex));
        }
    }
}

int WindowControl::getselectedindex()
{
    // Use of +1 because qml is using indexing beginning from 1.
    // and C++ is using indexing beginning from 0.
    return _selectedIndex + 1;
}

QString WindowControl::getIndexColor(int index)
{
    // Returns the color of selected box.
    // Real index is index - 1 because qml:s indexing start from 1 (Not 0 like C++).
    return _boxes->at(index - 1);
}

QString WindowControl::boxesamount()
{
    // Returns the whole sentece what is needed.
    return "There are " + QString::number(_boxes->size()) + " boxes";
}

QString WindowControl::getColor()
{
    // Checks if there is any boxes left and returns white if there is none.
    if(_selectedIndex == -1)
    {
        return "white";
    }

    // Gets the color of the box
    return _boxes->at(_selectedIndex);
}

void WindowControl::setGetcolor(QString color)
{
    // Checks if there is any boxes left and returns white if there is none.
    if(_boxes->size()!= 0)
    {
        // Changes selected boxes color
        _boxes->at(_selectedIndex) = color;
        // Emit this, because the selected boxes color has changed
        emit getColorChanged(color);
    }
}
