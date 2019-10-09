import 'dart:async';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:smart_tbolt/user/repository/auth_repository.dart';
import 'package:smart_tbolt/user/ui/widgets/authentication_state.dart';

class UserBloc implements Bloc {

  final _authRepository = AuthRepository();

  Stream<AuthenticationState> get authStatus => _authRepository.onAuthStatusChanged;

  Future<Map> facebookSignIn() => _authRepository.facebookSignIn();

  void signOut() => _authRepository.signOut();

  @override
  void dispose() {

  }
}