import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui_oauth/flutterfire_ui_oauth.dart';
import 'package:flutterfire_ui_oauth_apple/flutterfire_ui_oauth_apple.dart';
import 'package:flutterfire_ui_oauth_facebook/flutterfire_ui_oauth_facebook.dart';
import 'package:flutterfire_ui_oauth_google/flutterfire_ui_google_oauth.dart';
import 'package:flutterfire_ui_oauth_twitter/flutterfire_ui_oauth_twitter.dart';

import 'src/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const OAuthProviderButtonExample());
}

class OAuthProviderButtonExample extends StatelessWidget {
  const OAuthProviderButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Settings(builder: (context, library, brightness, buttonVariant) {
      if (library == DesignLibrary.material) {
        return MaterialApp(
          theme: ThemeData(brightness: brightness),
          home: Scaffold(
            body: Content(
              designLibrary: library,
              buttonVariant: buttonVariant,
            ),
          ),
        );
      } else {
        return CupertinoApp(
          theme: CupertinoThemeData(brightness: brightness),
          home: CupertinoPageScaffold(
            child: Content(
              designLibrary: library,
              buttonVariant: buttonVariant,
            ),
          ),
        );
      }
    });
  }
}

class Content extends StatefulWidget {
  final DesignLibrary designLibrary;
  final ButtonVariant buttonVariant;

  const Content({
    Key? key,
    required this.designLibrary,
    required this.buttonVariant,
  }) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  String? loadingProvider;

  void Function() _onTap(String provider) {
    return () {
      setState(() {
        loadingProvider = provider;
      });
    };
  }

  Widget _button(OAuthProvider provider, String label) {
    final loadingIndicator = widget.designLibrary == DesignLibrary.material
        ? const CircularProgressIndicator()
        : const CupertinoActivityIndicator();

    return OAuthProviderButtonBase(
      provider: provider,
      label: label,
      onTap: _onTap(provider.providerId),
      isLoading: loadingProvider == provider.providerId,
      loadingIndicator: loadingIndicator,
      overrideDefaultTapAction: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _button(AppleProvider(), 'Sign in with Apple'),
            _button(
              FacebookProvider(clientId: '', redirectUri: ''),
              'Sign in with Facebook',
            ),
            _button(
              GoogleProvider(
                clientId: '',
                redirectUri: '',
                scopes: [],
              ),
              'Sign in with Google',
            ),
            _button(
              TwitterProvider(
                apiKey: '',
                apiSecretKey: '',
                redirectUri: '',
              ),
              'Sign in with Twitter',
            ),
          ],
        ),
      ),
    );
  }
}
