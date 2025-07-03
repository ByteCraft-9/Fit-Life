import '../Common/util.dart';
import 'terms_cond_widget.dart' show TermsCondWidget;
import 'package:flutter/material.dart';

class TermsCondModel extends FlutterFlowModel<TermsCondWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
