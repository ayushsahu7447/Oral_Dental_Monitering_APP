import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowUploads extends StatefulWidget {
  String? userID;
  ShowUploads({Key? key , this.userID}) : super(key: key);

  @override
  State<ShowUploads> createState() => _ShowUploadsState();
}

class _ShowUploadsState extends State<ShowUploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6D00),
        title: const Text("Uploaded Images"),
      ),
      body:
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.userID).collection("images").orderBy('dateTime', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(!snapshot.hasData)
            {
              return(Center(
                child: Text("No Image Uploaded"),
              ));
            }
          else{
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.85,
                    width: MediaQuery.of(context).size.width,
                    child:
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context , int index){
                    String url = snapshot.data!.docs[index]['downloadURL'];
                    String date = DateFormat('dd-MM-yyyy--hh-mm').format(DateTime.fromMicrosecondsSinceEpoch((snapshot.data!.docs[index]['dateTime']).microsecondsSinceEpoch));

                    String date1 = DateFormat('dd-MMM-yyyy').format(
                        DateTime.fromMicrosecondsSinceEpoch(
                            (snapshot.data!.docs[index]['dateTime'])
                                .microsecondsSinceEpoch));
                    String time = DateFormat('hh:mm:ss').format(
                        DateTime.fromMicrosecondsSinceEpoch(
                            (snapshot.data!.docs[index]['dateTime'])
                                .microsecondsSinceEpoch));
                    return url==null?
                    Center(child:CircularProgressIndicator()):
                      Column(children: [
                      Image.network(
                        url,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      Card(
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
                            Text(time,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFFF6D00))),
                          Text(date1,
                            style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueAccent)),
                          ],
                        ),
                        ),
                      ),
                      SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.black12,
                                      Colors.black,
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              width: 100.0,
                              height: 1.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Text(
                                'Apiero',
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontSize: 16.0,
                                    fontFamily: "WorkSansMedium"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.black12,
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              width: 100.0,
                              height: 1.0,
                            ),
                          ],
                        ),
                      SizedBox(height: 10,),
                    ],);
                  }
                  )
                ),
              ],
            );
          }
        },
      ),
    );
  }
}