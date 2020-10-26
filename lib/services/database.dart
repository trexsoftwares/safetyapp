import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final String uuid;

  DatabaseService(this.uuid);
  ///////////////// refs///////////////////////////////////////////////////
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  final FirebaseStorage firebaseStorage = FirebaseStorage(
      storageBucket: 'gs://t-rex-safety-app-ea3f7.appspot.com/');

///////////////////////////Database tasks////////////////////////////////////
  Future register(String email, String fName, String lName, String uid,
      String photoUrl) async {
    var data = await userCollection.doc(uuid).get();
    return !data.data().containsValue('email')
        ? await userCollection.doc(uid).set({
            'email': email,
            'fName': fName,
            'lName': lName,
            'uuid': uid,
            'proPic': photoUrl
          })
        : true;
  }

  Future syncData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    for (int i = 0; i < 5; i++) {
      try {
        List<String> contact = sharedPref.getStringList('$i');
        String message = sharedPref.getString('message');
        await addEditContacts(contact[0], contact[1], contact[2], '$i');
        await setEditMessage(message);
        if (contact == null) {
          await userCollection.doc(uuid).update({'$i': null});
        }
      } catch (e) {}
    }
  }

  Future addEditContacts(
      String name, String relationship, String number, String pos) async {
    var data = await userCollection.doc(uuid).get();
    var contact = data.data()[pos];
    return await userCollection.doc(uuid).update({
      pos: [
        name != null ? name : contact[0],
        relationship != null ? relationship : contact[1],
        number != null ? number : contact[2]
      ]
    });
  }

  Future setEditMessage(String message) async {
    return await userCollection.doc(uuid).update({'message': message});
  }

  Future deleteContacts(String pos) async {
    return await userCollection.doc(uuid).update({pos: null});
  }

  Future getContacts() async {
    var data = await userCollection.doc(uuid).get();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    for (int i = 0; i < 5; i++) {
      try {
        print(data.data()['$i']);
        await sharedPref.setStringList(i.toString(),
            [data.data()['$i'][0], data.data()['$i'][1], data.data()['$i'][2]]);
      } catch (e) {}
    }
  }

  Future setProPic() async {
    String proPic = await firebaseStorage
        .ref()
        .child('Profile Pictures/$uuid')
        .getDownloadURL();
    return await userCollection.doc(uuid).update({'proPic': proPic});
  }

  Future getDownloadURL(String path) async {
    return await firebaseStorage.ref().child(path).getDownloadURL();
  }

  Future proPicURL() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    Connectivity connectivity = Connectivity();
    ConnectivityResult result = await connectivity.checkConnectivity();
    String loginType = sharedPref.getString('loginType');
    if (result == ConnectivityResult.none || loginType == 'guest') {
      return null;
    }
    try {
      var data = await userCollection.doc(uuid).get();
      return data.data()['proPic'];
    } catch (e) {
      return null;
    }
  }

  Future setLocalData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    Connectivity connectivity = Connectivity();
    ConnectivityResult result = await connectivity.checkConnectivity();
  }

  Future test(String a) async {
    return await userCollection.doc(uuid).set({'test': a});
  }
  ////////////////////////////////////////////////////////////////////////////

  //////////////////Storage tasks////////////////////////////////////////////
  StorageUploadTask uploadImages(String path, String fileName, File file) {
    return firebaseStorage.ref().child('$path/$fileName').putFile(file);
  }
}
