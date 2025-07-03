// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../backend/schema/meal_record.dart';

class MealService {
  final CollectionReference _mealsCollection =
      FirebaseFirestore.instance.collection('Meal');

  // Fetch all meals
  Future<List<MealRecord>> getMeals() async {
    List<MealRecord> meals = [];
    try {
      QuerySnapshot querySnapshot = await _mealsCollection.get();
      for (var doc in querySnapshot.docs) {
        meals.add(MealRecord.fromSnapshot(doc));
      }
    } catch (e) {
      print('Error fetching meals: $e');
    }
    return meals;
  }

  // Add a new meal
  Future<void> addMeal(Map<String, dynamic> mealData) async {
    try {
      await _mealsCollection.add(mealData);
    } catch (e) {
      print('Error adding meal: $e');
    }
  }

  // Delete a meal
  Future<void> deleteMeal(String mealId) async {
    try {
      await _mealsCollection.doc(mealId).delete();
    } catch (e) {
      print('Error deleting meal: $e');
    }
  }

  // Update a meal
  Future<void> updateMeal(String mealId, Map<String, dynamic> mealData) async {
    try {
      await _mealsCollection.doc(mealId).update(mealData);
    } catch (e) {
      print('Error updating meal: $e');
    }
  }
}
