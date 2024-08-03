import 'dart:io';
import 'package:dentalapp/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../config/user.dart';


class ShowUploadsx extends StatefulWidget {
  String? userID;
  ShowUploadsx({Key? key , this.userID}) : super(key: key);

  @override
  State<ShowUploadsx> createState() => _ShowUploadsxState();
}

class _ShowUploadsxState extends State<ShowUploadsx> {

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
  @override
  Widget build(BuildContext context)=> Scaffold(
    body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.userID).collection("imagesx").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
    {
      print('image data');
      print(snapshot.data);
    if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return ImageUploadx(userID: loggedInUser.uid,);
      //return ProfileScreen();
    }
      else if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      else if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

    else if(snapshot.hasData){
      return ProfileScreen();
        }

    return CircularProgressIndicator();

      },
    ),
  );
}


class ImageUploadx extends StatefulWidget {
  String? userID;
  ImageUploadx({Key? key, this.userID}) : super(key: key);

  @override
  State<ImageUploadx> createState() => _ImageUploadxState();
}

class _ImageUploadxState extends State<ImageUploadx> {
  File? _imagex;
  final imagePickerx = ImagePicker();
  String? downloadURLX;
  bool x = false;
  bool _showCircularProgressIndicator = true;

  Future imagePickerMethod() async {
    final pick = await imagePickerx.pickImage(source: ImageSource.camera);
    setState(() {
      if (pick != null) {
        _imagex = File(pick.path);
      } else {
        showSnackBar("No file selected", Duration(milliseconds: 50));
      }
    });
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Uploading the image then getting the download url and time

  Future uploadImage() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd-hh-mm');
    final String formatted = formatter.format(now);
    final postID = formatted.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userID}images")
        .child("post_$postID");
    await ref.putFile(_imagex!);
    downloadURLX = await ref.getDownloadURL();

    await firebaseFirestore.collection("users").doc(widget.userID).collection("imagesx").add({'downloadURLX' : downloadURLX , 'dateTime' : now}).whenComplete(() =>{
      setState(()=>{
        x = false,
        _imagex = null
      })});

    showSnackBar("Image Upload Successfully :)", Duration(seconds: 2));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Please Upload Your Profile"),
        backgroundColor:Color(0xFFFF6D00),),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  const Text("Upload Image"),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xFFFF6D00))),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _imagex == null
                                  ? const Center(
                                child: Text("No Image Selected"),
                              )
                                  : Image.file(_imagex!),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF6D00)),
                                ),
                                onPressed: () {
                                  imagePickerMethod();
                                },
                                child: Text("Capture Image")),
                            x==true?
                            Center(child:CircularProgressIndicator()):ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF6D00)),
                                ),
                                onPressed: () {
                                  if (_imagex != null) {
                                    setState(()=>{
                                      x=true
                                    });
                                    uploadImage();
                                  } else {
                                    showSnackBar("Capture Image First",
                                        Duration(seconds: 5));
                                  }
                                  // new Future.delayed(new Duration(seconds: 4),
                                  //     () {
                                  //   Navigator.pop(context); //pop dialog
                                  //   Dashboard();
                                  // });
                                },
                                child: Text("Upload Profile Image")),
                          ],
                        ),
                      ),
                    ),
                    flex: 4,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}