import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart' hide Title;
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';

import 'internal/title.dart';

/// {@template ffui.auth.widget.email_sign_up_dialog}
/// A dialog [Widget] that allows to create a new account using email and
/// password or to link current account with an email.
/// {@endtemplate}
class EmailSignUpDialog extends StatelessWidget {
  /// {@macro ffui.auth.auth_controller.auth}
  final FirebaseAuth? auth;

  /// {@macro ffui.auth.auth_action}
  final AuthAction? action;

  /// An instance of [EmailAuthProvider] that should be used to authenticate.
  final EmailAuthProvider provider;

  /// {@macro ffui.auth.widget.email_sign_up_dialog}
  const EmailSignUpDialog({
    Key? key,
    this.auth,
    required this.provider,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l = FlutterFireUILocalizations.labelsOf(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Dialog(
          child: AuthStateListener<EmailAuthController>(
            listener: (oldState, newState, ctrl) {
              if (newState is CredentialLinked) {
                Navigator.of(context).pop();
              }

              return null;
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Title(text: l.provideEmail),
                  const SizedBox(height: 32),
                  EmailForm(
                    auth: auth,
                    action: action,
                    provider: provider,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
