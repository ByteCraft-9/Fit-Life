// ignore_for_file: prefer_const_literals_to_create_immutables

import '/backend/backend.dart';
import '/components/start_workout_comp_widget.dart';
import '../Common/theme.dart';
import '../Common/util.dart';
import '../Common/widgets.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'start_workout_model.dart';
export 'start_workout_model.dart';

class StartWorkoutWidget extends StatefulWidget {
  const StartWorkoutWidget({super.key});

  @override
  State<StartWorkoutWidget> createState() => _StartWorkoutWidgetState();
}

class _StartWorkoutWidgetState extends State<StartWorkoutWidget> {
  late StartWorkoutModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartWorkoutModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FFTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FFTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Start Workout',
            style: FFTheme.of(context).headlineMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: double.infinity,
                    height: 105.0,
                    decoration: BoxDecoration(
                      color: FFTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Quick Start',
                                style: FFTheme.of(context).titleMedium.override(
                                      fontFamily: 'Readex Pro',
                                      color: FFTheme.of(context).primaryText,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              AlignedTooltip(
                                content: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'You can start the workout by pressing the start workout button ',
                                    style:
                                        FFTheme.of(context).bodySmall.override(
                                              fontFamily: 'Inter',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                  ),
                                ),
                                offset: 4.0,
                                preferredDirection: AxisDirection.right,
                                borderRadius: BorderRadius.circular(8.0),
                                backgroundColor:
                                    FFTheme.of(context).secondaryBackground,
                                elevation: 4.0,
                                tailBaseWidth: 15.0,
                                tailLength: 5.0,
                                waitDuration: const Duration(milliseconds: 100),
                                showDuration:
                                    const Duration(milliseconds: 1500),
                                triggerMode: TooltipTriggerMode.tap,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.info_outline,
                                    color: FFTheme.of(context).secondaryText,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: const StartWorkoutCompWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                text: 'Start Workout',
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: double.infinity,
                    height: 900.0,
                    decoration: BoxDecoration(
                      color: FFTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Templates',
                                style: FFTheme.of(context).titleLarge.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              AlignedTooltip(
                                content: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'You can select the templates given below for quick start.',
                                    style:
                                        FFTheme.of(context).bodyLarge.override(
                                              fontFamily: 'Inter',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                  ),
                                ),
                                offset: 4.0,
                                preferredDirection: AxisDirection.right,
                                borderRadius: BorderRadius.circular(8.0),
                                backgroundColor:
                                    FFTheme.of(context).secondaryBackground,
                                elevation: 4.0,
                                tailBaseWidth: 12.0,
                                tailLength: 5.0,
                                waitDuration: const Duration(milliseconds: 100),
                                showDuration:
                                    const Duration(milliseconds: 1500),
                                triggerMode: TooltipTriggerMode.tap,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.info_outline,
                                    color: FFTheme.of(context).secondaryText,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder<List<TemplatesRecord>>(
                            stream: queryTemplatesRecord(),
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
                              List<TemplatesRecord>
                                  gridViewTemplatesRecordList = snapshot.data!;
                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1.0,
                                  mainAxisSpacing: 2.0,
                                  childAspectRatio: 1.0,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: gridViewTemplatesRecordList.length,
                                itemBuilder: (context, gridViewIndex) {
                                  final gridViewTemplatesRecord =
                                      gridViewTemplatesRecordList[
                                          gridViewIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      FFAppState().workout = WorkoutStruct(
                                        name: 'Workout',
                                        exercises:
                                            gridViewTemplatesRecord.exercises,
                                      );
                                      setState(() {});
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child:
                                                  const StartWorkoutCompWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: FFTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 4.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10.0, 0.0, 0.0, 10.0),
                                                  child: Text(
                                                    gridViewTemplatesRecord
                                                        .name,
                                                    style: FFTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FFTheme.of(
                                                                  context)
                                                              .primaryText,
                                                          fontSize: 19.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final exercise =
                                                  gridViewTemplatesRecord
                                                      .exercises
                                                      .toList();
                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: exercise.length,
                                                itemBuilder:
                                                    (context, exerciseIndex) {
                                                  final exerciseItem =
                                                      exercise[exerciseIndex];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                            0.0, 0.0),
                                                    child: StreamBuilder<
                                                        ExercisesRecord>(
                                                      stream: ExercisesRecord
                                                          .getDocument(
                                                              exerciseItem
                                                                  .exerciseRef!),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  FFTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        final textExercisesRecord =
                                                            snapshot.data!;
                                                        return Text(
                                                          textExercisesRecord
                                                              .name,
                                                          style: FFTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
