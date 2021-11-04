import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:practice_app/Pages/calendarScreen.dart';
import 'package:practice_app/Pages/createNewScreen.dart';
import 'package:practice_app/Pages/homeScreen.dart';
import 'package:practice_app/Pages/viewUnfinished.dart';
import 'package:practice_app/Pages/wrapper.dart';
import 'package:practice_app/pages/settings.dart';
import 'package:practice_app/Pages/displayScreen.dart';
import 'package:practice_app/Pages/editingScreen.dart';
import 'package:practice_app/services/auth.dart';
import 'package:practice_app/models/user.dart';

//these imports are needed to allow the routing to work

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(StreamProvider<User>.value(
    initialData: null,
    /*StreamProvider package allows us to access the data provided by the 
    stream in any of the children widgets (all our other pages)
    This makes it so we can know the user auth status and then the wrapper
    knows what to return (sign in or home screen)*/
    value: AuthService().user,
    /*listens to the stream created in auth.dart creates an instance of 
    the AuthService so we can access the users on it*/
    child: MaterialApp(
      initialRoute: '/wrapper',
      //sets the initial route that the app goes to when it opens
      //the wrapper routes it to the authentication screen or the home scren
      //if already authenticated
      routes: {
        '/homeScreen': (context) => HomeScreen(),
        '/viewUnfinished': (context) => ViewUnfinished(),
        '/createNewScreen': (context) => CreateNewScreen(),
        '/displayScreen': (context) => DisplayScreen(),
        '/settings': (context) => Settings(),
        '/calendarScreen': (context) => CalendarScreen(),
        '/editingScreen': (context) => EditingScreen(),
        '/wrapper': (context) => Wrapper(),
        //sets the '/routename' to point to the widgets in the other dart
        //files
      },
    ),
  ));
}
