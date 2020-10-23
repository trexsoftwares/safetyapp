import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uuid;

  DatabaseService(this.uuid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  Future register(String email, String fName, String lName, String uid,
      String photoUrl) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'fName': fName,
      'lName': lName,
      'uuid': uid,
      'proPic': photoUrl
    });
  }

  Future test(String a) async {
    return await userCollection.doc(uuid).set({'test': a});
  }
}
