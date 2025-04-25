import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_user_auth/screen/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: '979223392484-es6scikcjm1lscog3blllin74cduomc4.apps.googleusercontent.com',
      );

      // Google Login Start
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        print("Google sign-in was cancelled by user.");
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // 🔐 Firebase Login
      final UserCredential result = await firebaseAuth.signInWithCredential(credential);
      final User? user = result.user;

      if (user != null) {
        print("✅ Google sign-in successful. UID: ${user.uid}");

        final userDocRef =
            FirebaseFirestore.instance.collection("User").doc(user.uid);

        final docSnapshot = await userDocRef.get(); //Check if Firestore already has data for this user

        // Add data only if it doesn't already exist in Firestore
        if (!docSnapshot.exists) {
          final userInfoMap = {
            "email": user.email,
            "name": user.displayName,
            "imgUrl": user.photoURL,
            "id": user.uid,
            "createdAt": DateTime.now().toIso8601String()
          };

          try {
            await userDocRef.set(userInfoMap);
            print("✅ Added user information to Firestore.");

          } catch (error) {
            print("❌ Firestore write failed: $error");
            
          }
        } else {
          print("ℹ️ Addition skipped because user data already exists in Firestore.");
        }

        // 🚀 Go to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        print("❌ Google Sign-In failed: No user details found.");
      }
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
    }
  }
}
