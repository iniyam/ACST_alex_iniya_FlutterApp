import 'package:flutter/material.dart';

//ColorWidget class
//each Color Widget has a name (the color), its color,
//& a circle icon of that color
class ColorWidget {
  String colorName;
  Color iconColor;
  Icon colorIcon;

  ColorWidget(String colorName, Color iconColor) {
    this.colorName = colorName;
    this.iconColor = iconColor;
    colorIcon = Icon(Icons.fiber_manual_record, color: iconColor);
  }

  Color getColor() {
    return iconColor;
  }
  //method to return color of ColorWidget
}
