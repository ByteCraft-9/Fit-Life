import '/auth/firebase_auth/auth_util.dart';
import 'package:lottie/lottie.dart';
import '/backend/backend.dart';
import '../Common/charts.dart';
import '../Common/icon_button.dart';
import '../Common/swipeable_stack.dart';
import '../Common/theme.dart';
import '../Common/util.dart';
import '../Common/formatDuration.dart' as functions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'homepage_model.dart';
export 'homepage_model.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  late HomepageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildGamificationElements() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Badges you earn',
            style: FFTheme.of(context).headlineMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: 28.0,
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _showBadgeDialog(index + 1),
                  child: Chip(
                    label: Text('Badge ${index + 1}'),
                    avatar: CircleAvatar(
                      backgroundColor: FFTheme.of(context).primary,
                      child: const Icon(Icons.star, color: Colors.white),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showBadgeDialog(int badgeNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(); // Dismiss when tapping outside animation
              },
              child: Container(
                color: Colors.black.withOpacity(0.6),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/lottie_animations/congratulation.json',
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'You earned Badge $badgeNumber',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<WorkoutsRecord>>(
      stream: queryWorkoutsRecord(
        parent: currentUserReference,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FFTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FFTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<WorkoutsRecord> homepageWorkoutsRecordList = snapshot.data!;
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
                'FitLife',
                style: FFTheme.of(context).displaySmall.override(
                      fontFamily: 'Readex Pro',
                      color: FFTheme.of(context).secondaryBackground,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: const [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AuthUserStreamWidget(
                              builder: (context) => Container(
                                width: 55.0,
                                height: 55.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  currentUserPhoto,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  7.0, 0.0, 0.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed('auth_2_Profile');
                                  },
                                  child: Text(
                                    currentUserDisplayName,
                                    style:
                                        FFTheme.of(context).titleLarge.override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                            ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  95.0, 0.0, 0.0, 0.0),
                              child: FFIconButton(
                                borderRadius: 20.0,
                                buttonSize: 40.0,
                                fillColor:
                                    FFTheme.of(context).secondaryBackground,
                                icon: Icon(
                                  Icons.notifications_sharp,
                                  color: FFTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  context.pushNamed('Notification');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 20.0),
                              child: Text(
                                'Workout Report',
                                style:
                                    FFTheme.of(context).headlineMedium.override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 28.0,
                                          letterSpacing: 0.0,
                                        ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 10.0),
                              child: AlignedTooltip(
                                content: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Your workout report is shown in the following chart. Y-axis is the number of exercises.',
                                    style:
                                        FFTheme.of(context).bodyLarge.override(
                                              fontFamily: 'Inter',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                  ),
                                ),
                                offset: 4.0,
                                preferredDirection: AxisDirection.left,
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
                      SizedBox(
                        width: 370.0,
                        height: 230.0,
                        child: FlutterFlowBarChart(
                          barData: [
                            FFBarChartData(
                              yData: functions.getFrequency(
                                  homepageWorkoutsRecordList
                                      .map((e) => e.timestamp)
                                      .withoutNulls
                                      .toList()),
                              color: FFTheme.of(context).primary,
                            )
                          ],
                          xLabels: functions.chartLabel(),
                          barWidth: 16.0,
                          barBorderRadius: BorderRadius.circular(8.0),
                          groupSpace: 8.0,
                          alignment: BarChartAlignment.spaceAround,
                          chartStylingInfo: ChartStylingInfo(
                            backgroundColor:
                                FFTheme.of(context).secondaryBackground,
                            borderColor: FFTheme.of(context).secondaryText,
                            borderWidth: 1.0,
                          ),
                          axisBounds: const AxisBounds(),
                          xAxisLabelInfo: const AxisLabelInfo(
                            showLabels: true,
                            labelInterval: 10.0,
                            reservedSize: 28.0,
                          ),
                          yAxisLabelInfo: const AxisLabelInfo(
                            showLabels: true,
                            labelInterval: 10.0,
                            reservedSize: 42.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      _buildGamificationElements(),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30.0, 0.0, 0.0, 0.0),
                            child: Container(
                              width: 300.0,
                              height: 300.0,
                              decoration: BoxDecoration(
                                color: FFTheme.of(context).secondaryBackground,
                              ),
                              child: FFSwipeableStack(
                                onSwipeFn: (index) {},
                                onLeftSwipe: (index) {},
                                onRightSwipe: (index) {},
                                onUpSwipe: (index) {},
                                onDownSwipe: (index) {},
                                itemBuilder: (context, index) {
                                  return [
                                    () => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/q1.jpg',
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                    () => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/q_2.jpg',
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                    () => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/q3.jpg',
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                  ][index % 3]();
                                },
                                itemCount: 5,
                                controller: _model.swipeableStackController,
                                loop: true,
                                cardDisplayCount: 5,
                                scale: 0.9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
