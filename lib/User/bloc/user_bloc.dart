import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:smart_tbolt/User/repository/auth_repository.dart';

class UserBloc implements Bloc {

  final _authRepository = AuthRepository();



  void facebookSignIn() {
    return _authRepository.facebookSignIn();
  }

  @override
  void dispose() {

  }
}