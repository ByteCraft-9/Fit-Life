// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import '/auth/firebase_auth/auth_util.dart';
import '../Common/icon_button.dart';
import '../Common/theme.dart';
import '../Common/util.dart';
import 'account_model.dart';
export 'account_model.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key});

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  late AccountModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountModel());

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
            'Account',
            style: FFTheme.of(context).headlineMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FFTheme.of(context).secondaryBackground,
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(10.0, 30.0, 10.0, 0.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FFIconButton(
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        icon: Icon(
                          Icons.person,
                          color: FFTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                      Text(
                        'Logout',
                        style: FFTheme.of(context).bodyLarge.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 0.0, 0.0),
                        child: GestureDetector(
                          child: AlignedTooltip(
                            content: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Your account is logged out by pressing this button.',
                                style: FFTheme.of(context).bodyLarge.override(
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
                            showDuration: const Duration(milliseconds: 1500),
                            triggerMode: TooltipTriggerMode.tap,
                            child: Icon(
                              Icons.info_outline,
                              color: FFTheme.of(context).secondaryText,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            210.0, 0.0, 0.0, 0.0),
                        child: FFIconButton(
                          borderRadius: 20.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: FFTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            Function() navigate = () {};
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Logout'),
                                      content: const Text(
                                          'Are you sure you want to Logout'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                            if (confirmDialogResponse) {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              navigate = () => context.goNamedAuth(
                                  'Onboarding', context.mounted);
                            }

                            navigate();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FFIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        icon: Icon(
                          Icons.delete,
                          color: FFTheme.of(context).error,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                      Text(
                        'Delete Account',
                        style: FFTheme.of(context).bodyLarge.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 0.0, 0.0),
                        child: GestureDetector(
                          child: AlignedTooltip(
                            content: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Your account is permanently deleted by pressing this button.',
                                style: FFTheme.of(context).bodyLarge.override(
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
                            showDuration: const Duration(milliseconds: 1500),
                            triggerMode: TooltipTriggerMode.tap,
                            child: Icon(
                              Icons.info_outline,
                              color: FFTheme.of(context).secondaryText,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            145.0, 0.0, 0.0, 0.0),
                        child: FFIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 20.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: FFTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            Function() navigate0 = () {};
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Delete Account'),
                                      content: const Text(
                                          'Are you sure you want to Delete your Account'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                            if (confirmDialogResponse) {
                              await authManager.deleteUser(context);
                            }

                            navigate0();
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
    );
  }
}
