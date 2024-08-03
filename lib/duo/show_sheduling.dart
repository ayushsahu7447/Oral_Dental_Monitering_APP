import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class ShowShedule extends StatefulWidget {
  String? userID;
  ShowShedule({Key? key, this.userID}) : super(key: key);

  @override
  State<ShowShedule> createState() => _ShowSheduleState();
}

class _ShowSheduleState extends State<ShowShedule> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6D00),
        title: const Text("Your Scheduled Appointments"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userID)
            .collection("schedule")
            .orderBy('datetime', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return (const Center(
              child: Text("No Scheduling Uploaded"),
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
                          String title = snapshot.data!.docs[index]['title'];

                          String fromdate = DateFormat('dd-MMM-yyyy').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  (snapshot.data!.docs[index]['from'])
                                      .microsecondsSinceEpoch));
                          String fromtime = DateFormat('hh:mm:ss').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  (snapshot.data!.docs[index]['from'])
                                      .microsecondsSinceEpoch));
                          String todate = DateFormat('dd-MMM-yyyy').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  (snapshot.data!.docs[index]['to'])
                                      .microsecondsSinceEpoch));
                          String totime = DateFormat('hh:mm:ss').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  (snapshot.data!.docs[index]['to'])
                                      .microsecondsSinceEpoch));
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Topic:",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black)),

                                      Text(title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.purple)),
                                    ],
                                  ),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("From :",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black)),
                                      Text(fromdate,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFFFF6D00))),
                                      Text(fromtime,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFFFF6D00))),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("To      :",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black)),

                                      Text(todate,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.blueAccent)),
                                      Text(totime,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.blueAccent)),
                                    ],
                                  ),
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
