import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../config/profile_color.dart';
import '../config/user.dart';
import '../m_config/m_page/profileImage.dart';

class ProfileDetails extends StatefulWidget{
  String? userID;
  ProfileDetails({Key? key ,  this.userID}) : super(key: key);

  @override
  _ProfileDetails createState() => _ProfileDetails();
}

class _ProfileDetails extends State<ProfileDetails> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  bool isLoading = false;

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
          height: size.height/8,
          width: size.width/4,
          child: Stack(
            children: [
              CircleAvatar(
                radius: kSpacingUnit.w * 5,
                backgroundImage: AssetImage("images/user.png"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: size.height/20,
                  width: size.width/20,
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .accentColor
                        .withOpacity(.9),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await availableCameras().then(
                            (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageUploadx(
                              userID: loggedInUser.uid,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      LineAwesomeIcons.pen,
                      size: 18,
                      color: kDarkSecondaryColor,
                      //size: ScreenUtil().setSp(kSpacingUnit.w * 3),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    Container(
      height: size.height/1.7,
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
          leading: GestureDetector(
            onTap: () {Navigator.of(context).pop();},
            child: Icon(LineAwesomeIcons.arrow_left,color: Colors.red,
              size: 30,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Profile Details', style: TextStyle(color: Colors.red),),
        ),
        body:
        loggedInUser.firstName==null?
        Center(child:CircularProgressIndicator(backgroundColor: Colors.redAccent,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.red,))):
          SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: ProfileInfo
                  ),
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
                ]
            ),
          ),
        );
  }
}