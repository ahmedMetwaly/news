import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String imageUrl;

  const Users({
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.phoneNumber,
  });

  Map<String, dynamic> userData() {
    return {
      "firstName": firstName,
      "imageUrl": imageUrl,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
    };
  }
}
