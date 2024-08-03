import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/duo/show_sheduling.dart';
import 'package:dentalapp/m_config/m_page/Videos.dart';
import 'package:dentalapp/m_config/m_page/image_upload.dart';
import 'package:dentalapp/m_config/my_card.dart';
import 'package:dentalapp/m_config/m_page/phScale.dart';
import 'package:dentalapp/pages/login_page.dart';
import 'package:dentalapp/pages/profile.dart';
import 'package:dentalapp/pages/profile_details.dart';
import 'package:dentalapp/pages/show_form.dart';
import 'package:dentalapp/pages/show_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../config/user.dart';
import '../duo/event.dart';
import '../pages/Form.dart';
import '../pages/show_rating.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
  final List<Widget> screens = [const Dashboard(), ProfileScreen()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  // ignore: prefer_final_fields
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'EJZ2w-3Suhk',
    flags: const YoutubePlayerFlags(autoPlay: false, mute: true),
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: loggedInUser.firstName == null
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.deepOrangeAccent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.deepOrange,
                  )))
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xFFFF6D00)),
                  child: Column(
                    children: [
                      // appBar
                      SizedBox(height: size.height / 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        // ignore: prefer_const_literals_to_create_immutables
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${loggedInUser.firstName}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${loggedInUser.mobNo}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileDetails()),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(Icons.person),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            ]),
                      ),

                      SizedBox(height: size.height / 60),

                      /*Container(
                  width: double.infinity,
                  height: size.height / 15,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        icon: Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 20.0,
                          color: Colors.black54,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),*/

                      SizedBox(height: size.height / 20),

                      // cards
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Quotes",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    height: 25,
                                    width: 10,
                                  ),
                                  Container(
                                    height: height * 0.21,
                                    width: width * 0.75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: const LinearGradient(
                                        colors: [
                                          //Color.fromARGB(255, 0, 0, 0),
                                          //Color.fromARGB(255, 80, 80, 80),
                                          Colors.black,
                                          Colors.black54
                                        ],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: //Color.fromARGB(255, 97, 14, 241)
                                              Colors.deepOrange,
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CustomPaint(
                                        size: Size(width, height),
                                        // painter: CardCustomPainter(),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              bottom: 00,
                                              left: 0,
                                              child: Image.asset(
                                                'images/assets/GNShape08.png',
                                                color: Colors.purpleAccent
                                                    .withOpacity(0.5),
                                                width: width * 0.8,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: -20,
                                              child: Image.asset(
                                                'images/assets/Brushes126.png',
                                                color: Colors.white70
                                                    .withOpacity(1),
                                                width: width * 1.5,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(22.0),
                                                  child: Text(
                                                    "No matter how hard the past is, you can always begin again.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 25,
                                  //   width: 12,
                                  // ),
                                  // Container(
                                  //   width: 310,
                                  //   child: YoutubePlayer(
                                  SizedBox(
                                    height: size.height / 8,
                                    width: 20,
                                  ),
                                  Container(
                                    height: height * 0.21,
                                    width: width * 0.75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: const LinearGradient(
                                        colors: [
                                          //Color.fromARGB(255, 0, 0, 0),
                                          //Color.fromARGB(255, 80, 80, 80),
                                          Colors.black,
                                          Colors.black54
                                        ],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.deepOrange,
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CustomPaint(
                                        size: Size(width, height),
                                        // painter: CardCustomPainter(),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              bottom: 30,
                                              left: 90,
                                              child: Image.asset(
                                                'images/assets/yoga.png',
                                                color: Colors.purpleAccent
                                                    .withOpacity(0.3),
                                                width: width * 0.3,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: -20,
                                              child: Image.asset(
                                                'images/assets/Brushes126.png',
                                                color: Colors.white70
                                                    .withOpacity(1),
                                                width: width * 1.5,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(22.0),
                                                  child: Text(
                                                    "The longest journey of any person is the journey inward.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            const Text(
                              "Services",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/camera.png',
                                            buttonText: "Upload\nImage",
                                          ),
                                          onTap: () async {
                                            await availableCameras().then(
                                              (value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageUpload(
                                                    userID: loggedInUser.uid,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/yoga.png',
                                            buttonText: "View\nImages",
                                          ),
                                          onTap: () async {
                                            await availableCameras().then(
                                              (value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowUploads(
                                                    userID: loggedInUser.uid,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        // SizedBox(
                                        //   width: size.width / 30,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/law.png',
                                            buttonText: "Burn\nScale",
                                          ),
                                          onTap: () async {
                                            await availableCameras().then(
                                              (value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RateBurn(
                                                    userID: loggedInUser.uid,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/meditation.png',
                                            buttonText: "Rating\nUploads",
                                          ),
                                          onTap: () async {
                                            await availableCameras().then(
                                              (value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowRating(
                                                    userID: loggedInUser.uid,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        // SizedBox(
                                        //   width: size.width / 8,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/appointment.png',
                                            buttonText: "Schedule\nAppointment",
                                          ),
                                          onTap: () async {
                                            await availableCameras().then(
                                              (value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventEdit(
                                                    userID: loggedInUser.uid,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath: 'images/clock.png',
                                            buttonText: "View\nAppointment",
                                          ),
                                          onTap: () async {
                                            await availableCameras().then(
                                              (value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowShedule(
                                                    userID: loggedInUser.uid,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        // SizedBox(
                                        //   width: size.width / 30,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/prescription.png',
                                            buttonText: "Case\nHistory",
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FormDetail(
                                                          userID:
                                                              loggedInUser.uid,
                                                        )));
                                          },
                                        ),
                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/prescription.png',
                                            buttonText: "View\nCase History",
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowForm(
                                                            userID: loggedInUser
                                                                .uid)));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/exercises.png',
                                            buttonText: "Oral\nPhysiotherapy",
                                          ),
                                          onTap: () {},
                                        ),
                                        GestureDetector(
                                          child: const MyButton(
                                            iconImagePath:
                                                'images/assets/video-player.png',
                                            buttonText: "Videos",
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Videos()));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

      //  3 buttons

      // column -> stats  +  transactions
    );


  }
  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => signin()));
  }
}
