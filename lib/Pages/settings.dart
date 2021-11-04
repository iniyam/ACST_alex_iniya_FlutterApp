import 'package:flutter/material.dart';
import 'package:practice_app/Custom_Widgets/ColorWidget.dart';
import 'package:practice_app/Custom_Widgets/PublicVariables.dart' as globals;
import 'package:practice_app/Pages/homeScreen.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.colorSelected.getColor(),
        title: Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context, () {
              setState(() {});
            });
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 100.0, top: 10.0),
              //padding outside container/box
              child: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                //padding within container/box around the dropdown
                decoration: BoxDecoration(
                  border: Border.all(
                      color: globals.colorSelected.getColor(), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<ColorWidget>(
                    hint: Text(
                      'Choose your theme color',
                    ), // words of dropdown
                    isExpanded: true,
                    iconSize: 36.0,
                    items:
                        globals.themeOptions.map((ColorWidget dropdownColor) {
                      return DropdownMenuItem<ColorWidget>(
                          value: dropdownColor,
                          //value of selected dropdown is the ColorWidget
                          child: Row(
                            children: <Widget>[
                              dropdownColor
                                  .colorIcon, //circle icon to display oolor
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                dropdownColor
                                    .colorName, //name of color of dropdown option
                                style:
                                    TextStyle(color: dropdownColor.iconColor),
                              ),
                            ],
                          ));
                    }).toList(),
                    //creates map to go through list of ColorWidgets (themeOptions)
                    //sets value of each button in dropdown to the ColorWidget
                    //sets text of each button in dropdown to name of the ColorWidget
                    onChanged: (ColorWidget dropdownValue) {
                      setState(() {
                        globals.colorSelected = dropdownValue;
                      });
                      //when dropdown option pressed, changes value of colorSelected
                      //to the selected color widget
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 80.0, top: 10),
              //padding outside the container
              child: Container(
                padding: EdgeInsets.only(),
                //padding within the container
                decoration: BoxDecoration(
                  border: Border.all(
                      color: globals.colorSelected.getColor(), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ), // creates a box (decoration) around checkbox tile
                child: CheckboxListTile(
                    title: Text("Do you want notifications?"),
                    controlAffinity: ListTileControlAffinity.leading,
                    //puts the checkbox to the left of the text
                    value: globals.notifications,
                    //value of the global notification variable is true if checked
                    //false if not checked
                    onChanged: (bool checked) {
                      setState(() {
                        globals.notifications = checked;
                      });
                      //sets value T/F to global notification variable
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
