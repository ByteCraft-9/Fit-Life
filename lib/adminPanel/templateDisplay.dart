// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../backend/schema/structs/exercise_struct.dart';
import '../backend/schema/templates_record.dart';
import 'adminPanel.dart';
import 'templatData.dart';

class TemplatesListScreen extends StatefulWidget {
  const TemplatesListScreen({Key? key}) : super(key: key);

  @override
  _TemplatesListScreenState createState() => _TemplatesListScreenState();
}

class _TemplatesListScreenState extends State<TemplatesListScreen> {
  final TemplateService _templateService = TemplateService();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates List'),
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
      body: FutureBuilder<List<TemplatesRecord>>(
        future: _templateService.getTemplates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No templates found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                TemplatesRecord template = snapshot.data![index];
                return ListTile(
                  title: Text(template.name),
                  onTap: () {
                    _showDetailDialog(template);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showUpdateDialog(template);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteDialog(template);
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
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDetailDialog(TemplatesRecord template) async {
    List<String> exerciseNames = [];

    for (ExerciseStruct exercise in template.exercises) {
      if (exercise.exerciseRef != null) {
        var exerciseDetails =
            await _templateService.getExerciseDetails(exercise.exerciseRef!);
        if (exerciseDetails != null) {
          exerciseNames.add(exerciseDetails['name'] as String);
        }
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Template: ${template.name}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: exerciseNames
                .map((name) =>
                    Text('- $name', style: const TextStyle(fontSize: 16)))
                .toList(),
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

  void _showAddDialog() {
    _nameController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Template'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Template Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _templateService.addTemplate(_nameController.text);
                setState(() {}); // Refresh the UI
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(TemplatesRecord template) {
    _nameController.text = template.name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Template'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Template Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _templateService.updateTemplate(
                    template.reference.id, _nameController.text);
                setState(() {}); // Refresh the UI
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(TemplatesRecord template) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Template'),
          content: Text(
              'Are you sure you want to delete the template "${template.name}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _templateService.deleteTemplate(template.reference.id);
                setState(() {}); // Refresh the UI
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
