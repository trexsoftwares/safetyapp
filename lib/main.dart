import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safetyapp/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import '_routing/routes.dart';
import 'services/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();

  bool logged = sharedPref.getBool('logged');
  String logintype = sharedPref.getString('loginType');

  (logged == null) ? logged = false : null;

  Firebase.initializeApp().whenComplete(() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User user = _auth.currentUser;

    if (user != null) {
      DatabaseService databaseService = DatabaseService(user.uid);
      await databaseService.syncData();
    print(logged);
    print(logintype);
    logged
        ? runApp(App(route: emergViewRoute))
        : runApp(App(route: homeViewRoute));
  });
}
