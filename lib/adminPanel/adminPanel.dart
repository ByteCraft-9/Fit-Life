// ignore_for_file: file_names, sort_child_properties_last

import 'package:flutter/material.dart';

import '../onboarding/onboarding_widget.dart';
import '../adminPanel/exerciseDisplay.dart';
import '../adminPanel/mealDisplay.dart';
import '../adminPanel/templateDisplay.dart';
import '../adminPanel/userDisplay.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Panel',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Users screen or perform an action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UsersListScreen()),
                );
              },
              child: const Text('Users'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60), // Increase height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Round corners
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to Exercise screen or perform an action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExercisesListScreen()),
                );
              },
              child: const Text('Exercise'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60), // Increase height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Round corners
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to Meal screen or perform an action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MealsListScreen()),
                );
              },
              child: const Text('Meal'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60), // Increase height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Round corners
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to Template screen or perform an action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TemplatesListScreen()),
                );
              },
              child: const Text('Template'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60), // Increase height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Round corners
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to OnboardingWidget on logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnboardingWidget()),
                );
              },
              child: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(60), // Increase height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Round corners
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
