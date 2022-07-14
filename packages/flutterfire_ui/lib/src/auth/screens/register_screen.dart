import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutterfire_ui/auth.dart';

import 'internal/login_screen.dart';
import 'internal/multi_provider_screen.dart';

/// A screen displaying a fully styled Registration flow for Authentication.
///
/// {@subCategory service:auth}
/// {@subCategory type:screen}
/// {@subCategory description:A screen displaying a fully styled Registration flow for Authentication.}
/// {@subCategory img:https://place-hold.it/400x150}
class RegisterScreen extends MultiProviderScreen {
  /// {@macro ffui.auth.screens.responsive_page.header_max_extent}
  final double? headerMaxExtent;

  /// {@macro ffui.auth.screens.responsive_page.header_builder}
  final HeaderBuilder? headerBuilder;

  /// {@macro ffui.auth.screens.responsive_page.side_builder}
  final SideBuilder? sideBuilder;

  /// Indicates whether icon-only or icon and text OAuth buttons should be used.
  /// Icon-only buttons are placed in a row.
  final OAuthButtonVariant? oauthButtonVariant;

  /// {@macro ffui.auth.screens.responsive_page.desktop_layout_direction}
  final TextDirection? desktopLayoutDirection;

  /// An email that [EmailForm] should be pre-filled with.
  final String? email;

  /// See [Scaffold.resizeToAvoidBottomInset]
  final bool? resizeToAvoidBottomInset;

  /// Whether the "Login/Register" link should be displayed. The link changes
  /// the type of the [AuthAction] from [AuthAction.signIn]
  /// and [AuthAction.signUp] and vice versa.
  final bool? showAuthActionSwitch;

  /// {@macro ffui.auth.views.login_view.subtitle_builder}
  final AuthViewContentBuilder? subtitleBuilder;

  /// {@macro ffui.auth.views.login_view.footer_builder}
  final AuthViewContentBuilder? footerBuilder;

  /// {@macro ffui.auth.screens.responsive_page.breakpoint}
  final double breakpoint;

  /// A set of styles that are provided to the descendant widgets.
  ///
  /// Possible styles are:
  /// * [EmailFormStyle]
  final Set<FlutterFireUIStyle>? styles;

  const RegisterScreen({
    Key? key,
    FirebaseAuth? auth,
    List<AuthProvider>? providers,
    this.headerMaxExtent,
    this.headerBuilder,
    this.sideBuilder,
    this.oauthButtonVariant = OAuthButtonVariant.icon_and_text,
    this.desktopLayoutDirection,
    this.email,
    this.resizeToAvoidBottomInset = false,
    this.showAuthActionSwitch,
    this.subtitleBuilder,
    this.footerBuilder,
    this.breakpoint = 800,
    this.styles,
  }) : super(key: key, auth: auth, providers: providers);

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      styles: styles,
      action: AuthAction.signUp,
      providers: providers,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      auth: auth,
      headerMaxExtent: headerMaxExtent,
      headerBuilder: headerBuilder,
      sideBuilder: sideBuilder,
      desktopLayoutDirection: desktopLayoutDirection,
      oauthButtonVariant: oauthButtonVariant,
      email: email,
      showAuthActionSwitch: showAuthActionSwitch,
      subtitleBuilder: subtitleBuilder,
      footerBuilder: footerBuilder,
    );
  }
}
