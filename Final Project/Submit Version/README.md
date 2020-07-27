# Final Project Description

## To-do List

## How to works

To-do list app provides basic features like adding a n item with a date time mark, set an y item into history list and remove any item from lists. Every modification is automatically saved on disk when leaving and loaded when views appear. 

![image](https://github.com/EthanRao/COMP-5970/blob/master/Final%20Project/IMG/home.jpg)

To add an item simply tap the plus button on the top right corner. A view containing a textbox a date picker and a add button appears. Enter the title of the item , pick the time related to it and tap the button bellow then a new item is set into the to do list.

![image](https://github.com/EthanRao/COMP-5970/blob/master/Final%20Project/IMG/add.jpg)

To check an item so it will be moved to the history list , just tap on it. A popup alert will tell you where it will be For any reason you want to remove an item from the to do list but don't want it to be kept in the history list you can tap the edit button on the left top corner then remove it. The same way you can delete any item in the history list.

![image](https://github.com/EthanRao/COMP-5970/blob/master/Final%20Project/IMG/home2.jpg)

![image](https://github.com/EthanRao/COMP-5970/blob/master/Final%20Project/IMG/attention.jpg)

![image](https://github.com/EthanRao/COMP-5970/blob/master/Final%20Project/IMG/del.jpg)

![image](https://github.com/EthanRao/COMP-5970/blob/master/Final%20Project/IMG/del2.jpg)

## Programming

The to do list app saves the data of to do list whenever an item is added or removed. The same to the history list. Data is saved by ***NSKeyedArchiver*** and loaded by ***NSKeyedUnarhiver***. To use these two storage accessing methods the class of an item implements the ***NSCoding***
protocol .

**By implementing the data source protocol and the delegate protocol the view s react to reloading and editing triggered by buttons.**

**Navigation be tween views is sup ported by the navigation controller s and the tab view.**

