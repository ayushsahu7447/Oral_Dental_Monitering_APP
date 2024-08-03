import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/config/user.dart';
import 'package:dentalapp/m_config/dashboard.dart';
import 'package:dentalapp/pages/privacypolicy.dart';
import 'package:dentalapp/pages/profile_details.dart';
import 'package:dentalapp/pages/show_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../config/profile_color.dart';
import '../m_config/m_page/profileImage.dart';
import 'complaint_email.dart';
import 'home.dart';
import 'login_page.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen>{
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
  Widget build(BuildContext context){
    final size = MediaQuery
        .of(context)
        .size;
    ScreenUtil.init(context , height: 896 ,width: 414,allowFontScaling: true);
    var ProfileInfo = Expanded(
      child: Column(
        children: [
          Container(
            height: size.height/8,
            width: size.width/4,
            child: Stack(
              children :<Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage("images/assets/Apiero_only-removebg-logo.png") , backgroundColor: Colors.white,
                ),

              ],
            ),
          ),
          SizedBox(height: 20,),
          Text("${loggedInUser.firstName}" , style: kTitleTextStyle),
          SizedBox(height: 2,),
          Text("${loggedInUser.mobNo}", style: TextStyle(color: Colors.black54 , fontWeight: FontWeight.bold)),
          SizedBox(height: 20,),

        ],
      ),
    );
    /*
    var themeSwitcher = ThemeSwitcher(builder: (context){
      return AnimatedCrossFade(
        duration: Duration(milliseconds: 200),
        crossFadeState: ThemeProvider.of(context).brightness == Brightness.dark
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: GestureDetector(
          onTap: () =>
              ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
          child: Icon(
            LineAwesomeIcons.sun,
            size: 30,
          ),
        ),
        secondChild:GestureDetector(
          onTap: ()=>
              ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
          child: Icon(
            LineAwesomeIcons.moon,
            size: 30,
          ),
        ),
      );
    });
    */
    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()));},
          child: Icon(LineAwesomeIcons.arrow_left,
            size: 30,
          ),
        ),
        ProfileInfo,
      ],
    );

    return Builder(builder: (context){
      return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: kSpacingUnit.w * 5,),
            Padding(
                padding: const EdgeInsets.only(left: 30 , right: 30 ,top: 8 ),
                child: loggedInUser.firstName==null?
                Center(child:CircularProgressIndicator(backgroundColor: Colors.redAccent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.red,))):header
            ),
            Expanded(child: ListView(
              children: <Widget>[
                GestureDetector(
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.user_shield,
                    text: 'User Details',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ShowProfile(userID: loggedInUser.uid,))
                    );
                  },
                ),
                GestureDetector(
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.address_book,
                    text: 'Complaint',
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ComplaintEmail())
                    );
                  },
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            PrivacyPolicy())
                    );
                  },
                  child: ProfileListItem(
                      icon: LineAwesomeIcons.question_circle,
                      text: 'Privacy Policy'
                  ),
                ),
                GestureDetector(
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.alternate_sign_out,
                    text: 'Logout',
                  ),
                  onTap: (){
                    logout(context);
                  },
                ),

              ],
            ))
          ],
        ),
      );
    },);
  }

  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => signin()));
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavigaton;

  const ProfileListItem({
    required this.icon,
    this.text,
    this.hasNavigaton=true ,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 40,
      ).copyWith(bottom: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            //Color.fromARGB(255, 81, 177, 241),
            Color(0xFFFF6D00),
            Color(0xFFFF6D00)
          ],
        ),

      ),
      child: Row(
        children: <Widget>[
          Icon(this.icon, size: 25,),
          SizedBox(width: 25,),
          Text(this.text,
            style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500),
          ),
          Spacer(),
          if(this.hasNavigaton)
            Icon(
              LineAwesomeIcons.angle_right,
              size: 25,
            )
        ],
      ),
    );
  }
}