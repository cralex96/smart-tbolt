import 'package:flutter/material.dart';

class UserSocialAuth {
  final String firstName;
  final String lastName;
  final String email;
  final String provider;
  final String providerUserId;

  UserSocialAuth({
    Key key,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.provider,
    @required this.providerUserId
  });

  Map<String, dynamic> toJson() => _userSocialAuthToJson(this);

  Map<String, dynamic> _userSocialAuthToJson(UserSocialAuth instance) {
    return <String, dynamic> {
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'provider': instance.provider,
      'provider_user_id': instance.providerUserId
    };
  }

}