import 'package:dentalapp/config/fadeanimation.dart';
import 'package:dentalapp/pages/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/palette.dart';
import 'email_verify.dart';
import 'forgot_password.dart';

class signin extends StatefulWidget{
  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {

  static const IconData email = IconData(0xe22a, fontFamily: 'MaterialIcons');

  bool isRememberMe = false;

  //29
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final firstNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        backgroundColor: Colors.deepOrange,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(top: size.height / 20),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Card(
                        elevation: 2.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          width: size.width / 1.1,
                          height: size.height / 1.5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: new Image(
                                        width: 150.0,
                                        height: 150.0,
                                        fit: BoxFit.fill,
                                        image: new AssetImage(
                                          'images/assets/Apiero_only-removebg-logo.png',))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 20.0,
                                        left: 25.0,
                                        right: 25.0),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      autofocus: false,
                                      controller: emailController,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("Please Enter Your Mobile_Number");
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        emailController.text = value!;
                                      },
                                      textInputAction: TextInputAction.next,

                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          MaterialCommunityIcons.account_outline,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(35.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFFF6D00)),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(35.0)),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: "Mobile Number",
                                        hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                                      ),
                                    )
                                ),
                                Container(
                                  width: size.width / 1.6,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: passwordController,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Password is required for login");
                                      }
                                      // reg expression for email validation
                                      if (!RegExp(r'^.{6,}$')
                                          .hasMatch(value)) {
                                        return ("Enter Valid Password(Min. 6 Character)");
                                      }
                                    },
                                    onSaved: (value) {
                                      firstNameEditingController.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,

                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        MaterialCommunityIcons.lock_outline,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Palette.textColor1),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(35.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFFFF6D00)),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(35.0)),
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: "password",
                                      hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: size.width / 1.6,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 60.0, bottom: 26.0),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.deepOrange,
                                            offset: Offset(1.0, 6.0),
                                            blurRadius: 20.0),
                                        BoxShadow(
                                            color: Colors.deepPurple,
                                            offset: Offset(1.0, 6.0),
                                            blurRadius: 20.0),
                                      ],
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.deepOrange,
                                            Colors.deepOrange
                                          ],
                                          begin: const FractionalOffset(0.2, 0.2),
                                          end: const FractionalOffset(1.0, 1.0),
                                          stops: [0.1, 1.0],
                                          tileMode: TileMode.clamp)),
                                  child: MaterialButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.deepPurple,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 42.0),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            fontFamily: "SignikaSemiBold",
                                            color: Colors.white,
                                            fontSize: 22.0),
                                      ),
                                    ),
                                    onPressed: () {signIn(emailController.text, passwordController.text);},
                                  ),
                                ),
                                Container(
                                  child: ElevatedButton(
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontFamily: "SignikaRegular"),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              ForgotPasswordPage())
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.white10,
                                  Colors.white,
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: size.width / 4,
                          height: 1.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 16.0,
                                fontFamily: "WorkSansMedium"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.white10,
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: size.width / 4,
                          height: 1.0,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 90 , left: size.width / 8 , right: size.height / 20),
                    child: Row(
                      children: [
                        Text(
                          "Not have account?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              ),
                        ),
                        ElevatedButton(
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                (RegisterScreen())));
                          },
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ));
  }


  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      email= email+"@gmail.com";
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) =>
      {

        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainPage()))
        ,
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    };
  }

}