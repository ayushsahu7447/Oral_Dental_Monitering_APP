import 'dart:io';
import 'package:dentalapp/m_config/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ImageUpload extends StatefulWidget {
  String? userID;
  ImageUpload({Key? key, this.userID}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;
  bool x = false;
  bool _showCircularProgressIndicator = true;

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
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
    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();

    await firebaseFirestore.collection("users").doc(widget.userID).collection("images").add({'downloadURL' : downloadURL , 'dateTime' : now}).whenComplete(() =>{
      setState(()=>{
        x = false,
        _image= null
      })});

    showSnackBar("Image Upload Succesfully :)", Duration(seconds: 2));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Upload"),
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
                              child: _image == null
                                  ? const Center(
                                      child: Text("No Image Selected"),
                                    )
                                  : Image.file(_image!),
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
                                  if (_image != null) {
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
                                child: Text("Upload Image")),
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