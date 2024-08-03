// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:dentalapp/pages/email_verify.dart';
import 'package:dentalapp/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainPage())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            // ignore: prefer_const_literals_to_create_immutables
            color: Colors.white),
        child: Center(
          child: Column(
            children: [
            Image.asset(
            "images/ae85a3de-02ef-4add-b8a1-639788bd7a91-removebg-preview.png",color: Colors.red,),
              Text(
                "Apiero Medica",
                style: TextStyle(
                  fontSize: 38,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
