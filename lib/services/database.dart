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
    return await userCollection.doc(uuid).set({
      'email': email,
      'fName': fName,
      'lName': lName,
      'uuid': uid,
      'proPic': photoUrl
    });
  }

  Future addContacts(
      String name, String relationship, String number, String pos) async {
    return await userCollection
        .doc(uuid)
        .collection('Contacts')
        .doc(pos)
        .set({'name': name, 'relationship': relationship, 'number': number});
  }

  Future editContacts(
      String name, String relationship, String number, String pos) async {
    return await userCollection
        .doc(uuid)
        .collection('Contacts')
        .doc(pos)
        .update({'name': name, 'relationship': relationship, 'number': number});
  }

  Future deleteContacts(String pos) async {
    return await userCollection
        .doc(uuid)
        .collection('Contacts')
        .doc(pos)
        .delete();
  }

  Future getContacts(String pos) async {
    var contacts = await userCollection.doc(uuid).collection('Contacts').get();
    List<Map<int, Map<String, String>>> contactsDic = [];
    for (int i = 0; i < contacts.docs.length; i++) {
      //contactsDic[i] = {contacts.docs[i].data()['']};
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
