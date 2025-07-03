// ignore_for_file: use_super_parameters

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class MealRecord extends FirestoreRecord {
  MealRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "benefit" field.
  String? _benefit;
  String get benefit => _benefit ?? '';
  bool hasBenefit() => _benefit != null;

  // "mimage" field.
  String? _mimage;
  String get mimage => _mimage ?? '';
  bool hasMimage() => _mimage != null;

  // "mvideo" field.
  String? _mvideo;
  String get mvideo => _mvideo ?? '';
  bool hasMvideo() => _mvideo != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _category = snapshotData['category'] as String?;
    _description = snapshotData['description'] as String?;
    _benefit = snapshotData['benefit'] as String?;
    _mimage = snapshotData['mimage'] as String?;
    _mvideo = snapshotData['mvideo'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Meal');

  static Stream<MealRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MealRecord.fromSnapshot(s));

  static Future<MealRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MealRecord.fromSnapshot(s));

  static MealRecord fromSnapshot(DocumentSnapshot snapshot) => MealRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MealRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MealRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MealRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MealRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMealRecordData({
  String? name,
  String? category,
  String? description,
  String? benefit,
  String? mimage,
  String? mvideo,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'category': category,
      'description': description,
      'benefit': benefit,
      'mimage': mimage,
      'mvideo': mvideo,
    }.withoutNulls,
  );

  return firestoreData;
}

class MealRecordDocumentEquality implements Equality<MealRecord> {
  const MealRecordDocumentEquality();

  @override
  bool equals(MealRecord? e1, MealRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.category == e2?.category &&
        e1?.description == e2?.description &&
        e1?.benefit == e2?.benefit &&
        e1?.mimage == e2?.mimage &&
        e1?.mvideo == e2?.mvideo;
  }

  @override
  int hash(MealRecord? e) => const ListEquality().hash(
      [e?.name, e?.category, e?.description, e?.benefit, e?.mimage, e?.mvideo]);

  @override
  bool isValidKey(Object? o) => o is MealRecord;
}
