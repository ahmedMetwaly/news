import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
