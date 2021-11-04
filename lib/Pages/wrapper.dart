import 'package:flutter/material.dart';
import 'package:practice_app/Pages/authentication%20screens/authenticate.dart';

import 'package:practice_app/Pages/homeScreen.dart';
import 'package:practice_app/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //grabs the value of the user from the stream and the provider
    /*every time a user logs in the user object from the stream will be 
    stored inside the user^ var*/
    //every time a user logs out it will be null

    //return either Home or Authenticate page depending on if signed in or not
    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }

    //using a stream
  }
}
