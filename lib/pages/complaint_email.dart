import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/palette.dart';

class ComplaintEmail extends StatefulWidget {
  const ComplaintEmail({Key? key}) : super(key: key);

  @override
  State<ComplaintEmail> createState() => _ComplaintEmailState();
}

class _ComplaintEmailState extends State<ComplaintEmail> {

  //final controllerTo = "ayushsahu363@gmail.com";
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {Navigator.of(context).pop();},
          child: Icon(LineAwesomeIcons.arrow_left,color: Colors.black,
            size: 30,
          ),
        ),
        title: Text("Complaint on EMAIL" , style: TextStyle(color: Colors.black87),),
      backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("To -: apierotechnica@gmail.com" ,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
            //buildTextField(title: 'To', controller: controllerTo , icon: Icon(MaterialCommunityIcons.email , color: Colors.red,)),
            SizedBox(height: 20,),
            buildTextField(title: 'Subject', controller: controllerSubject , icon: Icon(MaterialCommunityIcons.pen , color: Colors.red,)),
            SizedBox(height: 20,),
            buildTextField(title: 'Message', controller: controllerMessage , icon: Icon(MaterialCommunityIcons.pen_plus , color: Colors.red,),
            maxLines: 8),
            SizedBox(height: 20,),
            bottomButton("SEND", () {launchEmail(
              //toEmail: "ayushsahu363@gmail.com",
              subject: controllerSubject.text,
              message: controllerMessage.text,
            );})
          ],
        ),
      ),
    );
  }

  Future launchEmail({
    //required String toEmail,
    required String subject,
    required String message,
  })async{

    //var toEmail = "ayushsahu363@gmail.com";
    final url = 'mailto:"apierotechnica@gmail.com"?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

    if(await launch(url)){
      await launch(url);
    }
  }

  Widget buildTextField({
    required Icon icon,
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ,
            style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8,),
          TextField(
            maxLines: maxLines,
            controller: controller,
            decoration: InputDecoration(
            prefixIcon: icon,
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius:BorderRadius.all(Radius.circular(35.0)),
            ),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius:BorderRadius.all(Radius.circular(35.0)),
            ),
            contentPadding: EdgeInsets.all(10),
            ),
            ),
        ],
      );

  Widget bottomButton(String text , Function navigate) {
    final size = MediaQuery
        .of(context)
        .size;
    return ElevatedButton(
      onPressed: () {navigate();},
      style: ElevatedButton.styleFrom(textStyle: TextStyle(color: Colors.white),
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFFF6D00),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
            boxShadow: [BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 2),
                blurRadius: 10
            )
            ]
        ),
        padding: EdgeInsets.fromLTRB(
            size.width / 5, size.height / 50, size.width / 5,
            size.height / 50),
        child: Text(
            text ,
            style: TextStyle(fontSize: 20)
        ),
      ),
    );
  }
}