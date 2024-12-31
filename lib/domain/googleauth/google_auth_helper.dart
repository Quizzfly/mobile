import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    signInOption: SignInOption.standard,
    forceCodeForRefreshToken: true,
  );

  /// Handle Google Signin to authenticate user
  Future<GoogleSignInAccount?> googleSignInProcess() async {
    await _googleSignIn.signOut();

    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      return googleUser;
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }

  /// To Check if the user is already signedin through google
  Future<bool> alreadySignIn() async {
    bool alreadySignIn = await _googleSignIn.isSignedIn();
    if (alreadySignIn) {
      await _googleSignIn.signOut();
      return false;
    }
    return false;
  }

  /// To signout from the application if the user is signed in through google
  Future<void> googleSignOutProcess() async {
    await _googleSignIn.signOut();
    await _googleSignIn.disconnect();
  }
}