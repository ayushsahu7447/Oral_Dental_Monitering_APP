import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RateBurn extends StatefulWidget {
  String? userID;
  RateBurn({Key? key, this.userID}) : super(key: key);

  @override
  State<RateBurn> createState() => _RateBurnState();
}

class _RateBurnState extends State<RateBurn> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  double rating = 0;
  var now = new DateTime.now();

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText , style: TextStyle(
        color: Colors.white, fontSize: 16.0, fontFamily: "SignikaRegular"),), duration: d , backgroundColor: Colors.amber,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future RateBurn() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(widget.userID)
        .collection("rating")
        .add({'rating': rating, 'datetime': now}).whenComplete(() =>
        showSnackBar(
            "Burning Rate Uploaded Successfully :)", Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          LineAwesomeIcons.arrow_left,
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: Color(0xFFFF6D00),
      title: Text("Rate Your Burn"),
      centerTitle: true,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Rating:$rating',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          buildRating(),
          const SizedBox(height: 32),
          TextButton(
            child: Text(
              "Show Dialog",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFF6D00)),
            ),
            onPressed: () => showRating(),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFFFF6D00)),
              ),
              onPressed: () {
                RateBurn();
              },
              child: Text("Submit Data"))
        ],
      ),
    ),
  );
  Widget buildRating() => RatingBar.builder(
    minRating: 1,
    itemSize: 46,
    itemPadding: EdgeInsets.symmetric(horizontal: 4),
    allowHalfRating: true,
    itemCount: 5,
    itemBuilder: (context, index) {
      switch (index) {
        case 0:
          return Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.green,
          );
        case 1:
          return Icon(Icons.sentiment_satisfied,
            color: Colors.lightGreen,
          );
        case 2:
          return Icon(
            Icons.sentiment_neutral,
            color: Colors.amber,
          );
        case 3:
          return Icon(
            Icons.sentiment_dissatisfied,
            color: Color(0xFFFF6D00),

          );
        case 4:
          return Icon(

            Icons.sentiment_very_dissatisfied,
            color: Colors.red,
          );
      }
      return null!;
    },
    onRatingUpdate: (rating) => setState(() {
      this.rating = rating;
    }),
    updateOnDrag: true,
  );

  void showRating() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Scale Your Burning"),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Leave Scaling according to your pain.\nFor Ex:\nIf you have sever pain then rate 1 and normal then rate high",
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 2),
            ]),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 16),
              ))
        ],
      ));
}
