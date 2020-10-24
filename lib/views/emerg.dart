import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safetyapp/_routing/routes.dart' as routes;
import 'package:safetyapp/services/auth.dart';
import 'package:safetyapp/services/database.dart';
import 'package:safetyapp/utils.dart/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/sms.dart';

class EmergView extends StatelessWidget {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final String uuid = _auth.currentUser.uid;
  static final DatabaseService databaseService = DatabaseService(uuid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: ClipPath(
                  clipper: ClippingClass(),
                  child: Container(
                    height: 130.0,
                    decoration: BoxDecoration(color: AppColors.primaryBlack),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FutureBuilder(
                      future: databaseService.proPicURL(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return GestureDetector(
                              onTap: () {
                                navigateToProfile(context);
                              },
                              child: Container(
                                height: 90.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(snap.data)),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5.0,
                                  ),
                                ),
                              ));
                        } else {
                          return Container(
                            height: 90.0,
                            width: 90.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: Images.icon),
                              border: Border.all(
                                color: Colors.white,
                                width: 5.0,
                              ),
                            ),
                          );
                        }
                      }),
                ),
              )
            ],
          ),
          FlatButton(
              onPressed: () {
                navigateToProfile(context);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 1.0),
                child: Column(
                  children: <Widget>[
                    Texts.profile,
                  ],
                ),
              )),
          Container(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: <Widget>[
                Texts.welcomeText,
                Padding(
                  padding:
                      const EdgeInsets.only(top: 22.0, left: 42.0, right: 42.0),
                  child: Center(child: Texts.welcomeText2),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildUserImage(Images.woman1, 56.0, 30.0, 1),
                        _buildUserImage(Images.woman2, 56.0, 90.0, 2),
                        _buildUserImage(Images.man3, 56.0, 30.0, 3),
                        _buildUserImage(Images.woman4, 56.0, 90.0, 4),
                        _buildUserImage(Images.woman4, 56.0, 30.0, 5),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          /* Container(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: <Widget>[
                Texts.connectNowText,
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Container(
                      height: 60.0,
                      width: 60.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(12.0),
                        elevation: 34.0,
                        shadowColor: Colors.white70,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, routes.loginViewRoute);
                          },
                          child: Icon(
                            FontAwesomeIcons.envelope,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                        child: _buildIconCard(FontAwesomeIcons.google),
                        onLongPress: () async {
                          final AppAuth appAuth = AppAuth(_auth);
                          await appAuth.registerWithGoogle().whenComplete(() =>
                              Navigator.pushNamed(
                                  context, routes.manageViewRoute));
                        }),
                    /*_buildIconCard(FontAwesomeIcons.google),
                      SizedBox(
                        width: 10.0,
                      ),
                      _buildIconCard(FontAwesomeIcons.instagram),
                      SizedBox(
                        width: 10.0,
                      ),
                      _buildIconCard(FontAwesomeIcons.linkedinIn),*/
                  
                  ],
                )
              ],
            ),
          ),*/
          Container(
              padding: EdgeInsets.only(bottom: 30.0),
              child: GestureDetector(
                  onTap: () async {
                    sendAll();
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: MediaQuery.of(context).size.width / 4,
                      child: Texts.alertText))),
        ],
      ),
    );
  }

  Widget _buildIconCard(IconData icon) {
    return Container(
      height: 60.0,
      width: 60.0,
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 34.0,
        shadowColor: Colors.white70,
        child: FlatButton(
          onPressed: () {},
          child: Icon(
            icon,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildUserImage(
      AssetImage img, double size, double margin, int person) {
    return GestureDetector(
        onTap: () async {
          SharedPreferences sharedPref = await SharedPreferences.getInstance();
          String number = sharedPref.getString('$person');
          number != null ? sendMsg(number) : null;
        },
        child: Column(children: <Widget>[
          Text('Person'),
          Container(
            margin: EdgeInsets.only(bottom: margin),
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: img,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]));
  }

  void navigateToProfile(context) async {
    Navigator.pushNamed(context, routes.manageViewRoute);
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('logged', false);
  }

  void sendMsg(String number) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //sendSMS(message: 'test', recipients: ['0766721100']);
    SmsSender sender = new SmsSender();
    String address = number;
    sender.sendSms(new SmsMessage(address,
        'https://www.google.com/maps/?q=${position.latitude},${position.longitude}'));
    print(
        'https://www.google.com/maps/?q=${position.latitude},${position.longitude}');
  }

  void sendAll() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List<String> numbers = [];
    for (int i = 1; i < 6; i++) {
      String number = sharedPref.getString('$i');
      print(number);
      if (number == null) break;
      numbers.add(number);
    }
    numbers.forEach((element) async {
      sendMsg(element);
    });
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - (size.width / 4),
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
