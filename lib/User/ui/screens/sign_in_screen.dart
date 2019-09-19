import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:smart_tbolt/User/bloc/user_bloc.dart';
import 'package:smart_tbolt/widgets/rounded_button.dart';
import 'package:smart_tbolt/User/ui/widgets/tab_indicator_painter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {

  SignInScreen({Key key}) : super(key: key);

  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen>
    with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> animation;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignUp = true;
  bool _obscureTextSignUpConfirm = true;

  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController = TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black38,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage('assets/images/login_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Hero(
                      tag: 'logo',
                      child: FlutterLogo(
                        size: MediaQuery.of(context).size.height / 8,
                        style: FlutterLogoStyle.horizontal,
                      ),
                    )
                  ),
                  _buildMenuBar(context),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            right = Colors.white;
                            left = Colors.black;
                          });
                        } else if (i == 1) {
                          setState(() {
                            right = Colors.black;
                            left = Colors.white;
                          });
                        }
                      },
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildSignIn(context),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildSignUp(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this
    );

    animation = Tween(
      begin: 1.0,
      end: 0.5
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn
    ))
      ..addListener((){
        setState(() {});
      });

    _animationController.forward();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
        )
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(
          pageController: _pageController,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                  )
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 10,
      ),
      duration: Duration(milliseconds: 600),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(left: 25.0, right: 25.0),
                elevation: 2.0,
                color: Colors.white.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, left: 10.0, right: 10.0),
                        child: TextFormField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent)
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            labelText: "Email Address",
                            labelStyle: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black38
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
                        child: TextFormField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38)
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black38
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RoundedButton(
                margin: EdgeInsets.all(25.0),
                text: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 15.0
                  ),
                ),
                onPressed: () => {}
              )
            ],
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: 16.0,
              ),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.white10,
                        Colors.white,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                width: 100.0,
                height: 1.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  "Or Connect With",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white10,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                width: 100.0,
                height: 1.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 40.0),
                child: GestureDetector(
                  onTap: () => {
                    userBloc.facebookSignIn()
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => showInSnackBar("Google button pressed"),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      FontAwesomeIcons.google,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 300.0,
                  height: 360.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          focusNode: myFocusNodeName,
                          controller: signUpNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            labelText: "Name",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          focusNode: myFocusNodeEmail,
                          controller: signUpEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            labelText: "Email Address",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          focusNode: myFocusNodePassword,
                          controller: signUpPasswordController,
                          obscureText: _obscureTextSignUp,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignUp,
                              child: Icon(
                                _obscureTextSignUp
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          controller: signUpConfirmPasswordController,
                          obscureText: _obscureTextSignUpConfirm,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            labelText: "Confirmation",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignUpConfirm,
                              child: Icon(
                                _obscureTextSignUpConfirm
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              RoundedButton(
                text: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () => {}
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignUp() {
    setState(() {
      _obscureTextSignUp = !_obscureTextSignUp;
    });
  }

  void _toggleSignUpConfirm() {
    setState(() {
      _obscureTextSignUpConfirm = !_obscureTextSignUpConfirm;
    });
  }
}