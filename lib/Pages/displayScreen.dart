import 'package:flutter/material.dart';
import 'package:practice_app/Custom_Widgets/Agenda_Widget.dart';
import 'package:practice_app/Custom_Widgets/PublicVariables.dart' as globals;

class DisplayScreen extends StatefulWidget {
  @override
  DisplayScreenState createState() => DisplayScreenState();
  //this is where the route is linked
}

//This is created as a stateless widget so it can be changed

//This creates and agendaTemplate widget that is what creates the individual
//cards that will be displayed on screen
class DisplayScreenState extends State<DisplayScreen> {
  Widget agendaTemplate(Agenda agenda) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            agenda.getTitle(),
            //even though not title is assigned currently, when this method is
            //actually used, it will be passed in an agenda that already has
            //values assigned
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            agenda.itemString(),
            //again, these values will be passed in, this is just the toString
            //for all values except the title
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.blue,
            ),
          ),
          SizedBox(
              height: 30,
              child: Row(
                children: [
                  IconButton(
                    //make sure to use a flatbutton or iconbutton when making
                    //multiple buttons on the same screen because floatingactionbuttons
                    //tend to freak out when there are multiple
                    onPressed: () {
                      //sets the current index before sending the user to the screen
                      //this allows the edit screen to use the currentIndex
                      //to pull up the correct agenda
                      globals.currentIndex = agenda.getDisplayIndex();
                      Navigator.of(context).pushNamed('/editingScreen');
                      print(globals.pagesPushed);
                    },
                    icon: Icon(Icons.edit),

                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  //iconbutton to remove agendas from the list
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      //whenver changing something that affects the display of
                      //the screen make sure to use setState so the builder can
                      //update properly
                      setState(() {
                        globals.agendaDisplay.remove(agenda);
                        if (globals.agendaDisplay.length == 0) {
                          globals.agendaDisplayIndex = null;
                        }
                      });
                    },
                    padding: const EdgeInsets.fromLTRB(160, 0, 0, 0),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.colorSelected.getColor(),
        title: Text('Agenda List'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            while (globals.pagesPushed > 0) {
              Navigator.pop(context);
              globals.pagesPushed--;
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        //this body type is used to allow the screen to become scrollable
        //when enough cards are created that it would normally overflow the screen
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: globals.agendaDisplay
                .map((agenda) => agendaTemplate(agenda))
                .toList()),
        //Uses the global agendaDisplay variable and iterates through it using the
        //.map function. Then the agenda variable type is specified as the type of item
        //to be looked at while iterating. Then it points to the agendaTemplate function
        //with whatever the current item being looked at as what will be passed in.
        //Finally the.toList is needed to add what is created by the agendaTemplate
        // to the widget list created by the children parameter.
      ),
    );
  }
}
