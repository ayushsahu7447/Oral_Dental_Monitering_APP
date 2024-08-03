import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videos extends StatelessWidget {
  Videos({Key? key}) : super(key: key);

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'Y18Vz51Nkos',
    flags: YoutubePlayerFlags(autoPlay: false, mute: true),
  );
  final YoutubePlayerController _controller1 = YoutubePlayerController(
    initialVideoId: 'WN0jU1-Ni-Y',
    flags: YoutubePlayerFlags(autoPlay: false, mute: true),
  );
  final YoutubePlayerController _controller2 = YoutubePlayerController(
    initialVideoId: 'StM10jzbt1k',
    flags: YoutubePlayerFlags(autoPlay: false, mute: true),
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Videos",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 228, 21, 21),
        elevation: 15.0,
        shadowColor: Color.fromARGB(255, 219, 14, 14),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
              // width: 12,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: 310,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blue,
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            const Text(
              "How do cigarettes affect the body? - Krishna Sudhir",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 25,
              width: 12,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: 310,
              child: YoutubePlayer(
                controller: _controller1,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blue,
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 18.0, left: 30, right: 8),
              child: Text(
                "What happens if You are An Alcohol and Tobacco Addict? - Effects on Brain and Body",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 25,
              width: 12,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: 310,
              child: YoutubePlayer(
                controller: _controller2,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blue,
              ),
            ),

            const Padding(
              padding:
                  EdgeInsets.only(top: 18.0, left: 20, right: 8, bottom: 8),
              child: Text(
                "Stop Drug Cravings with Exercise",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
