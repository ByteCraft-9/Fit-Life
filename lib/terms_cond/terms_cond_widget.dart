import '../Common/icon_button.dart';
import '../Common/theme.dart';
import '../Common/util.dart';
import 'package:flutter/material.dart';
import 'terms_cond_model.dart';
export 'terms_cond_model.dart';

class TermsCondWidget extends StatefulWidget {
  const TermsCondWidget({super.key});

  @override
  State<TermsCondWidget> createState() => _TermsCondWidgetState();
}

class _TermsCondWidgetState extends State<TermsCondWidget> {
  late TermsCondModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsCondModel());

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
            'Terms and Conditions',
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      15.0, 15.0, 15.0, 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          '1. Introduction\nWelcome to FitLife. These terms and conditions outline the rules and regulations for the use of the FitLife mobile app, developed to provide personalized exercise and meal recommendations. By accessing this app, we assume you accept these terms and conditions in full. Do not continue to use FitLife if you do not agree to all the terms and conditions stated on this page.\n\n2. Definitions\nApp: The FitLife mobile application.\nWe/Us/Our: Refers to the developers and operators of FitLife.\nUser/You/Your: Refers to anyone who accesses and uses the app.\nContent: Any text, images, videos, or other multimedia content, software, or other information or material submitted to or on the app.\n\n3. User Accounts\n\n3.1 Registration\nTo use certain features of the app, you must register and create an account.\nYou must provide accurate and complete information during registration and update your information to keep it accurate and complete.\n\n3.2 Account Security\nYou are responsible for maintaining the confidentiality of your account login information and for all activities that occur under your account.\nYou must notify us immediately of any unauthorized use of your account or any other breach of security.\n\n4. Use of the App\n\n4.1 License\nWe grant you a limited, non-exclusive, non-transferable, and revocable license to use the app for personal, non-commercial purposes, subject to these terms.\n\n4.2 Acceptable Use\nYou agree not to use the app for any unlawful purpose or in a way that could damage, disable, overburden, or impair the app.\nYou agree not to access or attempt to access any part of the app that you are not authorized to access.\n\n4.3 Prohibited Activities\nCopying, distributing, or disclosing any part of the app in any medium.\nUsing any automated system to access the app in a manner that sends more request messages to the servers than a human can reasonably produce.\nTransmitting spam, chain letters, or other unsolicited email.\nAttempting to interfere with, compromise the system integrity or security, or decipher any transmissions to or from the servers running the app.\n\n5. User Content\n\n5.1 Ownership\nYou retain ownership of all content you submit, post, display, or make available through the app.\n\n5.2 License to Us\nBy submitting content, you grant us a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, publish, and distribute such content for the purposes of operating and providing the app.\n\n5.3 User Responsibilities\nYou are solely responsible for your content and the consequences of posting or publishing it.\nYou agree that you will not post content that is unlawful, harmful, defamatory, obscene, invasive of another\'s privacy, or otherwise objectionable.\n\n6. Intellectual Property\nThe app and its original content (excluding user-provided content), features, and functionality are and will remain the exclusive property of us and our licensors.\nThe app is protected by copyright, trademark, and other laws of both the United States and foreign countries. Our trademarks and trade dress may not be used in connection with any product or service without our prior written consent.\n\n7. Privacy Policy\nYour use of the app is also governed by our Privacy Policy, which can be found within the app and on our website. By using the app, you consent to the terms of the Privacy Policy.\n\n8. Termination\n\n8.1 Termination by You\nYou may terminate your account at any time by contacting us or following the account termination process provided in the app.\n\n8.2 Termination by Us\nWe may terminate or suspend your account and bar access to the app immediately, without prior notice or liability, if you breach these terms.\n\n8.3 Effect of Termination\nUpon termination, your right to use the app will immediately cease. If you wish to terminate your account, you may simply discontinue using the app.\n\n9. Limitation of Liability\nTo the maximum extent permitted by applicable law, in no event shall we be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your use of the app.\n\n10. Disclaimer\nThe app is provided on an \"AS IS\" and \"AS AVAILABLE\" basis. We disclaim all warranties of any kind, whether express or implied, including, but not limited to, implied warranties of merchantability, fitness for a particular purpose, non-infringement, and course of performance.\nWe do not warrant that the app will be uninterrupted, secure, or error-free, or that any defects will be corrected.\n\n11. Governing Law\nThese terms shall be governed and construed in accordance with the laws of the jurisdiction in which we are established, without regard to its conflict of law provisions.\n\n12. Changes to Terms\nWe reserve the right, at our sole discretion, to modify or replace these terms at any time. If a revision is material, we will provide at least 30 days\' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.\nBy continuing to access or use our app after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, please stop using the app.\n\n13. Contact Us\nIf you have any questions about these terms, please contact us at\nsupport@fitlife.com',
                          style: FFTheme.of(context).bodyMedium.override(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ],
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
