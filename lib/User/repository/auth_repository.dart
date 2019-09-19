
import 'package:smart_tbolt/User/repository/auth_api.dart';

class AuthRepository {
  final _authAPI = AuthAPI();

  void facebookSignIn() => _authAPI.facebookSignIn();
}