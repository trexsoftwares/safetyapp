import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safetyapp/_routing/routes.dart' as routes;
import 'package:safetyapp/services/auth.dart';
import 'package:safetyapp/services/database.dart';
import 'package:safetyapp/utils.dart/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: Images.man1),
                      border: Border.all(
                        color: Colors.white,
                        width: 5.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 32.0),
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
                    Positioned(
                      left: -25.0,
                      child: _buildUserImage(Images.man2, 50.0, 70.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildUserImage(Images.woman1, 36.0, 84.0),
                        _buildUserImage(Images.woman2, 56.0, 30.0),
                        _buildUserImage(Images.man3, 36.0, 90.0),
                        _buildUserImage(Images.woman4, 70.0, 0.0),
                      ],
                    ),
                    Positioned(
                      right: -10.0,
                      child: _buildUserImage(Images.woman3, 38.0, 100.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
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
                          await appAuth
                              .registerWithGoogle()
                              .whenComplete(() async {
                            SharedPreferences sharedPref =
                                await SharedPreferences.getInstance();
                            await sharedPref.setBool('logged', true);
                            Navigator.pushNamed(context, routes.emergViewRoute);
                          });
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
          ),
          Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, routes.manageViewRoute);
                  },
                  child: Texts.guestText,
                )
              ],
            ),
          )
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

  Widget _buildUserImage(AssetImage img, double size, double margin) {
    return Container(
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
    );
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
