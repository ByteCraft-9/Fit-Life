import '/backend/backend.dart';
import '../Common/icon_button.dart';
import '../Common/theme.dart';
import '../Common/util.dart';
import '../Common/formatDuration.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exercise_comp_model.dart';
export 'exercise_comp_model.dart';

class ExerciseCompWidget extends StatefulWidget {
  const ExerciseCompWidget({super.key});

  @override
  State<ExerciseCompWidget> createState() => _ExerciseCompWidgetState();
}

class _ExerciseCompWidgetState extends State<ExerciseCompWidget> {
  late ExerciseCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExerciseCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FFIconButton(
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: Icon(
                    Icons.remove_outlined,
                    color: FFTheme.of(context).primaryText,
                    size: 40.0,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add (${_model.total.toString()})',
                      style: FFTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: FFTheme.of(context).primary,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder<List<ExercisesRecord>>(
                      stream: queryExercisesRecord(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FFTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<ExercisesRecord> listViewExercisesRecordList =
                            snapshot.data!;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewExercisesRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewExercisesRecord =
                                listViewExercisesRecordList[listViewIndex];
                            return Theme(
                              data: ThemeData(
                                checkboxTheme: const CheckboxThemeData(
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                unselectedWidgetColor:
                                    FFTheme.of(context).secondaryText,
                              ),
                              child: CheckboxListTile(
                                value: _model.checkboxListTileValueMap[
                                        listViewExercisesRecord] ??=
                                    FFAppState()
                                        .workout
                                        .exercises
                                        .map((e) => e.exerciseRef?.id)
                                        .withoutNulls
                                        .toList()
                                        .contains(listViewExercisesRecord
                                            .reference.id),
                                onChanged: (newValue) async {
                                  setState(() =>
                                      _model.checkboxListTileValueMap[
                                          listViewExercisesRecord] = newValue!);
                                  if (newValue!) {
                                    _model.total = _model.total + 1;
                                    setState(() {});
                                    FFAppState().updateWorkoutStruct(
                                      (e) => e
                                        ..updateExercises(
                                          (e) => e.add(ExerciseStruct(
                                            exerciseRef: listViewExercisesRecord
                                                .reference,
                                            sets: functions.createSets(),
                                          )),
                                        ),
                                    );
                                    setState(() {});
                                  } else {
                                    _model.total = _model.total + -1;
                                    setState(() {});
                                  }
                                },
                                title: Text(
                                  listViewExercisesRecord.name,
                                  style:
                                      FFTheme.of(context).titleLarge.override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                ),
                                subtitle: Text(
                                  listViewExercisesRecord.bodyPart,
                                  style:
                                      FFTheme.of(context).labelMedium.override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                ),
                                tileColor:
                                    FFTheme.of(context).secondaryBackground,
                                activeColor: FFTheme.of(context).primary,
                                checkColor: FFTheme.of(context).info,
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
