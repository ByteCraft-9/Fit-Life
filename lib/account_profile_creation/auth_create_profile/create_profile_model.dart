import '../edit_profile/edit_profile_widget.dart';
import '../../Common/util.dart';
import 'create_profile_widget.dart' show Auth2CreateProfileWidget;
import 'package:flutter/material.dart';

class Auth2CreateProfileModel
    extends FlutterFlowModel<Auth2CreateProfileWidget> {
  final unfocusNode = FocusNode();
  late EditProfileAuth2Model editProfileAuth2Model;

  @override
  void initState(BuildContext context) {
    editProfileAuth2Model = createModel(context, () => EditProfileAuth2Model());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    editProfileAuth2Model.dispose();
  }
}
