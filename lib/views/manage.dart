import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:safetyapp/services/database.dart';
import 'package:safetyapp/utils.dart/utils.dart';
import 'package:safetyapp/_routing/routes.dart' as routes;
import 'package:safetyapp/views/emerg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';

class ManageView extends StatefulWidget {
  @override
  _ManageViewState createState() => _ManageViewState();
}

class _ManageViewState extends State<ManageView>
    with SingleTickerProviderStateMixin {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final User user = _auth.currentUser;
  static final DatabaseService databaseService =
      DatabaseService(user != null ? user.uid : 'guest');
  TabController tabController;
  String data = '';
  bool edit = false;
  TextEditingController messageController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryBlack,
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            int count = 0;
            for (int i = 0; i < 5; i++) {
              var data = prefs.getStringList(i.toString()) ?? 0;
              if (data == 0) {
                Navigator.pushNamed(context, routes.addContactViewRoute);
                break;
              } else {
                count = count + 1;
              }
              if (count == 5) {
                Flushbar(
                  title: 'Limit Reached',
                  message: 'You can only add up to 5 contacts',
                  icon: Icon(
                    Icons.error_outline,
                    size: 28,
                    color: Colors.green.shade300,
                  ),
                  leftBarIndicatorColor: Colors.blue.shade300,
                  duration: Duration(seconds: 3),
                )..show(context);
              }

// Find the Scaffold in the widget tree and use it to show a SnackBar.

            }
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 35.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EmergView())),
                  icon: Icon(
                    LineIcons.long_arrow_left,
                    color: AppColors.primaryBlack,
                    size: 35.0,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
              ),
              Container(
                height: 300.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      bottom: 0,
                      top: -260.0,
                      right: -1100.0 + (MediaQuery.of(context).size.width),
                      child: Container(
                        height: 300.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                    ),
                    /* Positioned(
                    top: 25.0,
                    left: 20.0,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        LineIcons.long_arrow_left,
                        color: AppColors.primaryBlack,
                        size: 35.0,
                      ),
                    ),
                  ),*/
                  ],
                ),
              ),
              Positioned(
                  top: 50,
                  right: 15,
                  child: FutureBuilder(
                      future: databaseService.proPicURL(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return Container(
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
                          );
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
                      })),
              Positioned(
                top: 40.0,
                left: 0.0,
                bottom: 0.0,
                child: Container(
                  padding: EdgeInsets.only(left: 0.0, top: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width - 360),
                          child: Texts.headerTextContact),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 55,
                      ),
                      /*   TabBar(
                      controller: tabController,
                      indicatorColor: Colors.transparent,
                      labelColor: AppColors.secondaryColor,
                      unselectedLabelColor: AppColors.primaryBlack,
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(right: 25.0),
                      tabs: <Widget>[
                        Tab(
                          child: TabText.tabText1,
                        ),
                        Tab(
                          child: TabText.tabText2,
                        )
                      ],
                    ),*/
                      FutureBuilder(
                        future: getData(context),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapshot.data);
                          } else {
                            // We can show the loading view until the data comes back.

                            return _buildTile(Color(0xFF6967B8),
                                'No Contacts Added', '', '', context, 100);
                          }
                        },
                      ),
                      FutureBuilder(
                          future: messageData(context),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        900,
                                    right:
                                        MediaQuery.of(context).size.width / 50,
                                    left:
                                        MediaQuery.of(context).size.width / 50),
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 10,
                                  child: edit
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Texts.emergencyMessage,
                                            ListTile(
                                              leading: Icon(Icons.message,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10),
                                              trailing: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(10.0),
                                                  ),
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20, right: 20),
                                                      child: TextFormField(
                                                          autofocus: true,

                                                          /*  validator: (String name) {
                                if (name.length > 0) {
                                  return null;
                                } else {
                                  return 'Please Enter a Name';
                                }
                              },*/
                                                          controller:
                                                              messageController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            labelText:
                                                                'Enter Message',
                                                          )))),
                                            ),
                                            ButtonTheme.bar(
                                              child: ButtonBar(
                                                children: <Widget>[
                                                  FlatButton(
                                                    child: const Text('Save',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    onPressed: () async {
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString(
                                                          'message',
                                                          messageController
                                                              .text);
                                                      try {
                                                        FirebaseAuth _auth =
                                                            FirebaseAuth
                                                                .instance;
                                                        User user =
                                                            _auth.currentUser;
                                                        if (user != null) {
                                                          DatabaseService
                                                              databaseService =
                                                              DatabaseService(
                                                                  user.uid);
                                                          await databaseService
                                                              .setEditMessage(
                                                                  messageController
                                                                      .text);
                                                        }
                                                      } catch (e) {}
                                                      setState(() {
                                                        edit = false;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Texts.emergencyMessage,
                                            ListTile(
                                              leading: Icon(Icons.message,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10),
                                              title: Text(snapshot.data,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              subtitle: Text(
                                                  '\nCURRENT LOCATION',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                            ButtonTheme.bar(
                                              child: ButtonBar(
                                                children: <Widget>[
                                                  FlatButton(
                                                    child: const Text('Edit',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    onPressed: () {
                                                      setState(() {
                                                        edit = true;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          })
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width / 2.5,
                  bottom: 10,
                  child: FlatButton(
                    onPressed: () async {
                      try {
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        AppAuth appAuth = AppAuth(_auth);
                        await appAuth.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            routes.homeViewRoute, (route) => false);
                      } catch (e) {}
                    },
                    child: Text('Logout',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
            ],
          ),
        ),
      ),
      onWillPop: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(routes.emergViewRoute, (route) => false);
      },
    );
  }

  messageData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.get('message') ?? '0';
    if (data == '0') {
      return 'Please Help Me I am in trouble!!!. This is my location now\n';
    } else {
      return data;
    }
  }

  getData(context) async {
    List<Widget> tabs = [];
    List colours = [
      Color(0xFFFF7B2B),
      Color(0xFF62BCC4),
      Color(0xFF6967B8),
      Color(0xFFD4E157),
      Color(0xFF42A5F5)
    ];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < 5; i++) {
      var data = prefs.getStringList(i.toString()) ?? 0;
      if (data == 0) {
        print("NO DATA");
      } else {
        List info = prefs.getStringList(i.toString());
        print(info);
        tabs.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
            color: Colors.red,
            onPressed: () async {
              setState(() {});
              prefs.remove(i.toString());
              try {
                FirebaseAuth _auth = FirebaseAuth.instance;
                User user = _auth.currentUser;
                if (user != null) {
                  DatabaseService databaseService = DatabaseService(user.uid);
                  await databaseService.deleteContacts(i.toString());
                }
              } catch (e) {}
              Flushbar(
                title: 'Done',
                message: 'Deleted Contact Successfully',
                icon: Icon(
                  Icons.beenhere,
                  size: 28,
                  color: Colors.green.shade300,
                ),
                leftBarIndicatorColor: Colors.blue.shade300,
                duration: Duration(seconds: 3),
              )..show(context);
            },
            icon: Icon(Icons.delete),
          ),
          _buildTile(colours[i], info[0], info[1], info[2], context, i)
        ]));

        tabs.add(SizedBox(
          height: MediaQuery.of(context).size.height / 150,
        ));
      }
    }
    if (tabs == []) {
      tabs.add(Container());
    }
    return tabs;
  }

  Widget _buildUserImage(AssetImage img, double size, double margin) {
    return Container(
      alignment: Alignment.centerRight,
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

Widget _buildTile(Color color, String name, String relationship,
    String telephone, BuildContext context, int i) {
  TextEditingController nameController = new TextEditingController();
  TextEditingController relationshipController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  nameController.text = name;
  relationshipController.text = relationship;
  numberController.text = telephone;

  return GestureDetector(
      onTap: () async {
        await showDialog<String>(
          context: context,
          child: new AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(16.0),
            content: Form(
              child: Column(
                children: <Widget>[
                  Texts.editContact,
                  // SizedBox(height: MediaQuery.of(context).size.height / 600),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              autofocus: true,

                              /*  validator: (String name) {
                                if (name.length > 0) {
                                  return null;
                                } else {
                                  return 'Please Enter a Name';
                                }
                              },*/
                              controller: nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter Name',
                              )))),
                  // SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              autofocus: true,

                              /*  validator: (String relationship) {
                                if (relationship.length > 0) {
                                  return null;
                                } else {
                                  return 'Please Enter the Relationship';
                                }
                              },*/
                              controller: relationshipController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter Relationship',
                              )))),
                  //  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              /*  validator: (String number) {
                                if (number.length != 10) {
                                  return 'Please Enter a valid Phone Number';
                                } else {
                                  return null;
                                }
                              }*/
                              controller: numberController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter Telephone Number',
                              )))),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('SAVE'),
                  onPressed: () async {
                    if (nameController.text.length == 0) {
                      Flushbar(
                        title: 'Enter a name',
                        message: 'Please enter a name for the user',
                        icon: Icon(
                          Icons.error_outline,
                          size: 28,
                          color: Colors.green.shade300,
                        ),
                        leftBarIndicatorColor: Colors.blue.shade300,
                        duration: Duration(seconds: 3),
                      )..show(context);
                    } else if (relationshipController.text.length == 0) {
                      Flushbar(
                        title: 'Enter a relationship',
                        message: 'Please enter a relationship for the user',
                        icon: Icon(
                          Icons.error_outline,
                          size: 28,
                          color: Colors.green.shade300,
                        ),
                        leftBarIndicatorColor: Colors.blue.shade300,
                        duration: Duration(seconds: 3),
                      )..show(context);
                    } else if (numberController.text.length != 10) {
                      Flushbar(
                        title: 'Wrong Number',
                        message: 'Please check the phone number',
                        icon: Icon(
                          Icons.error_outline,
                          size: 28,
                          color: Colors.green.shade300,
                        ),
                        leftBarIndicatorColor: Colors.blue.shade300,
                        duration: Duration(seconds: 3),
                      )..show(context);
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setStringList(i.toString(), [
                        nameController.text,
                        relationshipController.text,
                        numberController.text
                      ]);
                      try {
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        User user = _auth.currentUser;
                        if (user != null) {
                          DatabaseService databaseService =
                              DatabaseService(user.uid);
                          await databaseService.addEditContacts(
                              nameController.text,
                              relationshipController.text,
                              numberController.text,
                              i.toString());
                        }
                      } catch (e) {}
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        );
      },
      child: Container(
        height: 80.0,
        width: MediaQuery.of(context).size.width - 60.0,
        decoration: BoxDecoration(
          color: color.withAlpha(220),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.elliptical(90.0, 110.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  decoration: BoxDecoration(color: color),
                ),
              ),
            ),
            Positioned(
              top: 15.0,
              left: 20.0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: Fonts.primaryFont,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      relationship,
                      style: TextStyle(
                        fontFamily: Fonts.primaryFont,
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 23.0,
              right: 20.0,
              child: Text(
                telephone,
                style: TextStyle(
                  fontFamily: Fonts.primaryFont,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
            ),
          ],
        ),
      ));
}
