import 'package:flutter/material.dart';
import 'package:practice_app/Custom_Widgets/Agenda_Widget.dart';
import 'package:practice_app/Custom_Widgets/PublicVariables.dart' as globals;

class EditingScreen extends StatefulWidget {
  @override
  EditingScreenState createState() => EditingScreenState();
}

class EditingScreenState extends State<EditingScreen> {
  String tempName;
  String tempDescription;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  String selectedDate = DateTime.now().toString();

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }

  //this simple itemTemplate just displays the items information
  Widget itemTemplate(Item item) {
    int index = globals.agendaDisplay[globals.currentIndex].getItemIndex(item);
    //this is the card that has all the other info on it including the buttons
    TextEditingController _editName =
        TextEditingController(text: item.getName());
    TextEditingController _editDesc =
        TextEditingController(text: item.getDescription());

    @override
    void dispose() {
      _editDesc.dispose();
      _editName.dispose();
      super.dispose();
    }

    return Card(
      child: Column(
        children: [
          Row(
            children: [
              //This is the edit button
              IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.orange,
                  onPressed: () {
                    //brings up a pop up screen for making changes to an item
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding:
                                const EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Edit Item'),
                                TextFormField(
                                  controller: _editName,
                                  onChanged: setName,
                                  decoration:
                                      InputDecoration(labelText: 'Item Name'),
                                ),
                                TextFormField(
                                  controller: _editDesc,
                                  onChanged: setDescription,
                                  decoration: InputDecoration(
                                      labelText: 'Item Description'),
                                ),

                                //Button that bring up an edit menu where user can input
                                //new name and description
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green)),
                                  onPressed: () {
                                    //This setState changes the global variable for agendadisplay
                                    //to have the new values and clears the controllers
                                    //also pops the menu
                                    setState(() {
                                      if (tempName != null) {
                                        globals
                                            .agendaDisplay[globals.currentIndex]
                                            .setName(index, tempName);
                                      }
                                      if (tempDescription != null) {
                                        globals
                                            .agendaDisplay[globals.currentIndex]
                                            .setDescription(
                                                index, tempDescription);
                                      }

                                      _editName.clear();
                                      _editDesc.clear();
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text('Save Changes'),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  padding: const EdgeInsets.fromLTRB(250, 0, 0, 0)),
            ],
          ),

          //These are the name and description of the item that will appear on screen
          Text('Name: ' + item.getName()),
          Text('Description: ' + item.getDescription()),

          //This is the delete button to remove an item from the agenda
          Row(
            children: [
              //Switch for Checked boolean
              Text('Checked'),
              Switch(
                value: item.getChecked(),
                onChanged: (bool newValue) {
                  setState(() {
                    item.setChecked(newValue);
                  });
                },
                activeColor: globals.colorSelected.getColor(),
              ),

              //Switch for Repeat boolean
              Text('Repeat'),
              Switch(
                value: item.getRepeat(),
                onChanged: (bool newValue) {
                  setState(() {
                    item.setRepeat(newValue);
                  });
                },
                activeColor: globals.colorSelected.getColor(),
              ),
              //container for formatting
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              ),
              //This calls the calendar function to pop up on the screen
              ElevatedButton(
                onPressed: () => _selectDate(index),
                child: Text(
                  'Select date',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        globals.colorSelected.getColor())),
              ),
              IconButton(
                onPressed: () {
                  //option to remove the item from the agenda using setstate to update
                  setState(() {
                    globals.agendaDisplay[globals.currentIndex]
                        .removeItem(index);
                  });
                },
                icon: Icon(Icons.delete),
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              )
            ],
          )
        ],
      ),
    );
  }

  //This is the formatting of the edit screen itself
  Widget build(BuildContext context) {
    //this pulls up the correct agenda using the currentIndex set in the display page
    List<Item> itemlist =
        globals.agendaDisplay[globals.currentIndex].getItemList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.colorSelected.getColor(),
        title: Text(globals.agendaDisplay[globals.currentIndex].getTitle()),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.view_agenda),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
              //this first column is the list of items in the agenda being displayed
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: itemlist.map((item) => itemTemplate(item)).toList()),

          //Add button to bring up menu to add a new item to the agenda that will
          //Appear below the column of items regardless of its length
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      //container that contains the fields to add items to the agenda
                      //this only appears when the add button is pressed
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('New Item Name'),
                            TextField(
                              controller: name,
                              onChanged: setName,
                            ),
                            Text('New Item Description'),
                            TextField(
                              controller: description,
                              onChanged: setDescription,
                            ),
                            TextButton(
                              child: Text("Add"),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green)),
                              onPressed: () {
                                //actually adds the item and uses setstate so the screen
                                //updates properly
                                setState(() {
                                  globals.agendaDisplay[globals.currentIndex]
                                      .addItem(tempName, tempDescription, false,
                                          false);
                                  name.clear();
                                  description.clear();
                                  //clears the text editors after an item is added

                                  //pops the dialog when finished
                                  Navigator.of(context).pop();
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
          )
        ],
      )),
    );
  }

  //These are the void methods that actually change the variables using the
  //values that will be passed in by the textFields
  void setName(String s) {
    setState(() {
      tempName = s;
      if (s == null) {
        tempName = '';
      }
    });
  }

  void setDescription(String s) {
    setState(() {
      tempDescription = s;
      if (s == null) {
        tempDescription = '';
      }
    });
  }

  //This brings up the calendar to select a date for the item
  _selectDate(int index) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(selectedDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != DateTime.parse(selectedDate))
      setState(() {
        selectedDate = picked.toString();
        globals.agendaDisplay[globals.currentIndex]
            .setDeadline(index, selectedDate);
      });
  }
}
