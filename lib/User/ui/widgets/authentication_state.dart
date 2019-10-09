class AuthenticationState {
  static const String initialState = 'INITIAL';
  static const String loadingState = 'LOADING';
  static const String authenticatedState = 'AUTHENTICATED';
  static const String failedState = 'FAILED';
  static const String signedOutState = 'SIGNED_OUT';

  final String status;

  AuthenticationState.initial({this.status = initialState});
  AuthenticationState.loading({this.status = loadingState});
  AuthenticationState.authenticated({this.status = authenticatedState});
  AuthenticationState.failed({this.status = failedState});
  AuthenticationState.signedOut({this.status = signedOutState});
}