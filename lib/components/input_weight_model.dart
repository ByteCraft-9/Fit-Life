import '../Common/util.dart';
import 'input_weight_widget.dart' show InputWeightWidget;
import 'package:flutter/material.dart';

class InputWeightModel extends FlutterFlowModel<InputWeightWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
