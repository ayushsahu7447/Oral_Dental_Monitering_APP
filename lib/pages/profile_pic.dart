import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageurl;
  final Function ontap;

  Avatar({required this.imageurl, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap(),
      child: Center(
        child: imageurl == null
            ? CircleAvatar(
          radius: 50.0,
          child: Icon(Icons.photo_camera),
        )
            : CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(imageurl),
        ),
      ),
    );
  }
}