import 'package:dentalapp/pages/login_page.dart';
import 'package:dentalapp/pages/profile.dart';
import 'package:dentalapp/pages/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import '../config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/user.dart';
import 'email_verify.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<RegisterScreen> {
  bool isSignupScreen = true;
  bool isRememberMe = false;
  static const IconData email = IconData(0xe22a, fontFamily: 'MaterialIcons');

  //29
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final firstNameEditingController = new TextEditingController();
  final mobNoEditingController = new TextEditingController();

  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: size.height / 4,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: Colors.deepOrange,
                  gradient: LinearGradient(
                      colors: [Colors.deepOrangeAccent, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 5, color: Colors.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                            ),
                            height: 100,
                            width: 100,
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                              child: Image.asset(
                            "images/assets/Apiero_only-removebg-logo.png",
                            height: 100,
                            width: 100,
                            alignment: Alignment.topLeft,
                          )),
                        ]),
                        Container(
                          margin: EdgeInsets.only(
                              right: size.width / 2.8, top: size.height / 90),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Registration",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              buildSignupSection(),
              buildBottomHalfContainerSignup(true),
              Row(
                children:[
                  Spacer(),
                  Text("Already have an Account |", style: TextStyle(color: Palette.textColor2),),
                  TextButton(
                  child: Text("Log In ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),),
                  onPressed: () {Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                    signin()));},
                ),
                Spacer()]
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildSignupSection() {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: size.width / 10, right: size.width / 10, top: size.height / 40),
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Colors.black),
            autofocus: false,
            controller: firstNameEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Name");
              }
              return null;
            },
            onSaved: (value) {
              firstNameEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                MaterialCommunityIcons.account_outline,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "Name",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),
          ),
          SizedBox(
            height: size.height / 70,
          ),
          TextFormField(
            style: TextStyle(color: Colors.black),
            autofocus: false,
            controller: emailEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Mobile_No");
              }
              return null;
            },
            onSaved: (value) {
              emailEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                MaterialCommunityIcons.phone_in_talk,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "Mobile Number",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),
          ),
          SizedBox(
            height: size.height / 70,
          ),
          TextFormField(
            style: TextStyle(color: Colors.black),
            autofocus: false,
            controller: mobNoEditingController,
            keyboardType: TextInputType.number,
            validator: (value) {
              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
              RegExp regExp = new RegExp(pattern);

              if (value!.isEmpty) {
                return 'Please enter mobile number';
              }
              if (emailEditingController.text != mobNoEditingController.text) {
                return "Not match";
              }
              return null;
            },
            onSaved: (value) {
              mobNoEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                MaterialCommunityIcons.phone,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "Confirm Mobile Number",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),
          ),
          SizedBox(
            height: size.height / 70,
          ),
          TextFormField(
            style: TextStyle(color: Colors.black),
            autofocus: false,
            controller: passwordEditingController,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Password is required for login");
              }
              // reg expression for email validation
              if (!RegExp(r'^.{6,}$').hasMatch(value)) {
                return ("Enter Valid Password(Min. 6 Character)");
              }
            },
            onSaved: (value) {
              passwordEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                MaterialCommunityIcons.lock_outline,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "Password",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),
          ),
          SizedBox(
            height: size.height / 70,
          ),
          TextFormField(
            style: TextStyle(color: Colors.black),
            autofocus: false,
            controller: confirmPasswordEditingController,
            obscureText: true,
            validator: (value) {
              if (confirmPasswordEditingController.text !=
                  passwordEditingController.text) {
                return "Not match";
              }
              return null;
            },
            onSaved: (value) {
              confirmPasswordEditingController.text = value!;
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(
                MaterialCommunityIcons.lock_outline,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "Confirm Passward",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),
          ),
          SizedBox(
            height: size.height / 70,
          ),
          SizedBox(
            height: size.height / 70,
          ),
          SizedBox(
            height: size.height / 70,
          ),
          Container(
            width: size.width / 2,
            margin: EdgeInsets.only(
                top: size.height / 80, bottom: size.height / 60),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "By pressing 'Submit' you agree to our ",
                    style: TextStyle(color: Palette.textColor2),
                    children: [
                      TextSpan(
                        text: "term & condition",
                        style: TextStyle(color: Colors.redAccent),
                      )
                    ])),
          ),

        ],
      ),
    );
  }

  TextButton buildTextButton(IconData icon, Color backgroundColor) {
    final size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          padding: EdgeInsets.only(left: 40, right: 40),
          //minimumSize: Size(40, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 2,
          ),
        ],
      ),
    );
  }

  Widget buildBottomHalfContainerSignup(bool showShadow) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: GestureDetector(
        onTap: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Container(
          height: size.height / 9,
          width: size.width / 4.5,
          padding: EdgeInsets.all(size.height / 60),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size.height / 10),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1.5,
                      blurRadius: 10,
                      offset: Offset(0, 1))
              ]),
          child: showShadow
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.deepOrange[200]!,
                        Colors.deepOrangeAccent[400]!
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                )
              : Center(),
        ),
      ),
    );
  }

  Widget bottomButton(String text, Function navigate) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        navigate();
      },
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: Colors.white),
        padding: const EdgeInsets.all(0.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  Colors.blueAccent[400]!.withOpacity(0.65),
                  Colors.lightBlueAccent[200]!.withOpacity(0.65)
                ]),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(143, 148, 251, 2), blurRadius: 10)
            ]),
        padding: EdgeInsets.fromLTRB(
            size.width / 5, size.height / 50, size.width / 5, size.height / 50),
        child: Text(text, style: TextStyle(fontSize: 20)),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: email + "@gmail.com", password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    //calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.mobNo = int.tryParse(mobNoEditingController.text);

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => MainPage()), (route) => false);
  }
}
