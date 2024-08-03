import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/pages/login_page.dart';
import 'package:dentalapp/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../config/user.dart';
import '../m_config/dashboard.dart';
import '../m_config/m_page/profileImage.dart';

class Home extends StatefulWidget {
  // const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    ShowUploadsx(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: (PageStorage(bucket: bucket, child: currentScreen)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {showRating();},
        child: Image.asset(
          "images/ae85a3de-02ef-4add-b8a1-639788bd7a91-removebg-preview.png",color: Colors.deepOrange,
          height: size.height/4,
          width: size.height/4,
          fit: BoxFit.fill,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: size.height/40,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFFF6D00),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30))),

          height: size.height/10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: size.width/20),
                    child: MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Dashboard();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 0
                                ? Colors.white
                                : Color.fromARGB(255, 39, 37, 37),
                          ),
                          Text(
                            '     Home    ',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: currentTab == 0
                                  ? Colors.white
                                  : Color.fromARGB(255, 59, 59, 59),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size.width/2.6),
                    child: MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        setState(() {
                          currentScreen = ShowUploadsx(userID: loggedInUser.uid,);
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: currentTab == 1
                                ? Colors.white
                                : Color.fromARGB(255, 31, 30, 30),
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: currentTab == 1
                                  ? Colors.white
                                  : Color.fromARGB(255, 29, 29, 29),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showRating() => loggedInUser.firstName==null?
  Center(child:CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,
  valueColor: AlwaysStoppedAnimation<Color>(
  Colors.deepOrange,))):showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Text("Stay Tuned ${loggedInUser.firstName}" , style: TextStyle(fontWeight: FontWeight.bold),),
        content: Container(
          decoration: BoxDecoration(
              color: Color(0xFFFF6D00),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  " “To ensure good health: eat lightly, breathe deeply, live moderately, cultivate cheerfulness, and maintain an interest in life.” ",
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic , color: Colors.white),
                ),
                const SizedBox(height: 2),
              ]),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 16 , color: Color(0xFFFF6D00)),
              )),
          TextButton(onPressed: (){
            logout(context);
            },
              child:  Text(
            'LOGOUT',
            style: TextStyle(fontSize: 16 , color: Color(0xFFFF6D00)),
          ))
        ],
      ));

  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => signin()));
  }
}
