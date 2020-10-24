import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import '_routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  bool logged = await sharedPref.getBool('logged');
  print(logged);
  logged == null ? logged = false : null;
  Firebase.initializeApp().whenComplete(() {
    logged
        ? runApp(App(route: emergViewRoute))
        : runApp(App(route: homeViewRoute));
  });
}
