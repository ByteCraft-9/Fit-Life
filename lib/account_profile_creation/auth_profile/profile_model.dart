import '../../Common/util.dart';
import 'profile_widget.dart' show Auth2ProfileWidget;
import 'package:flutter/material.dart';

class Auth2ProfileModel extends FlutterFlowModel<Auth2ProfileWidget> {
  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
