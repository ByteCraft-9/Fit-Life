import '../Common/util.dart';
import 'exercise_detail_widget.dart' show ExerciseDetailWidget;
import 'package:flutter/material.dart';

class ExerciseDetailModel extends FlutterFlowModel<ExerciseDetailWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for RatingBar widget.
  double? ratingBarValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
