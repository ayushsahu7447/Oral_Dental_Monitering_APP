import 'package:dentalapp/m_config/splash_screen.dart';
import 'package:dentalapp/notification/localNotifyManager.dart';
import 'package:dentalapp/notification/notify_two.dart';
import 'package:dentalapp/pages/complaint_email.dart';
import 'package:dentalapp/pages/email_verify.dart';
import 'package:dentalapp/pages/forgot_password.dart';
import 'package:dentalapp/pages/profile_details.dart';
import 'package:dentalapp/pages/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'config/profile_color.dart';
import 'duo/event.dart';
import 'm_config/m_page/phScale.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp((DentalApp()));
}

class DentalApp extends StatelessWidget{
  const DentalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ayush-Care",
      home: MainPage(),
      //home: EventEdit(),
    );
  }
}