import 'package:flutter/material.dart';
import 'package:safetyapp/_routing/routes.dart' as routes;
import 'package:safetyapp/utils.dart/utils.dart';

import '../utils.dart/utils.dart';

class LoginView extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController email2Controller = new TextEditingController();
  TextEditingController password2Controller = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController reenterpasswordController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
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
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Texts.loginText,
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              validator: (String email) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)) {
                                  return null;
                                } else {
                                  return 'Invalid email';
                                }
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email',
                              )))),
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              validator: (String password) {
                                if (password.length < 5) {
                                  return 'Password length must be at least 5 characters';
                                } else {
                                  return null;
                                }
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                              )))),
                  Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.pushNamed(
                                  context, routes.manageViewRoute);
                            }
                          },
                          child: Texts.login,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Form(
            key: _formKey2,
            child: Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Texts.signUpText,
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              controller: usernameController,
                              validator: (String name) {
                                if (name.length == 0) {
                                  return "Please enter an username";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Username',
                              )))),
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              validator: (String email) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)) {
                                  return null;
                                } else {
                                  return 'Invalid email';
                                }
                              },
                              controller: email2Controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email',
                              )))),
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              validator: (String password) {
                                if (password.length < 5) {
                                  return 'Password length must be at least 5 characters';
                                } else {
                                  return null;
                                }
                              },
                              controller: password2Controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                              )))),
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              validator: (String password2) {
                                if (password2Controller.text != password2) {
                                  return 'Passwords do not match';
                                } else {
                                  return null;
                                }
                              },
                              controller: reenterpasswordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Re-Enter Password',
                              )))),
                  Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (_formKey2.currentState.validate()) {
                              Navigator.pushNamed(
                                  context, routes.manageViewRoute);
                            }
                          },
                          child: Texts.signup,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
