import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';

import '../widgets/internal/universal_button.dart';
import '../widgets/internal/universal_page_route.dart';
import '../widgets/internal/universal_scaffold.dart';

import 'internal/responsive_page.dart';

/// A screen displaying a fully styled phone number entry screen, with a country-code
/// picker.
class PhoneInputScreen extends StatelessWidget {
  /// {@macro ffui.auth.auth_action}
  final AuthAction? action;

  /// PhoneInputScreen could invoke these actions:
  ///
  /// - [SMSCodeRequestedAction]
  ///
  /// ```dart
  /// PhoneInputScreen(
  ///   actions: [
  ///     SMSCodeRequestedAction((context, action, flowKey, phoneNumber) {
  ///       Navigator.of(context).push(
  ///         MaterialPageRoute(
  ///           builder: (context) => SMSCodeInputScreen(
  ///             flowKey: flowKey,
  ///           ),
  ///         ),
  ///       );
  ///     }),
  ///   ]
  /// );
  /// ```
  final List<FlutterFireUIAction>? actions;

  /// {@macro ffui.auth.auth_controller.auth}
  final FirebaseAuth? auth;

  /// A returned widget would be placed under the title of the screen.
  final WidgetBuilder? subtitleBuilder;

  /// A returned widget would be placed at the bottom.
  final WidgetBuilder? footerBuilder;

  /// {@macro ffui.auth.screens.responsive_page.header_builder}
  final HeaderBuilder? headerBuilder;

  /// {@macro ffui.auth.screens.responsive_page.header_max_extent}
  final double? headerMaxExtent;

  /// {@macro ffui.auth.screens.responsive_page.side_builder}
  final SideBuilder? sideBuilder;

  /// {@macro ffui.auth.screens.responsive_page.desktop_layout_direction}
  final TextDirection? desktopLayoutDirection;

  /// {@macro ffui.auth.screens.responsive_page.breakpoint}
  final double breakpoint;

  const PhoneInputScreen({
    Key? key,
    this.action,
    this.actions,
    this.auth,
    this.subtitleBuilder,
    this.footerBuilder,
    this.headerBuilder,
    this.headerMaxExtent,
    this.sideBuilder,
    this.desktopLayoutDirection,
    this.breakpoint = 500,
  }) : super(key: key);

  void _next(BuildContext context, AuthAction? action, Object flowKey, _) {
    Navigator.of(context).push(
      createPageRoute(
        context: context,
        builder: (_) => FlutterFireUIActions.inherit(
          from: context,
          child: SMSCodeInputScreen(
            action: action,
            flowKey: flowKey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flowKey = Object();
    final l = FlutterFireUILocalizations.labelsOf(context);

    return FlutterFireUIActions(
      actions: actions ?? [SMSCodeRequestedAction(_next)],
      child: UniversalScaffold(
        body: ResponsivePage(
          desktopLayoutDirection: desktopLayoutDirection,
          sideBuilder: sideBuilder,
          headerBuilder: headerBuilder,
          headerMaxExtent: headerMaxExtent,
          breakpoint: breakpoint,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                PhoneInputView(
                  auth: auth,
                  action: action,
                  subtitleBuilder: subtitleBuilder,
                  footerBuilder: footerBuilder,
                  flowKey: flowKey,
                ),
                UniversalButton(
                  text: l.goBackButtonLabel,
                  variant: ButtonVariant.text,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
