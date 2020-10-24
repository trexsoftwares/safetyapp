import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safetyapp/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import '_routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool logged = sharedPref.getBool('logged');
  String logintype = sharedPref.getString('loginType');
  User user = _auth.currentUser;
  print(logged);
  print(logintype);

  (logged == null) ? logged = false : null;

  Firebase.initializeApp().whenComplete(() {
    logged
        ? runApp(App(route: emergViewRoute))
        : runApp(App(route: homeViewRoute));
  });
}
