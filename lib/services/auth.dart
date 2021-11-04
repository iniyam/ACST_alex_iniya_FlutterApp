import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practice_app/models/user.dart';

class AuthService {
  //creating our own class in order to access the premade authentication methods

  final FirebaseAuth _auth = FirebaseAuth.instance;
  /*property to get us a firebase auth instance
  the final means its value won't change
  the _ means its a private variable
  gives us access to all the methods in this premade class*/

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //create user object based on the FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(uid: user.uid);
    }
    /*means if user not null, will return type User (from class we created)
    with the uid property - if not true will return null */
  }

  //the stream will listen for changes in authentication
  //will return a User if user signs in
  //will return null if user signs out
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    /*passes the FirebaseUser we get from the stream into the User object  
    we created using the premade function _userFromFirebaseUser */
  }

  //sign in anon (asynch task, will return a future)
  Future signInAnon() async {
    //try+catch means that will try first, if that doesn't work, will catch error
    //the method will try and sign in and if it succeeds will return user object
    try {
      AuthResult result = await _auth.signInAnonymously();
      //signInAnon method returns type AuthResult
      //the method is from the premade FirebaseAuth class of the variable
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
      //the result var will give us access to the user info which we made
      //another var to store into
    } catch (e) {
      //if there's an error (e), this part will catch it
      print(e.toString());
      return null;
    }
  }

  //sign in w google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      //this is the info from the pop up sign w google
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
      //sign out method part of premade FirebaseAuth library
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
