import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  final FacebookLogin facebookLogin = FacebookLogin();

  void facebookSignIn() async {
    FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['public_profile', 'email']);

    switch(result.status) {
      case FacebookLoginStatus.loggedIn:
        _sendFacebookUserDataToAPI(result);
        break;
      case FacebookLoginStatus.error:
        print('Error');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Cancelled');
        break;
    }
  }

  void _sendFacebookUserDataToAPI(FacebookLoginResult result) async {
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v4.0./me?fields=name,'
            'first_name,last_name,email,picture.height(200)&access_token=$token');
    final profile = json.decode(graphResponse.body);

    print(profile);
  }

}