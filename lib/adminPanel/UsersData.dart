// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../backend/schema/users_record.dart';

class UserService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Fetch all users
  Future<List<UsersRecord>> getUsers() async {
    List<UsersRecord> users = [];
    try {
      QuerySnapshot querySnapshot = await _usersCollection.get();
      for (var doc in querySnapshot.docs) {
        users.add(UsersRecord.fromSnapshot(doc));
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
    return users;
  }

  // Delete a user
  Future<void> deleteUser(String userId) async {
    try {
      await _usersCollection.doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
