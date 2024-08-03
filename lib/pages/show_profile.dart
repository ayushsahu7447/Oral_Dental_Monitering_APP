import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../config/profile_color.dart';
import '../config/user.dart';
import '../m_config/m_page/profileImage.dart';

class ShowProfile extends StatefulWidget {

  String? userID;
  ShowProfile({Key? key, this.userID}) : super(key: key);
  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override


  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    var ProfileInfo = Column(
      children: [
        Container(
          height: size.height/1.9,
          margin: EdgeInsets.symmetric(vertical: size.width/40,
            horizontal: size.height/40,
          ).copyWith(bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              color: Colors.grey.shade200
          ),

          child: ListView(padding: EdgeInsets.only(left: 20),
              children: <Widget>[
                SizedBox(height: 10,),
                Text("User Name : ${loggedInUser.firstName}", style: TextStyle( fontSize: size.height/45 , fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                Text("Mobile Number : ${loggedInUser.mobNo}", style: TextStyle( fontSize: size.height/45 , fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
              ]),
        )

      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6D00),
        title: const Text("Profile Details"),
      ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(widget.userID)
              .collection("imagesx")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData|| snapshot.data!.docs.isEmpty)
              return (const Center(
                child: Text("loading..."),
              ));


              return Column(
                children: [
                  Flexible(
                    child:Container(
                      constraints: BoxConstraints.expand(),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/background.jpg"),
                            fit: BoxFit.cover),
                      ),
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context , int index){
                        String url = snapshot.data!.docs[index]['downloadURLX'];
                       return Column(
                          children: [
                            Container(
                              height: size.height/8,
                              width: size.width/4,
                              child: Stack(
                                children: [CircleAvatar(
                                      radius: kSpacingUnit.w * 5,
                                        child:Image.network(url,
                                          fit: BoxFit.cover,
                                        ),
                                      backgroundColor: Colors.transparent,
                                      //backgroundImage: AssetImage("images/user.png"),
                                      //backgroundImage:url==null?NetworkImage(url):NetworkImage(url)
                                    ),
                                ],
                              ),
                            ),
                          ProfileInfo,
                          Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 40,
                              ).copyWith(bottom: 20),
                              padding: EdgeInsets.symmetric(vertical: 20,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: Colors.black,
                              ),
                              child:
                              Text(
                                "If You want to change Your Profile - Mail on apierotechnica@gmail.com",
                                style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                              ))
                        ],
                      );}
                  ),
                  )
    )]
    );  })
  )
  ;
}
}