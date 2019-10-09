import 'dart:ui';
import 'package:flutter/material.dart';

class User {
  final String dni;
  final String firstName;
  final String lastName;
  final String email;
  final String genreId;
  final Picture image;

  // User Constructor
  User({
    Key key,
    this.dni,
    this.firstName,
    this.lastName,
    this.email,
    this.genreId,
    this.image
  });

  User.fromJson(Map<String, dynamic> json)
    : dni = json['dni'],
      firstName = json['first_name'],
      lastName = json['last_name'],
      email = json['email'],
      genreId = json['genre_id'],
      image = json['picture'];
}