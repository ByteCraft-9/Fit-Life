import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '../Common/theme.dart';
import '../Common/util.dart';
import 'package:flutter/material.dart';
import 'fitness_model.dart';
export 'fitness_model.dart';

class FitnessWidget extends StatefulWidget {
  const FitnessWidget({super.key});

  @override
  State<FitnessWidget> createState() => _FitnessWidgetState();
}

class _FitnessWidgetState extends State<FitnessWidget>
    with TickerProviderStateMixin {
  late FitnessModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FitnessModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
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
            'Fitness',
            style: FFTheme.of(context).headlineMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Align(
                alignment: const Alignment(0.0, 0),
                child: TabBar(
                  labelColor: FFTheme.of(context).primaryText,
                  unselectedLabelColor: FFTheme.of(context).secondaryText,
                  labelStyle: FFTheme.of(context).titleMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                  unselectedLabelStyle: const TextStyle(),
                  indicatorColor: FFTheme.of(context).primary,
                  padding: const EdgeInsets.all(4.0),
                  tabs: const [
                    Tab(
                      text: 'Exercise',
                    ),
                    Tab(
                      text: 'Meal',
                    ),
                  ],
                  controller: _model.tabBarController,
                  onTap: (i) async {
                    [() async {}, () async {}][i]();
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _model.tabBarController,
                  children: [
                    Stack(
                      children: [
                        if (valueOrDefault(currentUserDocument?.role, '') ==
                            'Random')
                          AuthUserStreamWidget(
                            builder: (context) =>
                                StreamBuilder<List<ExercisesRecord>>(
                              stream: queryExercisesRecord(
                                queryBuilder: (exercisesRecord) =>
                                    exercisesRecord.orderBy('name'),
                              ),
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
                                List<ExercisesRecord>
                                    listViewExercisesRecordList =
                                    snapshot.data!;
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewExercisesRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewExercisesRecord =
                                        listViewExercisesRecordList[
                                            listViewIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'ExerciseDetail',
                                          queryParameters: {
                                            'exdt': serializeParam(
                                              listViewExercisesRecord,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'exdt': listViewExercisesRecord,
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                          listViewExercisesRecord.name,
                                          style: FFTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        subtitle: Text(
                                          listViewExercisesRecord.bodyPart,
                                          style: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 20.0,
                                        ),
                                        tileColor: FFTheme.of(context)
                                            .secondaryBackground,
                                        dense: false,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        if (valueOrDefault(currentUserDocument?.role, '') !=
                            'Random')
                          AuthUserStreamWidget(
                            builder: (context) =>
                                StreamBuilder<List<ExercisesRecord>>(
                              stream: queryExercisesRecord(
                                queryBuilder: (exercisesRecord) =>
                                    exercisesRecord
                                        .where(
                                          'category',
                                          isEqualTo: valueOrDefault(
                                              currentUserDocument?.role, ''),
                                        )
                                        .orderBy('name'),
                              ),
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
                                List<ExercisesRecord>
                                    listViewExercisesRecordList =
                                    snapshot.data!;
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewExercisesRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewExercisesRecord =
                                        listViewExercisesRecordList[
                                            listViewIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'ExerciseDetail',
                                          queryParameters: {
                                            'exdt': serializeParam(
                                              listViewExercisesRecord,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'exdt': listViewExercisesRecord,
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                          listViewExercisesRecord.name,
                                          style: FFTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        subtitle: Text(
                                          listViewExercisesRecord.bodyPart,
                                          style: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 20.0,
                                        ),
                                        tileColor: FFTheme.of(context)
                                            .secondaryBackground,
                                        dense: false,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                    Stack(
                      children: [
                        if (valueOrDefault(currentUserDocument?.role, '') ==
                            'Random')
                          AuthUserStreamWidget(
                            builder: (context) =>
                                StreamBuilder<List<MealRecord>>(
                              stream: queryMealRecord(
                                queryBuilder: (mealRecord) =>
                                    mealRecord.orderBy('name'),
                              ),
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
                                List<MealRecord> listViewMealRecordList =
                                    snapshot.data!;
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewMealRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewMealRecord =
                                        listViewMealRecordList[listViewIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'MealDetail',
                                          queryParameters: {
                                            'mldt': serializeParam(
                                              listViewMealRecord,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'mldt': listViewMealRecord,
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                          listViewMealRecord.name,
                                          style: FFTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        subtitle: Text(
                                          listViewMealRecord.category,
                                          style: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 20.0,
                                        ),
                                        tileColor: FFTheme.of(context)
                                            .secondaryBackground,
                                        dense: false,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        if (valueOrDefault(currentUserDocument?.role, '') !=
                            'Random')
                          AuthUserStreamWidget(
                            builder: (context) =>
                                StreamBuilder<List<MealRecord>>(
                              stream: queryMealRecord(
                                queryBuilder: (mealRecord) =>
                                    mealRecord.orderBy('name'),
                              ),
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
                                List<MealRecord> listViewMealRecordList =
                                    snapshot.data!;
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewMealRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewMealRecord =
                                        listViewMealRecordList[listViewIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'MealDetail',
                                          queryParameters: {
                                            'mldt': serializeParam(
                                              listViewMealRecord,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'mldt': listViewMealRecord,
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                          listViewMealRecord.name,
                                          style: FFTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        subtitle: Text(
                                          listViewMealRecord.category,
                                          style: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 20.0,
                                        ),
                                        tileColor: FFTheme.of(context)
                                            .secondaryBackground,
                                        dense: false,
                                      ),
                                    );
                                  },
                                );
                              },
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
      ),
    );
  }
}
