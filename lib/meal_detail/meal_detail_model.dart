import '../Common/util.dart';
import 'meal_detail_widget.dart' show MealDetailWidget;
import 'package:flutter/material.dart';

class MealDetailModel extends FlutterFlowModel<MealDetailWidget> {
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
