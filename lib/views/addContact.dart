import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:safetyapp/utils.dart/utils.dart';
import 'package:safetyapp/_routing/routes.dart' as routes;
import 'package:shared_preferences/shared_preferences.dart';

class AddContactView extends StatefulWidget {
  @override
  _AddContactViewState createState() => _AddContactViewState();
}

class _AddContactViewState extends State<AddContactView>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController relationController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
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
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlack,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),*/
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
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
                  Positioned(
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
                  ),
                  /* Positioned(
                    top: 25.0,
                    right: 20.0,
                    child: IconButton(
                      icon: Icon(
                        LineIcons.edit,
                        color: Colors.white70,
                        size: 35.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),*/
                ],
              ),
            ),
            Positioned(
              top: 40.0,
              left: 20.0,
              bottom: 0.0,
              child: Container(
                padding: EdgeInsets.only(left: 15.0, top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Texts.headerTextNewContact,
                    SizedBox(
                      height: 10.0,
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
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: TextFormField(
                                        validator: (String name) {
                                          if (name.length > 0) {
                                            return null;
                                          } else {
                                            return 'Please Enter a Name';
                                          }
                                        },
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Enter Name',
                                        )))),
                            SizedBox(height: 10),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: TextFormField(
                                        validator: (String relationship) {
                                          if (relationship.length > 0) {
                                            return null;
                                          } else {
                                            return 'Please Enter the Relationship';
                                          }
                                        },
                                        controller: relationController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Enter Relationship',
                                        )))),
                            SizedBox(height: 10),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        validator: (String number) {
                                          if (number.length != 10) {
                                            return 'Please Enter a valid Phone Number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Enter Telephone Number',
                                        )))),
                            Container(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        _save(
                                            nameController.text,
                                            relationController.text,
                                            phoneController.text);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Texts.addContact,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  _save(String name, String relationship, String telephone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 1;
    while (true) {
      var data = prefs.getStringList(i.toString()) ?? 0;
      if (data == 0) {
        prefs.setStringList(i.toString(), [name, relationship, telephone]);
        break;
      } else {
        i = i + 1;
      }
    }

    print('saved');
  }
}
