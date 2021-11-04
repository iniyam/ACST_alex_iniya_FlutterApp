import 'package:flutter/material.dart';
import 'package:practice_app/Custom_Widgets/Agenda_Widget.dart';
import 'package:practice_app/Custom_Widgets/PublicVariables.dart' as globals;

class CreateNewScreen extends StatefulWidget {
  @override
  CreateNewScreenState createState() => CreateNewScreenState();
  //this is where the route is linked
}

class CreateNewScreenState extends State<CreateNewScreen> {
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  // these controllers are essentially the text cursor that you see when you are typing
  String title;
  String name;
  String description;
  Agenda agenda;

  String selectedDate = DateTime.now().toString();

  //Creating an agenda variable and other variables to pass into agenda

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
//this is just for cleaning up the controllers when you are done typing

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.colorSelected.getColor(),
        title: Text('Create New Agenda'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: _selectDate,
            child: Text(
              'Select Date',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
          child: Column(
        //child is a column because columns and rows have the children
        //property which is needed for displaying multiple widgets
        children: <Widget>[
          Text(
            'Enter a Title for your agenda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          //text above the text field
          Container(
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height / 15)),
                  hintText: 'Enter A title'),
              onChanged: setT,
            ),
            //text field will use the setT function when it is changed
            //which assigns the text entered to the agenda title
            //*note, agenda variable is not actually changed until later on
            width: 400,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 75),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 20),
          ),

          Text(
            '  Enter Item name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          //Text above the second text field

          Container(
            child: TextField(
              controller: controller2,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height / 15)),
                  hintText: 'Enter a Name'),
              onChanged: setN,
            ),
            //when changed, sets assigns the name entered to the agenda item name
            //*note, the agenda variable is not actually changed until later on
            width: 400,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 75),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 20),
          ),

          Text(
            '  Enter Item Description',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          Container(
            child: TextField(
              controller: controller3,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height / 15)),
                  hintText: 'Enter a Description'),
              onChanged: setDesc,
            ),
            //sets agenda description to the text entered
            width: 400,
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          ),
          //Button used to open datepicker menu
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //this first if statement prevents the user from leaving a field
          //incomplete, this is necessary because submitting with empty fields
          //causes a crash
          if (getT() == null || getDesc() == null || getN() == null) {
            return null;
          }
          agenda = Agenda();
          agenda.setCreationDate(selectedDate);
          agenda.setTitle(getT());
          agenda.addItem(getN(), getDesc(), false, false);
          //the agendaDisplayIndex is set to null by default when the app starts
          //so it is set to 0 so it can assign the first index to the first agenda
          if (globals.agendaDisplayIndex == null) {
            globals.agendaDisplayIndex = 0;
          }
          //actually assigns the value to the agenda and increments it by 1 for the next agenda
          agenda.setDisplayIndex(globals.agendaDisplayIndex);
          globals.agendaDisplay.add(agenda);
          globals.agendaDisplayIndex++;
          Navigator.of(context).popAndPushNamed('/displayScreen');
          globals.pagesPushed++;
          print(globals.pagesPushed);

          //the agenda variable that was created earlier is initialized
          //using the imported constructor from the agenda widget.dart file.
          //the agenda is then using the imported methods from agendawidget.dart
          //and using the getter methods created at the bottom of this file to
          //fill in the parameters with what was entered into the text fields
          //it then adds the newly created agenda to the global agendaDisplay variable
          //and sends the user to the displayScreen
        },
        label: Text('Finish'),
        icon: Icon(Icons.check),
        backgroundColor: globals.colorSelected.getColor(),
      ),
    );
  }

  void _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(selectedDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != DateTime.parse(selectedDate))
      setState(() {
        selectedDate = picked.toString();
      });
  }

//Below are the methods for setting values used in the text form fields
//even though the string s parameter is never explicitly passed in,
//the textformfields will automatically pass in what they have as the string
  void setT(String s) {
    setState(() {
      title = s;
    });
  }

  void setN(String s) {
    setState(() {
      name = s;
    });
  }

  void setDesc(String s) {
    setState(() {
      description = s;
    });
  }

//Getter methods for passing in values to the imported methods that actually
//change the agenda variable
  String getT() {
    return title;
  }

  String getN() {
    return name;
  }

  String getDesc() {
    return description;
  }
}
