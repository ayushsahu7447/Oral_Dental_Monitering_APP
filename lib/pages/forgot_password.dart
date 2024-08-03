import 'package:dentalapp/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class ForgotPasswordPage extends StatefulWidget{
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>{
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText , style: TextStyle(
        color: Colors.white, fontSize: 16.0, fontFamily: "SignikaRegular"),), duration: d , backgroundColor: Colors.amber,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: GestureDetector(
        onTap: () {Navigator.of(context).pop();},
        child: Icon(LineAwesomeIcons.arrow_left,color: Color(0xFFFF6D00),
          size: 30,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text('Reset Password', style: TextStyle(color: Color(0xFFFF6D00)),),
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Receive an email to \n reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
              cursorColor: Color(0xFFFF6D00),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Email' , iconColor: Color(0xFFFF6D00) ,),
              autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:(value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Your Email");
                  }
                  // reg expression for email validation
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please Enter a valid email");
                  }
                  return null;
                },
            ),
            SizedBox(height: 20,),
            ElevatedButton.icon(style: ElevatedButton.styleFrom(primary: Color(0xFFFF6D00), minimumSize:  Size.fromHeight(50)),
                onPressed: (){resetPassword();},
                icon: Icon(Icons.email_outlined),
                label: Text('Reset Password', style: TextStyle(fontSize: 24),))
          ],
        ),
      ),
    ),
  );

  Future resetPassword() async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()));
     try {
       await FirebaseAuth.instance
           .sendPasswordResetEmail(email: emailController.text.trim());
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signin(),));
     } on FirebaseAuthException catch(e){
       print(e);
       showSnackBar("Email sent Successfully Check Your Email/Spam:)", Duration(seconds: 2));
       Navigator.of(context).pop();


    }
  }
}



extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}