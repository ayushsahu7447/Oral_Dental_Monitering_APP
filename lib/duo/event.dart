import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/duo/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../config/event_data.dart';

class EventEdit extends StatefulWidget {
  String? userID;
  //final Event? event;
  EventEdit({
    Key? key,
    //this.event
    this.userID
}) : super(key: key);

  @override
  State<EventEdit> createState() => _EventEditState();
}

class _EventEditState extends State<EventEdit> {
  void showRating() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Schedule Your Appointment"),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Shedule Your Suitable Time\nFor Ex:\nIf you want to schedule and Available between\nFROM - 1 june 2022 (10:00 AM)TO - 2 june 2022 (4:00 PM)",
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 2),
            ]),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 16),
              ))
        ],
      ));

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;

  var now = new DateTime.now();


  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText , style: TextStyle(
        color: Colors.white, fontSize: 16.0, fontFamily: "SignikaRegular"),), duration: d , backgroundColor: Colors.amber,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future Schedule() async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      await firebaseFirestore
          .collection("users")
          .doc(widget.userID)
          .collection("schedule")
          .add({'title': titleController.text,
        'from': fromDate,
        'to': toDate, 'datetime': now}).whenComplete(() =>
          showSnackBar(
              "Your Appointment Schedule Successfully", Duration(seconds: 2)));
    }





  @override
  void initState() {
    super.initState();

    if (widget.userID == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }

    if(fromDate==null || toDate == null){
      fromDate =DateTime.now();
      toDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(LineAwesomeIcons.arrow_left, color: Colors.white,
            size: 30,
          ),
        ),
        backgroundColor: Color(0xFFFF6D00),
        elevation: 0,
        title: Text('Scheduling', style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 32),
              TextButton(
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Color(0xFFFF6D00),
                  child: Text(
                    " About Scheduling " ,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                onPressed: () => showRating(),
              ),
              SizedBox(height: 20,),
              buildTitle(),
              SizedBox(height: 40,),
              buildDateTimePicker(),

              Center(
                child: ElevatedButton.icon(onPressed: () {Schedule();},
                  icon: Icon(Icons.save),
                  label: Text("Save" , style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() =>
      TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Add Issue : '
        ),
        onFieldSubmitted: (_) {},
        controller: titleController,
        validator: (title) =>
        title != null && title.isEmpty ? 'Title cannot be empty' : null,
      );

  Widget buildDateTimePicker() =>
      Column(
        children: [
          buildFrom(),

          SizedBox(height: 20,),
          buildTo()
        ],
      );

  Widget buildFrom() =>
      buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropdownField(
                    text: Utils.toDate(fromDate??DateTime.now()),
                    onClicked: () {pickFromDateTime(pickDate: true);
                    }
                )),
            Expanded(child: buildDropdownField(
                text: Utils.toTime(fromDate??DateTime.now()),
                onClicked: () {pickFromDateTime(pickDate: false);}
            )),
          ],
        ),
      );

  Widget buildTo() =>
      buildHeader(
        header: 'To',
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropdownField(
                    text: Utils.toDate(toDate??DateTime.now()),
                    onClicked: () {
                      pickToDateTime(pickDate: true);
                    }
                )),
            Expanded(child: buildDropdownField(
                text: Utils.toTime(toDate??DateTime.now()),
                onClicked: (){pickToDateTime(pickDate: false);}
            )),
          ],
        ),
      );


  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: TextStyle(fontWeight: FontWeight.bold),),
          child,
        ],
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate??DateTime.now(), pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate??DateTime.now()))
      toDate =
          DateTime(date.year, date.month, date.day, toDate?.hour??0, toDate?.minute??0);

    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate??DateTime.now(), pickDate: pickDate  , firstDate: pickDate ? fromDate :null);
    if (date == null) return;
    if (date.isAfter(toDate??DateTime.now()))
      toDate = DateTime(date.year, date.month, date.day, toDate?.hour??0, toDate?.minute??0);

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context, initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2020, 1),
        lastDate: DateTime(2101),);
      if (date == null) return null;
      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute,);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) return null;

      final date = DateTime(
          initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  /*
  Future saveForm() async {
    final isvalid = _formKey.currentState !.validate();
    if (isvalid) {
      final event = Event(
        title: titleController.text,
        discription: 'Description',
        from: fromDate,
        to: toDate,);
    }
  }*/
}