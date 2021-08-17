import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount gUser;
  var client;

  Future<void> silentSignin() async {
    try {
      await Firebase.initializeApp();
      await googleSignIn.isSignedIn();

      final googleSignInAccount = await googleSignIn.signInSilently();
      gUser = googleSignInAccount;
    } catch (e) {
      throw e;
    }
  }

  Future<GoogleSignInAccount> signInWithGoogle() async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // User user;
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    try {
      await Firebase.initializeApp();

      await googleSignIn.requestScopes([
        'https://www.googleapis.com/auth/fitness.activity.read',
        'https://www.googleapis.com/auth/fitness.body.read',
      ]);
    } catch (e) {
      throw e;
    }

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      client = await googleSignIn.authenticatedClient();

      // sessions.session.forEach((element) {
      //   print("name " + element.activeTimeMillis);
      // });

      //   try {
      //     final UserCredential userCredential =
      //         await auth.signInWithCredential(credential);

      //     user = userCredential.user;

      //   } on FirebaseAuthException catch (e) {
      //     if (e.code == 'account-exists-with-different-credential') {
      //       throw e;
      //     } else if (e.code == 'invalid-credential') {
      //       throw e;
      //     }
      //   } catch (e) {
      //     throw e;
      //   }
      // }
      notifyListeners();
      gUser = googleSignInAccount;
      return gUser;
    }
  }

  Future<void> checkExist() async {
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(gUser.id).get().then((snapshot) {
      if (!snapshot.exists) {
        db.collection('users').doc(gUser.id).set({});
      }
    });

    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
    } catch (error) {
      throw error;
    }
  }
}
