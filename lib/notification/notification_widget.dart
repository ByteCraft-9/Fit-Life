import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '../Common/icon_button.dart';
import '../Common/theme.dart';
import '../Common/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'notification_model.dart';
export 'notification_model.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late NotificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationModel());

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
        backgroundColor: FFTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FFTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FFIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FFTheme.of(context).secondaryBackground,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Notification',
            style: FFTheme.of(context).headlineMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FFTheme.of(context).secondaryBackground,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: StreamBuilder<List<NotificationRecord>>(
          stream: queryNotificationRecord(
            queryBuilder: (notificationRecord) => notificationRecord.where(
              'userID',
              isEqualTo: currentUserUid,
            ),
          ),
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
            List<NotificationRecord> listViewNotificationRecordList =
                snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: listViewNotificationRecordList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewNotificationRecord =
                    listViewNotificationRecordList[listViewIndex];
                return Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(5.0, 20.0, 5.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.25,
                          children: [
                            SlidableAction(
                              label: 'Delete',
                              backgroundColor: FFTheme.of(context).error,
                              icon: Icons.delete,
                              onPressed: (_) async {
                                await listViewNotificationRecord.reference
                                    .delete();
                              },
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            listViewNotificationRecord.message,
                            style: FFTheme.of(context).titleLarge.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          subtitle: Text(
                            valueOrDefault<String>(
                              listViewNotificationRecord.timeStamp?.toString(),
                              'Time',
                            ),
                            style: FFTheme.of(context).labelMedium.override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          tileColor: FFTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
