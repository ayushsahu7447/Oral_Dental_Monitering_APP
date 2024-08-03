import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String iconImagePath;
  final String buttonText;
  const MyButton({
    Key? key,
    required this.iconImagePath,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7),
        Container(
          height: 90,
          width: 80,
          margin: EdgeInsets.only(top: 12, right: 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomRight,
                stops: const [
                  0.1,
                  0.4,
                ],
                colors: [
                  Color(0xFFFF6D00),
                  Color(0xFFFF6D00)
                  //Color.fromARGB(255, 101, 49, 221),
                  //Color.fromARGB(255, 139, 123, 230),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 7,
                )
              ]),
          child: Center(child: Image.asset(iconImagePath)),
        ),
        SizedBox(height: 10),
        Text(
          buttonText,
          textAlign: TextAlign.center,
          // ignore: prefer_const_constructors

          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
      ],
    );
  }
}
