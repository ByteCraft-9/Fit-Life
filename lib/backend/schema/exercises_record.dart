// ignore_for_file: use_super_parameters

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class ExercisesRecord extends FirestoreRecord {
  ExercisesRecord._(
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

  // "body_part" field.
  String? _bodyPart;
  String get bodyPart => _bodyPart ?? '';
  bool hasBodyPart() => _bodyPart != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  bool hasDetail() => _detail != null;

  // "benefit" field.
  String? _benefit;
  String get benefit => _benefit ?? '';
  bool hasBenefit() => _benefit != null;

  // "eimage" field.
  String? _eimage;
  String get eimage => _eimage ?? '';
  bool hasEimage() => _eimage != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _category = snapshotData['category'] as String?;
    _bodyPart = snapshotData['body_part'] as String?;
    _detail = snapshotData['detail'] as String?;
    _benefit = snapshotData['benefit'] as String?;
    _eimage = snapshotData['eimage'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('exercises');

  static Stream<ExercisesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ExercisesRecord.fromSnapshot(s));

  static Future<ExercisesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ExercisesRecord.fromSnapshot(s));

  static ExercisesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ExercisesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ExercisesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ExercisesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ExercisesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ExercisesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createExercisesRecordData({
  String? name,
  String? category,
  String? bodyPart,
  String? detail,
  String? benefit,
  String? eimage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'category': category,
      'body_part': bodyPart,
      'detail': detail,
      'benefit': benefit,
      'eimage': eimage,
    }.withoutNulls,
  );

  return firestoreData;
}

class ExercisesRecordDocumentEquality implements Equality<ExercisesRecord> {
  const ExercisesRecordDocumentEquality();

  @override
  bool equals(ExercisesRecord? e1, ExercisesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.category == e2?.category &&
        e1?.bodyPart == e2?.bodyPart &&
        e1?.detail == e2?.detail &&
        e1?.benefit == e2?.benefit &&
        e1?.eimage == e2?.eimage;
  }

  @override
  int hash(ExercisesRecord? e) => const ListEquality().hash(
      [e?.name, e?.category, e?.bodyPart, e?.detail, e?.benefit, e?.eimage]);

  @override
  bool isValidKey(Object? o) => o is ExercisesRecord;
}
