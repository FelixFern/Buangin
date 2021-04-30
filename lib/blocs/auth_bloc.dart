import 'package:buangin_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:buangin_app/services/auth_service.dart';

class AuthBloc {
  final authService = AuthService();
  final googleSignin = GoogleSignIn(scopes: ['email']);

  Stream<User> get currentUser => authService.currentUser;

  loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      //Firebase Sign in
      final result = await authService.signInWithCredential(credential);
      final User user = result.user;
      if (result.additionalUserInfo.isNewUser) {
        if (user != null) {
          await DatabaseService(uid: result.user.uid).updateUserData(0, 0.0, 0);
          await DatabaseService(uid: result.user.uid)
              .updateDataKurir("Tidak Aktif", "");
        }
      }
      print('${result.user.displayName}');
    } catch (error) {
      print(error);
    }
  }

  logout() {
    authService.logout();
  }
}
