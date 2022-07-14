import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:flutter/material.dart';

import '../widgets/internal/universal_button.dart';

/// {@template ffui.auth.widgets.sign_out_button}
/// A button that signs out the user when pressed.
/// {@endtemplate}
class SignOutButton extends StatelessWidget {
  /// {@macro ffui.auth.auth_controller.auth}
  final FirebaseAuth? auth;

  /// {@macro ffui.auth.widgets.button_variant}
  final ButtonVariant? variant;

  /// {@macro ffui.auth.widgets.sign_out_button}
  const SignOutButton({
    Key? key,
    this.auth,
    this.variant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l = FlutterFireUILocalizations.labelsOf(context);
    final isCupertino = CupertinoUserInterfaceLevel.maybeOf(context) != null;

    return UniversalButton(
      text: l.signOutButtonText,
      onPressed: () => FlutterFireUIAuth.signOut(
        context: context,
        auth: auth,
      ),
      icon: isCupertino ? CupertinoIcons.arrow_right_circle : Icons.logout,
      variant: variant,
    );
  }
}
