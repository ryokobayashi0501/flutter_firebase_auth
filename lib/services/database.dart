// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class DatabaseMethods{
//   Future addUser(String userId, Map<String, dynamic> userInfoMap){
//     return FirebaseFirestore.instance
//     .collection("User")
//     .doc(userId)
//     .set(userInfoMap);
//   }

//   Future<void> ensureUserInFirestore(User user) async {
//     final userDoc = FirebaseFirestore.instance.collection("User").doc(user.uid);
//     final snapshot = await userDoc.get();

//     if (!snapshot.exists) {
//       final userInfoMap = {
//         "email": user.email,
//         "name": user.displayName ?? "", // May be null for email/password
//         "imgUrl": null,
//         "id": user.uid,
//         "createdAt": DateTime.now().toIso8601String()
//       };
//       await userDoc.set(userInfoMap);
//       print("✅ Added user information to Firestore（Email/Password）");
//     } else {
//       print("ℹ️ User information already exists in Firestore");
//     }
//   }
// }