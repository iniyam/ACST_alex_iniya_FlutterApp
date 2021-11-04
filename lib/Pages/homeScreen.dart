import 'package:flutter/material.dart';
import 'package:practice_app/Custom_Widgets/PublicVariables.dart' as globals;
import 'package:practice_app/Pages/settings.dart';
import 'package:practice_app/services/auth.dart';

//make sure to import this
class HomeScreen extends StatefulWidget {
  //stateful widgets are widgets that will be able to have
  //parts of them changed
  @override
  HomeScreenState createState() => HomeScreenState();
  //this is also the class widget that the route is linked to on main
}

class HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  //gives us access to this instance of AuthService (to access pre made methods)
  @override
  Widget build(BuildContext context) {
    print(globals.pagesPushed);
    return Scaffold(
        //this is the basic widget that contains the other widgets
        appBar: AppBar(
          //appbar widget is premade and has useful features
          //like a back button to link widgets
          backgroundColor: globals.colorSelected.getColor(),
          title: Text(
            'Welcome your Agenda',
            style: TextStyle(
              fontFamily: globals.fontFamily,
              fontWeight: globals.weight,
            ),
          ),
          centerTitle: true,
          leading:
              //creates settings button on top left of app bar
              IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              ).then((value) => setState(() {}));
            },
            icon: Icon(Icons.settings),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.black),
              label: Text('logout',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          //create new button ("+" at the bottom of the screen)
          onPressed: () {
            Navigator.of(context).pushNamed('/createNewScreen');
            print(globals.pagesPushed);
          },
          child: Text('+',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              )),
          backgroundColor: globals.colorSelected.getColor(),
        ),
        body: Container(
            color: Colors.white,
            child: Column(
              //child is a column widget because the buttons will be
              //displayed in a column format
              children: <Widget>[
                //children of type widget
                Container(height: MediaQuery.of(context).size.height / 8),
                TextButton.icon(
                  //button to bring to Calendar Screen
                  onPressed: () {
                    Navigator.of(context).pushNamed('/calendarScreen');
                    globals.pagesPushed++;
                    print(globals.pagesPushed);
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black, width: 1))),
                    backgroundColor: MaterialStateProperty.all(
                        globals.colorSelected.getColor()),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(7)),
                  ),
                  label: Text(
                    'View Calendar',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: globals.fontFamily,
                      fontWeight: globals.weight,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(height: MediaQuery.of(context).size.height / 8),
                TextButton.icon(
                  //button to bring to viewUnfinished Screen
                  onPressed: () {
                    Navigator.of(context).pushNamed('/viewUnfinished');
                    globals.pagesPushed++;
                    print(globals.pagesPushed);
                  },
                  icon: Icon(
                    Icons.assignment,
                    color: Colors.black,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black, width: 1))),
                    backgroundColor: MaterialStateProperty.all(
                        globals.colorSelected.getColor()),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(7)),
                    overlayColor: MaterialStateProperty.all(Colors.blue),
                  ),

                  label: Text(
                    'View Unfinished',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: globals.fontFamily,
                      fontWeight: globals.weight,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(height: MediaQuery.of(context).size.height / 8),
                TextButton.icon(
                  //button to bring to displayScreen
                  onPressed: () {
                    Navigator.of(context).pushNamed('/displayScreen');
                    globals.pagesPushed++;
                    print(globals.pagesPushed);
                  },
                  icon: Icon(
                    Icons.view_list,
                    color: Colors.black,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black, width: 1))),
                    backgroundColor: MaterialStateProperty.all(
                        globals.colorSelected.getColor()),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(7)),
                    overlayColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  label: Text(
                    'View Agendas',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: globals.fontFamily,
                      fontWeight: globals.weight,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )));
  }
}
