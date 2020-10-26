import 'package:firebase_auth/firebase_auth.dart';
import 'package:safetyapp/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppAuth {
  FirebaseAuth _auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final DatabaseService databaseService = DatabaseService(null);

  AppAuth(this._auth);

  Future<AuthStatus> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthStatus(result.user, "");
    } catch (e) {
      return AuthStatus(null, _extractMessage(e));
    }
  }

  Future<AuthStatus> registerWithGoogle() async {
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    try {
      final authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;
      await databaseService.register(user.email, user.displayName.split(' ')[0],
          user.displayName.split(' ')[1], user.uid, user.photoURL);
      if (user != null) {
        DatabaseService dbs = DatabaseService(user.uid);
        await dbs.getData();
      }
      return AuthStatus(user, '');
    } catch (e) {
      return AuthStatus(null, _extractMessage(e));
    }
  }

  String _extractMessage(e) {
    var errorMessage = "";
    try {
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Email is already in use on different account";
          break;
        default:
          errorMessage = "Check Your Internet Connection Please";
      }
    } catch (e) {}

    return errorMessage;
  }

  //Sign in with email and password
  Future<AuthStatus> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user.uid != null) {
        DatabaseService dbs = DatabaseService(result.user.uid);
        await dbs.getData();
      }
      return AuthStatus(result.user, "");
    } catch (e) {
      //print(e);
      return AuthStatus(null, _extractMessage(e));
    }
  }

  //sign out

  Future signOut() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('logged', false);
    try {
      return await _auth.signOut().whenComplete(() async {
        await sharedPref.setString('loginType', null);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

class AuthStatus {
  User user;
  String errorMsg;

  AuthStatus(this.user, this.errorMsg);
}
