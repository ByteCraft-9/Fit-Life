// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../backend/schema/exercises_record.dart';

class ExcersieService {
  final CollectionReference _exercisesCollection =
      FirebaseFirestore.instance.collection('exercises');

  // Fetch all exercises
  Future<List<ExercisesRecord>> getExercises() async {
    List<ExercisesRecord> exercises = [];
    try {
      QuerySnapshot querySnapshot = await _exercisesCollection.get();
      for (var doc in querySnapshot.docs) {
        exercises.add(ExercisesRecord.fromSnapshot(doc));
      }
    } catch (e) {
      print('Error fetching exercises: $e');
    }
    return exercises;
  }

  // Add a new exercise
  Future<void> addExercise(Map<String, dynamic> data) async {
    try {
      await _exercisesCollection.add(data);
    } catch (e) {
      print('Error adding exercise: $e');
    }
  }

  // Update an exercise
  Future<void> updateExercise(
      String exerciseId, Map<String, dynamic> data) async {
    try {
      await _exercisesCollection.doc(exerciseId).update(data);
    } catch (e) {
      print('Error updating exercise: $e');
    }
  }

  // Delete an exercise
  Future<void> deleteExercise(String exerciseId) async {
    try {
      await _exercisesCollection.doc(exerciseId).delete();
    } catch (e) {
      print('Error deleting exercise: $e');
    }
  }

  // Get exercise details by reference
  Future<Map<String, dynamic>?> getExerciseDetails(
      DocumentReference exerciseRef) async {
    try {
      DocumentSnapshot snapshot = await exerciseRef.get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error fetching exercise details: $e');
    }
    return null;
  }
}
