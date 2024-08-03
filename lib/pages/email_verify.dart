import 'dart:async';
import 'package:dentalapp/pages/home.dart';
import 'package:dentalapp/pages/login_page.dart';
import 'package:dentalapp/pages/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context)=> Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Home();
        }
        else{
          return RegisterScreen();
        }
      },
    ),
  );
}


class VerifyEmailPage extends StatefulWidget{
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState(){
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
          Duration(seconds: 3),
              (_) => checkEmailVerified()
      );

    }
  }

  @override
  void dispose(){
    timer?.cancel();

    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future checkEmailVerified() async{

    if(FirebaseAuth.instance.currentUser==null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
      });
    }
    else {
      await FirebaseAuth.instance.currentUser!.reload();
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }
    if(isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Home() : Scaffold(
    appBar: AppBar(
      title: Text('Verify Email'),
      backgroundColor: Color(0xFFFF6D00),
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('A Verification email has been send to your email.',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,),

          SizedBox(height: 24),

          ElevatedButton.icon(onPressed: sendVerificationEmail,
              icon: Icon(Icons.email, size: 32,),
              label: Text('Resend Email',
              style: TextStyle(fontSize: 24),)),

          SizedBox(height: 8),

          TextButton(onPressed: () => FirebaseAuth.instance.signOut(),
              child: Text('Cancel',
              style: TextStyle(fontSize: 24),)
          ),
        ],

      ),
    ),
  );
}