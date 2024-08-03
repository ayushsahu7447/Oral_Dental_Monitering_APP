import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class ShowRating extends StatefulWidget {
  String? userID;
  ShowRating({Key? key, this.userID}) : super(key: key);

  @override
  State<ShowRating> createState() => _ShowRatingState();
}

class _ShowRatingState extends State<ShowRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6D00),
        title: const Text("Your Burning Data"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userID)
            .collection("rating")
            .orderBy('datetime', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return (const Center(
              child: Text("No Rating Uploaded"),
            ));
          } else {
            return Column(
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/background.jpg"),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          String rate =
                          snapshot.data!.docs[index]['rating'].toString();
                          String date = DateFormat('dd-MMM-yyyy').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  (snapshot.data!.docs[index]['datetime'])
                                      .microsecondsSinceEpoch));
                          String time = DateFormat('hh:mm:ss').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  (snapshot.data!.docs[index]['datetime'])
                                      .microsecondsSinceEpoch));
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(rate,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.purple)),
                                  Text(time,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.grey)),
                                  Text(date,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.grey)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
