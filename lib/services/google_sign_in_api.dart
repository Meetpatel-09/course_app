import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAPI {
  static const _clientIDWeb =
      '385716127724-t2vd9rakfraifm8e5ocoth4um73ph9ff.apps.googleusercontent.com';

  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
