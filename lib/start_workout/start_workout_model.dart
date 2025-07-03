import '../Common/util.dart';
import 'start_workout_widget.dart' show StartWorkoutWidget;
import 'package:flutter/material.dart';

class StartWorkoutModel extends FlutterFlowModel<StartWorkoutWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
