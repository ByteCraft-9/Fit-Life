import '../Common/util.dart';
import 'fitness_widget.dart' show FitnessWidget;
import 'package:flutter/material.dart';

class FitnessModel extends FlutterFlowModel<FitnessWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
  }
}
