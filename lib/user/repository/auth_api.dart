import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:smart_tbolt/user/model/user_social_auth.dart';
import 'package:smart_tbolt/user/ui/widgets/authentication_state.dart';
import 'package:smart_tbolt/widgets/api_provider.dart';
import 'package:dio/dio.dart';

class AuthAPI {
  final FacebookLogin facebookLogin = FacebookLogin();
  final Dio _dio = Dio();
  final StreamController<AuthenticationState> _authStatusController = StreamController<AuthenticationState>.broadcast();

  Stream<AuthenticationState> get onAuthStatusChanged => _authStatusController.stream;

  // Facebook Sign In
  Future<Map> facebookSignIn() async {
    FacebookLoginResult result = await facebookLogin.logIn(['public_profile', 'email']);

    switch(result.status) {
      case FacebookLoginStatus.loggedIn:
        _authStatusController.add(AuthenticationState.loading());
        return _sendFacebookUserDataToAPI(result);
      case FacebookLoginStatus.error:
        _authStatusController.add(AuthenticationState.failed());
        return jsonDecode('{}');
      case FacebookLoginStatus.cancelledByUser:
        print('Cancelled');
        return jsonDecode('{}');
      default:
        return jsonDecode('{}');
    }
  }

  // Sign Out
  void signOut() async {
    facebookLogin.logOut();
    _authStatusController.add(AuthenticationState.signedOut());
  }

  Future<Map> _sendFacebookUserDataToAPI(FacebookLoginResult result) async {
    final String facebookToken = result.accessToken.token;
    final Response graphResponse = await _dio.get(
        'https://graph.facebook.com/v4.0/me?fields='
            'first_name,last_name,email,picture.height(200)&access_token=$facebookToken');
    final profile = jsonDecode(graphResponse.data);

    ApiProvider apiProvider = ApiProvider();

    UserSocialAuth userSocialAuth = UserSocialAuth(
      firstName: profile['first_name'],
      lastName: profile['last_name'],
      email: profile['email'],
      provider: 'facebook',
      providerUserId: profile['id']
    );

    Map socialSignIn = await apiProvider.socialSignIn(userSocialAuth);
    if (socialSignIn.containsKey('access_token')) {
      apiProvider.setAccessToken(socialSignIn['access_token']);
      _authStatusController.add(AuthenticationState.authenticated());
      print("Login Succesful");
    } else {
      _authStatusController.add(AuthenticationState.failed());
      _authStatusController.addError(socialSignIn['error']);
    }
    return socialSignIn;
  }

  bool isLoggedIn() {

    return true;
  }

}