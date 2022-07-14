import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutterfire_ui/auth.dart';

/// A state that indicates that email flow is not initialized with an email and
/// password. UI should show an [EmailForm] when [EmailAuthFlow]'s current state is
/// [AwaitingEmailAndPassword].
class AwaitingEmailAndPassword extends AuthState {}

/// A state that indicates that a new user account was created.
class UserCreated extends AuthState {
  /// A [fba.UserCredential] that was obtained during authentication process.
  final fba.UserCredential credential;

  UserCreated(this.credential);
}

/// A state that indicates that user registration is in progress.
/// UIs often reflect this state with a loading indicator.
class SigningUp extends AuthState {}

/// A controller interface of the [EmailAuthFlow].
abstract class EmailAuthController extends AuthController {
  /// Initializes the flow with an email and password. This method should be
  /// called after user submits a form with email and password.
  void setEmailAndPassword(String email, String password);
}

/// {@template ffui.auth.flows.email_flow}
/// An auth flow that allows authentication with email and password.
/// {@endtemplate}
class EmailAuthFlow extends AuthFlow<EmailAuthProvider>
    implements EmailAuthController, EmailAuthListener {
  @override
  final EmailAuthProvider provider;

  /// {@macro ffui.auth.flows.email_flow}
  EmailAuthFlow({
    /// {@macro ffui.auth.auth_flow.ctor.provider}
    required this.provider,

    /// {@macro ffui.auth.auth_controller.auth}
    fba.FirebaseAuth? auth,

    /// {@macro @macro ffui.auth.auth_action}
    AuthAction? action,
  }) : super(
          action: action,
          initialState: AwaitingEmailAndPassword(),
          auth: auth,
          provider: provider,
        );

  @override
  void onBeforeSignIn() {
    if (action == AuthAction.signUp) {
      value = SigningUp();
    } else {
      super.onBeforeSignIn();
    }
  }

  @override
  void onSignedIn(fba.UserCredential credential) {
    if (action == AuthAction.signUp) {
      value = UserCreated(credential);
    } else {
      super.onSignedIn(credential);
    }
  }

  @override
  void setEmailAndPassword(String email, String password) {
    provider.authenticate(email, password, action);
  }
}
