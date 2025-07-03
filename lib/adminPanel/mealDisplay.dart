// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../backend/schema/meal_record.dart';
import 'adminPanel.dart';
import 'mealData.dart';

class MealsListScreen extends StatefulWidget {
  const MealsListScreen({Key? key}) : super(key: key);

  @override
  _MealsListScreenState createState() => _MealsListScreenState();
}

class _MealsListScreenState extends State<MealsListScreen> {
  final MealService _mealService = MealService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminPanel()),
            );
          },
        ),
      ),
      body: FutureBuilder<List<MealRecord>>(
        future: _mealService.getMeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No meals found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                MealRecord meal = snapshot.data![index];
                return ListTile(
                  title: Text(meal.name),
                  subtitle: Text(meal.category),
                  onTap: () => _showMealDetailsDialog(meal),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditMealDialog(meal),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _showDeleteMealDialog(meal),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMealDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showMealDetailsDialog(MealRecord meal) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(meal.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${meal.category}'),
                Text('Description: ${meal.description}'),
                Text('Benefit: ${meal.benefit}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAddMealDialog() {
    _showMealDialog();
  }

  void _showEditMealDialog(MealRecord meal) {
    _showMealDialog(meal: meal);
  }

  void _showDeleteMealDialog(MealRecord meal) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Meal'),
          content: Text('Are you sure you want to delete ${meal.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _mealService.deleteMeal(meal.reference.id);
                Navigator.of(context).pop();
                setState(() {}); // Refresh the screen
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showMealDialog({MealRecord? meal}) {
    final formKey = GlobalKey<FormState>();
    String name = meal?.name ?? '';
    String category = meal?.category ?? '';
    String description = meal?.description ?? '';
    String benefit = meal?.benefit ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(meal == null ? 'Add Meal' : 'Edit Meal'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (value) => name = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: category,
                    decoration: const InputDecoration(labelText: 'Category'),
                    onChanged: (value) => category = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: description,
                    decoration: const InputDecoration(labelText: 'Description'),
                    onChanged: (value) => description = value,
                  ),
                  TextFormField(
                    initialValue: benefit,
                    decoration: const InputDecoration(labelText: 'Benefit'),
                    onChanged: (value) => benefit = value,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Map<String, dynamic> mealData = createMealRecordData(
                    name: name,
                    category: category,
                    description: description,
                    benefit: benefit,
                  );
                  if (meal == null) {
                    _mealService.addMeal(mealData);
                  } else {
                    _mealService.updateMeal(meal.reference.id, mealData);
                  }
                  Navigator.of(context).pop();
                  setState(() {}); // Refresh the screen
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
