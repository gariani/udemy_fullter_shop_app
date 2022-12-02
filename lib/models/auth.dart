import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  String? _email;
  String? _token;
  String? _uid;
  bool? _isUserSignIn;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  bool get isAuth {
    return _isUserSignIn ?? false;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  Future<bool?> mailSignIn(String mail, String pwd) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (error) {
      final String errorMsg = "${error.code}: ${error.message}";
      print(errorMsg);
    } on UnimplementedError catch (error) {
      print(error.message!);
    }
    return null;
  }

  Future<String> mailRegister(String mail, String pwd) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: pwd);
      return '';
    } on FirebaseAuthException catch (error) {
      return "${error.code}: ${error.message}";
    }
  }

  Future<String> signup(String email, String password) async {
    return mailRegister(email, password);
  }

  Future<bool?> signin(String email, String password) async {
    return mailSignIn(email, password);
  }

  Future<bool> decideStartingPage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  Future<void> logoff() async {
    await FirebaseAuth.instance.signOut();
  }
}
