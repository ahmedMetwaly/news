import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/model/cubit/appcCubit.dart';


final cloudDb = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

void sendDataToCloud(Map<String, dynamic> userData) {
  cloudDb.collection("users").add(userData).then(
        (value) =>
            print("added successfully to cloud fireStore with id ${value.id} "),
      );
}

Future signUp({required String email, required String password}) async {
  await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future signIn({required String email, required String password}) async {
  await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<User?> signInWithGoogle(context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
       user = userCredential.user;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Signed In Successfully",
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Theme.of(context).appBarTheme.iconTheme?.color,
        ),
      );
    } on FirebaseException catch (error) {
      print("there is error on sign in with google it's : $error");
    }
  }
  return user;
}
