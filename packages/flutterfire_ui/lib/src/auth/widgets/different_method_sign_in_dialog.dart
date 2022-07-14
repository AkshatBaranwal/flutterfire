import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';

import '../widgets/internal/title.dart';

/// {@template ffui.auth.widgets.different_method_sign_in_dialog}
/// A dialog that is shown when the user tries to sign in with a provider that
/// wasn't previously used, but there are other providers for a given email.
/// {@endtemplate}
class DifferentMethodSignInDialog extends StatelessWidget {
  /// {@macro ffui.auth.auth_controller.auth}
  final FirebaseAuth? auth;

  /// A list of all providers that were previously used to authenticate.
  final List<String> availableProviders;

  /// A list of all supported auth providers.
  final List<AuthProvider> providers;

  /// A callback that is being called when the user has signed in using on of
  /// the [availableProviders].
  final VoidCallback? onSignedIn;

  /// {@macro ffui.auth.widgets.different_method_sign_in_dialog}
  const DifferentMethodSignInDialog({
    Key? key,
    required this.availableProviders,
    required this.providers,
    this.auth,
    this.onSignedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l = FlutterFireUILocalizations.labelsOf(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Title(text: l.differentMethodsSignInTitleText),
                const SizedBox(height: 32),
                DifferentMethodSignInView(
                  auth: auth,
                  providers: providers,
                  availableProviders: availableProviders,
                  onSignedIn: onSignedIn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
