// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../backend/schema/exercises_record.dart';
import 'adminPanel.dart';
import 'exerciseData.dart';

class ExercisesListScreen extends StatefulWidget {
  const ExercisesListScreen({Key? key}) : super(key: key);

  @override
  _ExercisesListScreenState createState() => _ExercisesListScreenState();
}

class _ExercisesListScreenState extends State<ExercisesListScreen> {
  final ExcersieService _exerciseService = ExcersieService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises List'),
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
      body: FutureBuilder<List<ExercisesRecord>>(
        future: _exerciseService.getExercises(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exercises found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ExercisesRecord exercise = snapshot.data![index];
                return ListTile(
                  title: Text(exercise.name),
                  subtitle: Text(exercise.category),
                  onTap: () {
                    _showExerciseDetails(exercise);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showUpdateDialog(exercise);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteDialog(exercise);
                        },
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
        onPressed: () {
          _showAddExerciseDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showExerciseDetails(ExercisesRecord exercise) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(exercise.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category: ${exercise.category}'),
              Text('Body Part: ${exercise.bodyPart}'),
              Text('Detail: ${exercise.detail}'),
              Text('Benefit: ${exercise.benefit}'),
              // Add more fields as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAddExerciseDialog() {
    String name = '';
    String category = '';
    String bodyPart = '';
    String detail = '';
    String benefit = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Exercise'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Category'),
                  onChanged: (value) => category = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Body Part'),
                  onChanged: (value) => bodyPart = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Detail'),
                  onChanged: (value) => detail = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Benefit'),
                  onChanged: (value) => benefit = value,
                ),
                // Add more text fields as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _saveNewExercise(name, category, bodyPart, detail, benefit);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveNewExercise(String name, String category, String bodyPart,
      String detail, String benefit) {
    _exerciseService.addExercise({
      'name': name,
      'category': category,
      'bodyPart': bodyPart,
      'detail': detail,
      'benefit': benefit,
      // Add more fields as needed
    });
  }

  void _showUpdateDialog(ExercisesRecord exercise) {
    String newName = exercise.name;
    String newCategory = exercise.category;
    String newBodyPart = exercise.bodyPart;
    String newDetail = exercise.detail;
    String newBenefit = exercise.benefit;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Exercise'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) => newName = value,
                  controller: TextEditingController(text: exercise.name),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Category'),
                  onChanged: (value) => newCategory = value,
                  controller: TextEditingController(text: exercise.category),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Body Part'),
                  onChanged: (value) => newBodyPart = value,
                  controller: TextEditingController(text: exercise.bodyPart),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Detail'),
                  onChanged: (value) => newDetail = value,
                  controller: TextEditingController(text: exercise.detail),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Benefit'),
                  onChanged: (value) => newBenefit = value,
                  controller: TextEditingController(text: exercise.benefit),
                ),
                // Add more text fields as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateExercise(exercise.reference.id, newName, newCategory,
                    newBodyPart, newDetail, newBenefit);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateExercise(String exerciseId, String newName, String newCategory,
      String newBodyPart, String newDetail, String newBenefit) {
    _exerciseService.updateExercise(exerciseId, {
      'name': newName,
      'category': newCategory,
      'bodyPart': newBodyPart,
      'detail': newDetail,
      'benefit': newBenefit,
      // Add more fields as needed
    });
  }

  void _showDeleteDialog(ExercisesRecord exercise) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Exercise'),
          content: Text('Are you sure you want to delete ${exercise.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _exerciseService.deleteExercise(exercise.reference.id);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
