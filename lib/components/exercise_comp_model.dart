import '/backend/backend.dart';

import '../Common/util.dart';
import 'exercise_comp_widget.dart' show ExerciseCompWidget;
import 'package:flutter/material.dart';

class ExerciseCompModel extends FlutterFlowModel<ExerciseCompWidget> {
  ///  Local state fields for this component.

  int total = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxListTile widget.

  Map<ExercisesRecord, bool> checkboxListTileValueMap = {};
  List<ExercisesRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
