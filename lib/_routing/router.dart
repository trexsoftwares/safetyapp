import 'package:flutter/material.dart';
import 'package:safetyapp/views/addContact.dart';
import 'package:safetyapp/views/home.dart';
import 'package:safetyapp/views/login.dart';
import 'package:safetyapp/views/manage.dart';
import 'package:safetyapp/views/trade.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeViewRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    case tradeViewRoute:
      return MaterialPageRoute(builder: (context) => TradeView());
    case manageViewRoute:
      return MaterialPageRoute(builder: (context) => ManageView());
    case loginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginView());
    case addContactViewRoute:
      return MaterialPageRoute(builder: (context) => AddContactView());
      break;
    default:
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}
