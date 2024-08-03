import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../config/user.dart';

class FormDetail extends StatefulWidget {
  String? userID;
  FormDetail({Key? key , this.userID}) : super(key: key);

  @override
  State<FormDetail> createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> {
  var _formKey = GlobalKey<FormState>();
  String? _dropdownError;
  String? martialstatus ;
  String? occupationstatus ;
  String? typetobacco;
  String? sourcepurchasetobacco;
  String? orderpurchasetobacco;
  String? moneyspent;
  String? attemptquitting;
  String? alocoholuse;
  String? patternalcohol;

  _validateForm() {
    bool _isValid = _formKey.currentState!.validate();

    if (martialstatus == null ||
    occupationstatus == null||
    typetobacco== null||
    sourcepurchasetobacco== null||
    orderpurchasetobacco== null||
    moneyspent==null||
    attemptquitting== null||
    alocoholuse== null||
    patternalcohol==null) {
      setState(() => _dropdownError = "Please select an option!");
      _isValid = false;
    }

    if (_isValid) {
      form();
    }
  }
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

  final educationEditingController = new TextEditingController();
  final servicesEditingController = new TextEditingController();
  final yearEditingController = new TextEditingController();
  final memberEditingController = new TextEditingController();
  final incomeEditingController = new TextEditingController();
  final quantiyEditingController = new TextEditingController();
  final sincehabitEditingController = new TextEditingController();
  final reasontabaccoEditingController = new TextEditingController();
  final expenceEditingController = new TextEditingController();


  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> martialStatus = [
    'Unmarried',
    'Married',
    "Widowed",
    "Separated or Divorced",
    "Not applicable"
  ];
  List<String> occupation = [
    'Professional or Semi-professional',
    'Skilled or Unskilled worker',
    "Retired",
    "Housewife",
    "Student",
    "Unemployed",
    "Other",
  ];

  List<String> cigrate = [
    'Cigarette',
    'Beedi',
    'hookah',
    'Gutka',
    'Kahaini',
    'Paan',
    'Mawa',
    'gul',
    'other'
  ];

  List<String> sourcepurchase = [
    'Near the residence',
    'Near the Workplace',
    'Any Other'
  ];

  List<String> dailypurchase = [
    'Bulk Purchase',
    'Daily Purchase',
    'Whenever needed',
    'Sharing with friends'
  ];

  List<String> drinkingroutine = [
    'Daily Drinking',
    'Regular drinking(3 or more a week)',
    'Social Drinking(less then 3 a week)',
    'None'
  ];

  List<String> yno = ['Yes', 'No'];

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var now = new DateTime.now();

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText , style: TextStyle(
        color: Colors.white, fontSize: 16.0, fontFamily: "SignikaRegular"),), duration: d , backgroundColor: Colors.amber,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future form() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(widget.userID)
        .collection("USER_FORM")
        .add({
      'MartialStatus': martialstatus ,
      'EducationalDetails': educationEditingController.text ,
      'Occupation': occupationstatus ,
      'No_of_year_in_present_services': int.tryParse(yearEditingController.text) ,
      'No_of_members_in_household': int.tryParse(memberEditingController.text) ,
      'Avg_Income_per_month': int.tryParse(incomeEditingController.text) ,
      'Quantity_Consumed_per_Day': int.tryParse(quantiyEditingController.text) ,
      'No_of_year_since_habit_initiated': int.tryParse(sincehabitEditingController.text) ,
      'Type': typetobacco ,
      'Reason_for_use_of_tobacco_prodcts':  reasontabaccoEditingController.text,
      'Expense_for_use_of_tobacco_products': int.tryParse(expenceEditingController.text) ,
      'Source_of_purchase_of_tobacco':  sourcepurchasetobacco,
      'Order_of_purchase_of_tobacco': orderpurchasetobacco,
      'Any_money_spent_on_health_realted_problems_due_to_tobacco_use': moneyspent,
      'Previous_attempts_at_quitting':attemptquitting,
      'Alcohol_use': alocoholuse,
      'Pattern_of_alcohol_use_in_last_year': patternalcohol,
      'datetime': now}).whenComplete(() =>
        showSnackBar(
            "Data Uploaded Successfully:)", Duration(seconds: 2)));
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text("Fill Your Form"),
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                Colors.black12,
                                Colors.black,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          'Apiero',
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontSize: 16.0,
                              fontFamily: "WorkSansMedium"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.black12,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                    ],
                  ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("User Name : ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black)),

                                Text('${loggedInUser.firstName}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xFFFF6D00))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Email :",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black)),

                                Text('${loggedInUser.email}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFFFF6D00))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Card(
                      child: Container(
                        width: double.infinity, // color: Colors.grey[200],
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [
                                0.2,
                                0.8,
                              ],
                              colors: [
                                Color.fromARGB(255, 239, 237, 241),
                                Color.fromARGB(255, 247, 218, 223),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                offset: const Offset(4.0, 4.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                              ),
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-8.0, -4.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                              ),
                            ]),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black12,
                                        Colors.black,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Text(
                                  'Apiero',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontSize: 16.0,
                                      fontFamily: "WorkSansMedium"),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.black12,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Martial Status: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: martialStatus
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    //validator: (item) => item == null ? 'field required' : null,
                                    onChanged: (item) =>
                                        setState((){martialstatus = item ; _dropdownError = null;}),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    "Educational Detail: ",
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Container(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: educationEditingController,
                                    keyboardType: TextInputType.number,
                                    onSaved: (value) {
                                      educationEditingController.text = value!;
                                    },
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Occupation: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: occupation
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    onChanged: (item) {
                                        setState(() => occupationstatus = item);
                                        _dropdownError = null;},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Row(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    " No. of year in: \n present services: ",
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Container(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: yearEditingController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please your Services years");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      yearEditingController.text = value!;
                                    },
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    "No. of members in \nhousehold: ",
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Container(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: memberEditingController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please your Services years");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      memberEditingController.text = value!;
                                    },
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    "Avg. Income per month: ",
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Container(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: incomeEditingController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please fill above detail");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      incomeEditingController.text = value!;
                                    },
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black12,
                                        Colors.black,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Text(
                                  'Apiero',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontSize: 16.0,
                                      fontFamily: "WorkSansMedium"),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.black12,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                            ],
                          ),

/////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////Detail of Tobaco Use////////////////////////////////////////////

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Frequency of Tobacco Use',
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    "Quantity Consumed \nper Day: ",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Container(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: quantiyEditingController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please fill above detail");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      quantiyEditingController.text = value!;
                                    },
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    "No. of year since \nhabit initated: ",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Container(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: sincehabitEditingController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please fill above detail");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      sincehabitEditingController.text = value!;
                                    },
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Type: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: cigrate
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    onChanged: (item) {
                                        setState(() => typetobacco = item);
                                        _dropdownError = null;},

                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black12,
                                        Colors.black,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Text(
                                  'Apiero',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontSize: 16.0,
                                      fontFamily: "WorkSansMedium"),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.black12,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                            ],
                          ),
                          /////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////Daily Tabacco Use////////////////////////////////////////////
                          ///
                          SizedBox(
                            height: size.height / 25,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Daily Habit Pattern',
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(children: [
                            Container(
                              child: const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Reason for use of\ntobacco prodcts: ",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Container(
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: const Color.fromARGB(255, 227, 242, 253),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 207, 234, 255),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromARGB(255, 199, 217, 248),
                                  ),
                                  style: TextStyle(color: Colors.black),
                                  autofocus: false,
                                  controller: reasontabaccoEditingController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Please fill above detail");
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    reasontabaccoEditingController.text = value!;
                                  },
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ),
                          ]),
                          Row(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    "Expense for use of \ntobacco products: ",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                child: Container(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    autofocus: false,
                                    controller: expenceEditingController,
                                      keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please fill above detail");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      expenceEditingController.text = value!;

                                    },
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Source of purchase\nof tobacco: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: sourcepurchase
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    onChanged: (item) {
                                        setState(() => sourcepurchasetobacco = item);
                                        _dropdownError = null;
    _dropdownError = null;},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Order of purchase\nof tobacco: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: dailypurchase
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    onChanged: (item) {
                                        setState(() => orderpurchasetobacco = item);
                                    _dropdownError = null;},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Any money spent\non health realted\nproblems due to \n tobacco use: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: yno
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    onChanged: (item){
                                        setState(() => moneyspent = item);
                                        _dropdownError = null;
    _dropdownError = null;},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Previous attempts \nat quitting: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: yno
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    onChanged: (item){
                                        setState(() => attemptquitting = item);
                                        _dropdownError = null;},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Alcohol Use: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: yno
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    onChanged: (item){
                                        setState(() => alocoholuse = item);
    _dropdownError = null;},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Pattern of alcohol\nuse in last year: ",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                            const Color.fromARGB(255, 227, 242, 253),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 207, 234, 255),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 199, 217, 248),
                                    ),
                                    hint: const Text("Select Options: "),
                                    value: null,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: drinkingroutine
                                        .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 18))))
                                        .toList(),
                                    onChanged: (item) {
                                        setState(() => patternalcohol = item);_dropdownError = null;},
                                  ),
                                ),
                              ),
                            ],
                          ),

                          _dropdownError == null
                              ? SizedBox.shrink()
                              : Text(
                            _dropdownError ?? "",
                            style: TextStyle(color: Color(0xFFFF6D00)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                gradient: LinearGradient(
                                    colors: [Colors.white, Colors.white],
                                    begin: const FractionalOffset(0.2, 0.2),
                                    end: const FractionalOffset(0.5, 0.5),
                                    stops: [0.1, 0.5],
                                    tileMode: TileMode.clamp)),
                            child: MaterialButton(
                              highlightColor: Color(0xFFFF6D00),
                              splashColor: Color(0xFFFF6D00),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 42.0),
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      color: Colors.black,
                                      fontSize: 22.0),
                                ),
                              ),
                              onPressed: () {
                                _validateForm();
                              },
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black12,
                                        Colors.black,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Text(
                                  'Apiero',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontSize: 16.0,
                                      fontFamily: "WorkSansMedium"),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.black12,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
