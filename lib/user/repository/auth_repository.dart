import 'package:smart_tbolt/user/repository/auth_api.dart';
import 'package:smart_tbolt/user/ui/widgets/authentication_state.dart';

class AuthRepository {
  final _authAPI = AuthAPI();

  Stream<AuthenticationState> get onAuthStatusChanged => _authAPI.onAuthStatusChanged;

  Future<Map> facebookSignIn() => _authAPI.facebookSignIn();

  void signOut() => _authAPI.signOut();
}