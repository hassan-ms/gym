import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount gUser;

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
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    // if (googleSignInAccount != null) {
    //   final GoogleSignInAuthentication googleSignInAuthentication =
    //       await googleSignInAccount.authentication;

    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleSignInAuthentication.accessToken,
    //     idToken: googleSignInAuthentication.idToken,
    //   );

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
