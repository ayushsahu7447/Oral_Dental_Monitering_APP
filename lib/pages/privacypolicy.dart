import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6D00),
        leading: GestureDetector(
          onTap: () {Navigator.of(context).pop();},
          child: Icon(LineAwesomeIcons.arrow_left,
            size: 30,
          ),
        ),
        title: Text(
          "    Privacy Policy " ,  style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: size.height/1.2,
        margin: EdgeInsets.symmetric(vertical: size.width/40,
          horizontal: size.height/40,
        ).copyWith(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(33),
            color: Colors.grey.shade200,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Privacy Policy" , style: TextStyle(color: Color(0xFFFF6D00) , fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height/90,),
              Text(
                """APEIRO built the dental app as an Open Source app. This SERVICE is provided by APEIRO at no cost and is intended for use as is.
                  This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.
                  If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.
              The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at dental app unless otherwise defined in this Privacy Policy.
                  """
              ),
              SizedBox(height: size.height/90,),
              Text(
                "Information Collection and Use" , style: TextStyle(color: Color(0xFFFF6D00) , fontWeight: FontWeight.bold
              ),),
              SizedBox(height: size.height/90,),
              Text(
                """For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to NAME, AGE, SEX, HEIGHT, WEIGHT,
                 PHONE NUMBER, EMAIL ADDRESS, MEDICAL REPORT . The information that we request will be retained by us and used as described in this privacy policy.
                  The app does use third-party services that may collect information used to identify you.
                  Link to the privacy policy of third-party service providers used by the app
                  •	Google Play Services
                """
              ),
              SizedBox(height: size.height/90,),
              Text(
                "Log Data" , style: TextStyle(color: Color(0xFFFF6D00) , fontWeight: FontWeight.bold
              ),),
              SizedBox(height: size.height/90,),
              Text(
                  """We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information 
                  (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet
                   Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time 
                   and date of your use of the Service, and other statistics.
                """
              ),
              SizedBox(height: size.height/90,),
              Text(
                "Cookies" , style: TextStyle(color: Color(0xFFFF6D00) , fontWeight: FontWeight.bold
              ),),
              SizedBox(height: size.height/90,),
              Text(
                  """Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser 
                  from the websites that you visit and are stored on your device's internal memory. This Service does not use these “cookies” explicitly. 
                  However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the 
                  option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, 
                  you may not be able to use some portions of this Service.
                """
              ),
              SizedBox(height: size.height/90,),

            ],
          ),
        ),
    ),
    );
  }
}
