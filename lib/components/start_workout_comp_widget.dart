// ignore_for_file: use_build_context_synchronously

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/exercise_comp_widget.dart';
import '/components/input_reps_widget.dart';
import '/components/input_weight_widget.dart';
import '../Common/icon_button.dart';
import '../Common/theme.dart';
import '../Common/timer.dart';
import '../Common/util.dart';
import '../Common/widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'start_workout_comp_model.dart';
export 'start_workout_comp_model.dart';

class StartWorkoutCompWidget extends StatefulWidget {
  const StartWorkoutCompWidget({super.key});

  @override
  State<StartWorkoutCompWidget> createState() => _StartWorkoutCompWidgetState();
}

class _StartWorkoutCompWidgetState extends State<StartWorkoutCompWidget> {
  late StartWorkoutCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartWorkoutCompModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
    });

    _model.inputWorkoutNameTextController ??= TextEditingController();
    _model.inputWorkoutNameFocusNode ??= FocusNode();

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 10.0, 10.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await WorkoutsRecord.createDoc(currentUserReference!)
                          .set({
                        ...createWorkoutsRecordData(
                          name: FFAppState().workout.name,
                          timestamp: getCurrentTimestamp,
                          duration: _model.timerMilliseconds,
                        ),
                        ...mapToFirestore(
                          {
                            'exercises': getExerciseListFirestoreData(
                              FFAppState().workout.exercises,
                            ),
                          },
                        ),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Workout Finished',
                            style: TextStyle(
                              color: FFTheme.of(context).primaryText,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: FFTheme.of(context).secondary,
                        ),
                      );
                      await Future.delayed(const Duration(milliseconds: 2000));
                      Navigator.pop(context);

                      await NotificationRecord.collection.doc().set({
                        ...createNotificationRecordData(
                          message: 'You finished your exercise!',
                          userID: currentUserUid,
                        ),
                        ...mapToFirestore(
                          {
                            'timeStamp': FieldValue.serverTimestamp(),
                          },
                        ),
                      });
                    },
                    text: 'Finish',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFF02965B),
                      textStyle: FFTheme.of(context).titleSmall.override(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            child: TextFormField(
                              controller: _model.inputWorkoutNameTextController,
                              focusNode: _model.inputWorkoutNameFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.inputWorkoutNameTextController',
                                const Duration(milliseconds: 2000),
                                () async {
                                  FFAppState().updateWorkoutStruct(
                                    (e) => e
                                      ..name = _model
                                          .inputWorkoutNameTextController.text,
                                  );
                                  setState(() {});
                                },
                              ),
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle:
                                    FFTheme.of(context).labelMedium.override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                hintText: 'Enter workout name...',
                                hintStyle:
                                    FFTheme.of(context).labelMedium.override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FFTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FFTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FFTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FFTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              style: FFTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              validator: _model
                                  .inputWorkoutNameTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowTimer(
                          initialTime: _model.timerInitialTimeMs,
                          getDisplayTime: (value) =>
                              StopWatchTimer.getDisplayTime(
                            value,
                            hours: false,
                            milliSecond: false,
                          ),
                          controller: _model.timerController,
                          updateStateInterval:
                              const Duration(milliseconds: 1000),
                          onChanged: (value, displayTime, shouldUpdate) {
                            _model.timerMilliseconds = value;
                            _model.timerValue = displayTime;
                            if (shouldUpdate) setState(() {});
                          },
                          textAlign: TextAlign.start,
                          style: FFTheme.of(context).headlineSmall.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Notes',
                          style: FFTheme.of(context).bodyMedium.override(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 10.0, 20.0),
                    child: Builder(
                      builder: (context) {
                        final exercise =
                            FFAppState().workout.exercises.toList();
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: exercise.length,
                          itemBuilder: (context, exerciseIndex) {
                            final exerciseItem = exercise[exerciseIndex];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: StreamBuilder<ExercisesRecord>(
                                    stream: ExercisesRecord.getDocument(
                                        exerciseItem.exerciseRef!),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FFTheme.of(context).primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final textExercisesRecord =
                                          snapshot.data!;
                                      return Text(
                                        textExercisesRecord.name,
                                        style: FFTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 30.0),
                                  child: Builder(
                                    builder: (context) {
                                      final currentSet =
                                          exerciseItem.sets.toList();
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: currentSet.length,
                                        itemBuilder:
                                            (context, currentSetIndex) {
                                          final currentSetItem =
                                              currentSet[currentSetIndex];
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  currentSetItem.number
                                                      .toString(),
                                                  style: FFTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                              Expanded(
                                                child: wrapWithModel(
                                                  model: _model
                                                      .inputWeightModels
                                                      .getModel(
                                                    '1${currentSetItem.number.toString()}${exerciseItem.exerciseRef?.id}',
                                                    currentSetIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      setState(() {}),
                                                  updateOnChange: true,
                                                  child: InputWeightWidget(
                                                    key: Key(
                                                      'Key65w_${'1${currentSetItem.number.toString()}${exerciseItem.exerciseRef?.id}'}',
                                                    ),
                                                    parameter1:
                                                        currentSetItem.weight,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: wrapWithModel(
                                                  model: _model.inputRepsModels
                                                      .getModel(
                                                    '2${currentSetItem.number.toString()}${exerciseItem.exerciseRef?.id}',
                                                    currentSetIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      setState(() {}),
                                                  updateOnChange: true,
                                                  child: InputRepsWidget(
                                                    key: Key(
                                                      'Keyoqp_${'2${currentSetItem.number.toString()}${exerciseItem.exerciseRef?.id}'}',
                                                    ),
                                                    parameter1:
                                                        currentSetItem.reps,
                                                  ),
                                                ),
                                              ),
                                              if (currentSetIndex ==
                                                  (exerciseItem.sets.length -
                                                      1))
                                                FFIconButton(
                                                  borderRadius: 10.0,
                                                  borderWidth: 1.0,
                                                  buttonSize: 40.0,
                                                  icon: Icon(
                                                    Icons.close_sharp,
                                                    color: FFTheme.of(context)
                                                        .backgroundComponents,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () async {
                                                    FFAppState()
                                                        .updateWorkoutStruct(
                                                      (e) => e
                                                        ..updateExercises(
                                                          (e) =>
                                                              e[exerciseIndex]
                                                                ..updateSets(
                                                                  (e) => e.removeAt(
                                                                      currentSetIndex),
                                                                ),
                                                        ),
                                                    );
                                                    setState(() {});
                                                  },
                                                ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 20.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      FFAppState().updateWorkoutStruct(
                                        (e) => e
                                          ..updateExercises(
                                            (e) => e[exerciseIndex]
                                              ..updateSets(
                                                (e) => e.add(SetStruct(
                                                  weight: 100,
                                                  reps: 10,
                                                  number:
                                                      exerciseItem.sets.length +
                                                          1,
                                                )),
                                              ),
                                          ),
                                      );
                                      setState(() {});
                                    },
                                    text: 'New Set',
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FFTheme.of(context).primary,
                                      textStyle: FFTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 3.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: const ExerciseCompWidget(),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              text: 'Add Exercise',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                color: FFTheme.of(context).primary,
                                textStyle:
                                    FFTheme.of(context).titleSmall.override(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                elevation: 3.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 10.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            text: 'Cancel',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: const Color(0xFFD4776D),
                              textStyle:
                                  FFTheme.of(context).titleSmall.override(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
