library app.globals;

import 'package:flutter/material.dart';
import 'package:practice_app/Custom_Widgets/Agenda_Widget.dart';
import 'package:practice_app/Custom_Widgets/ColorWidget.dart';

//imported agenda widget to be able to make a list of type Agenda
//This creates the global variable named agendaDisplay used throughout the app
List<Agenda> agendaDisplay = [];

//creates+stores the ColorWidget that is the current color/theme for all screens
ColorWidget colorSelected = ColorWidget('purple', Colors.purple);

//creates list ColorWidgets of available theme colors (for dropdown menu)
List<ColorWidget> themeOptions = [
  ColorWidget('red', Colors.red),
  ColorWidget('blue', Colors.blue),
  ColorWidget('pink', Colors.pink),
  ColorWidget('purple', Colors.purple),
];
//this is the global variable that will have a different value for each agenda as
//as it increases
int agendaDisplayIndex;
//this current index will be a malleable variable that will change depending
//on the agenda selected and will serve to point the editing screen to the correct index
int currentIndex;

//bool whether user wants notifications
//starting value is false (no notifications)
bool notifications = false;

//font family for throughout the app
String fontFamily = 'Montserrat';
//specific font weight/style
//access "light" with w300, "regular" with w400, and "bold" with w500
FontWeight weight = FontWeight.w400;

int pagesPushed = 0;
//keeps track of how many pages are pushed over the homeScreen
//whenever hit the home button on any screen, will pop until this int is 0