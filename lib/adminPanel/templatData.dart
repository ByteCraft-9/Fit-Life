// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../backend/schema/templates_record.dart';

class TemplateService {
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

  final CollectionReference _templatesCollection =
      FirebaseFirestore.instance.collection('templates');

  // Fetch all templates
  Future<List<TemplatesRecord>> getTemplates() async {
    List<TemplatesRecord> templates = [];
    try {
      QuerySnapshot querySnapshot = await _templatesCollection.get();
      for (var doc in querySnapshot.docs) {
        templates.add(TemplatesRecord.fromSnapshot(doc));
      }
    } catch (e) {
      print('Error fetching templates: $e');
    }
    return templates;
  }

  // Add a new template
  Future<void> addTemplate(String name) async {
    try {
      await _templatesCollection.add(createTemplatesRecordData(name: name));
    } catch (e) {
      print('Error adding template: $e');
    }
  }

  // Update a template
  Future<void> updateTemplate(String templateId, String newName) async {
    try {
      await _templatesCollection.doc(templateId).update({'name': newName});
    } catch (e) {
      print('Error updating template: $e');
    }
  }

  // Delete a template
  Future<void> deleteTemplate(String templateId) async {
    try {
      await _templatesCollection.doc(templateId).delete();
    } catch (e) {
      print('Error deleting template: $e');
    }
  }
}
