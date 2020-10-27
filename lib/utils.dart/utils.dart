import 'package:flutter/material.dart';

class Images {
  static const headerImage = const AssetImage('assets/images/placeholder.jpg');
  static const man1 = const AssetImage('assets/images/man1.jpg');
  static const man2 = const AssetImage('assets/images/man2.jpg');
  static const man3 = const AssetImage('assets/images/man3.jpg');
  static const man4 = const AssetImage('assets/images/man4.jpg');
  static const man5 = const AssetImage('assets/images/man5.jpg');

  static const woman1 = const AssetImage('assets/images/woman1.jpg');
  static const woman2 = const AssetImage('assets/images/woman2.jpg');
  static const woman3 = const AssetImage('assets/images/woman3.jpg');
  static const woman4 = const AssetImage('assets/images/woman4.jpg');
  static const woman5 = const AssetImage('assets/images/woman5.jpg');

  static const icon = const AssetImage('assets/images/icon.jpg');
  static const person = const AssetImage('assets/images/person.jpg');
}

class Fonts {
  static const primaryFont = "Quicksand";
}

class AppColors {
  static const primaryBlack = const Color(0xFF313544);
  static const primaryBlue = const Color(0xFF272F5F);
  static const secondaryColor = const Color(0xFFFF8C33);
}

class Texts {
  static const welcomeText = const Text(
    'Welcome!',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 28.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );
  static const profile = const Text(
    'My Contacts',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 20.0,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
  );
  static const loginText = const Text(
    'Login',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 28.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const signUpText = const Text(
    'SignUp',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 28.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const welcomeText2 = const Text(
    'Tap on a contact to send an alert. To send to all contacts, tap on Alert All!',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 16.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );

  static const welcomeText3 = const Text(
    'This app is developed for emergency use cases. If you are in a trouble, you can access your loved one by a single tap.',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 16.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );

  static const connectNowText = const Text(
    'Connect now with',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const nextText = const Text(
    'Next',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
  static const guestloginText = const Text(
    'Guest Login',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
  static const guestText = const Text(
    'Guest Login',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
  static const login = const Text(
    'Login',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
  static const addContact = const Text(
    'Submit',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
  static const editContact = const Text(
    'Edit Contact',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
  static const emergencyMessage = const Text(
    'Emergency Message',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );

  static const signup = const Text(
    'SignUp',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );

  static const headerTextTrade = const Text(
    'Trade',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 30.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const headerTextTrade2 = const Text(
    'I would like to trade:',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const headerTextTrade3 = const Text(
    'For:',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const headerTextTrade4 = const Text(
    'With:',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const makeOffer = const Text(
    'Make Offer',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 18.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );

  static const headerTextContact = const Text(
    'My Contacts',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 30.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const headerTextNewContact = const Text(
    'Add New Contact',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 27.0,
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static const alertText = const Text(
    'Alert All!',
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontSize: 45,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

class TabText {
  static const tabText1 = const Text(
    "Visible",
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
  );

  static const tabText2 = const Text(
    "Hidden",
    style: TextStyle(
      fontFamily: Fonts.primaryFont,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
  );
}
