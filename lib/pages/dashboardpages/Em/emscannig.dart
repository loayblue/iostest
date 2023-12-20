// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:mrzscanner_flutter/mrzscanner_constants.dart';
import 'package:mrzscanner_flutter/mrzscanner_flutter.dart';
import 'package:securitygate/Widgets/tablet/landscap/left_side_dashboard_land.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/core/app_icons.dart';
import 'package:securitygate/pages/dashboardpages/Em/aprovemirates.dart';
import 'package:securitygate/pages/maindashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class EmScanning extends StatefulWidget {
  String accesstoken;
  String name;
  final BuildContext context;

  EmScanning({
    Key? key,
    required this.accesstoken,
    required this.name,
    required this.context,
  }) : super(key: key);

  @override
  State<EmScanning> createState() => _EmScanningState();
}

class _EmScanningState extends State<EmScanning> {
  @override
  void initState() {
    super.initState();
    getConnectivity();
    startContinuousScanning(context);
    if (Platform.isAndroid) {
      Mrzflutterplugin.registerWithLicenceKey(
          "A38CC831DE2398F931954EEF5A16DEAE42EBEFC3B8F877D7DE3A7282D8D531DC778D34E9806CA17D0325C4259A144E0C903FC479E12F88BD287898B8B36C2254");
    } else if (Platform.isIOS) {
      Mrzflutterplugin.registerWithLicenceKey("A38CC831DE2398F931954EEF5A16DEAE42EBEFC3B8F877D7DE3A7282D8D531DC3117622263D072A9D1F0FB93A5221E6ECF2DD7E1CD99BE5ED0CB6783D11AA9AF");
    }
  }

  String givenname = "";
  String surname = "";
  String country = "";
  String document_type_raw = "";
  String document_type_readable = "";
  String issuing_country = "";
  String document_number = "";
  String nationality = "";
  String expiration_date_readable = "";
  String sex = "";
  String dob_readable = "";
  String document_number_with_check_digit = "";

  String? fullImage;
  String? idBackImage;
  int scannerType = ScannerType.MRZ;

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());

  layoutForMobile(Orientation orientation) {
  
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.backColor,
            body: Container(
                decoration: const BoxDecoration(
                  color: AppColors.backColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             SizedBox(
                                height: 75,
                                width: 250,
                                child: Container(
                                  child: Image.asset(AppIcons.mainlogo,
                                      fit: BoxFit.fitWidth),
                                ),
                              ),
                            ],
                          ),
                           const Text(
                            "Welcome",
                            style: TextStyle(
                  color: AppColors.buttoncolor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                   fontFamily: 'Poppins',
                   letterSpacing: 0.5,
                
                  ),
                          ),
                        
                          Text(
                            widget.name,
                            style: TextStyle(
                  color: AppColors.buttoncolor,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                   fontFamily: 'Poppins',
                   letterSpacing: 0.5,
                
                  ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "SCAN EMARIATES ID",
                            style: TextStyle(
                  color: AppColors.buttoncolor,
                  fontSize: 16,
                //  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        Text(
                'Time: $tdata',
                  style: const TextStyle(
                      color:AppColors.buttoncolor,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      
                 ),
              ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => MainDashboard(
                                                accesstoken: widget.accesstoken,
                                                name: widget.name,
                                              )),
                                      (route) => false);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    elevation: 2,
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fixedSize: const Size(200, 35)
                                    //minimumSize: const Size.fromHeight(60),
                                    ),
                                child: const Text(
                                  "Back To Dashboard",
                                  style: TextStyle(
                                      color: AppColors.backColor,
                                      fontWeight: FontWeight.w500,   fontFamily: 'Poppins',),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Flexible(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: SizedBox(
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Given Name : ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(givenname,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Surname : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(surname,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sex : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(sex,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Country : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(country,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Nationality : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(nationality,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Document Type : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(document_type_raw,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Document : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(document_type_readable,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Birth Date : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(dob_readable,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Expiration Date : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(expiration_date_readable,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Personal Number : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(document_number,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Personal Number 2 : ',
                                        style: TextStyle(
                                            fontSize: 14,fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,),
                                      ),
                                      Text(document_number_with_check_digit ,style: TextStyle(
                                        fontSize: 12,fontFamily: 'Poppins',
                                      ),),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.backColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: BorderSide.none),
                                      elevation: 2,
                                      fixedSize: const Size(300, 30)),
                                  onPressed: () {
                                    if (country.isNotEmpty &&
                                        givenname.isNotEmpty &&
                                        surname.isNotEmpty &&
                                        sex.isNotEmpty &&
                                        document_type_raw.isNotEmpty &&
                                        document_type_readable.isNotEmpty &&
                                        dob_readable.isNotEmpty &&
                                        document_number.isNotEmpty &&
                                        document_number_with_check_digit
                                            .isNotEmpty &&
                                        nationality.isNotEmpty &&
                                        expiration_date_readable.isNotEmpty) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AproveEmirates(
                                                    accessToken:
                                                        widget.accesstoken,
                                                    documenttype:
                                                        document_type_raw,
                                                    givennames: givenname,
                                                    nationalitycode:
                                                        nationality,
                                                    birthday: dob_readable,
                                                    sex: sex,
                                                    country: country,
                                                    expriydate:
                                                        expiration_date_readable,
                                                    personalnumber:
                                                        document_number,
                                                    personalnumber1:
                                                        document_number_with_check_digit,
                                                    sername: surname,
                                                    name: widget.name,
                                                  )));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                            'Please Rescan Id Again'),
                                        backgroundColor: Colors.red.shade300,
                                      ));
                                    }
                                  },
                                  child: const Text(
                                    "Proceed",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  layoutForTablet(Orientation orientation) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SafeArea(
            child: Scaffold(
              backgroundColor:AppColors.backColor,
              body: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.backColor,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 300,
                                  child: Container(
                                    child: Image.asset(AppIcons.mainlogo,
                                        fit: BoxFit.fitWidth),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                              const Text(
                              "Welcome",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700),
                            ),
                        
                           Text(
                              widget.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                        
                            const Text(
                              "SCAN EMARIATES ID",
                               style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                           Text(
                              'Time: $tdata',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => MainDashboard(
                                                  accesstoken:
                                                      widget.accesstoken,
                                                  name: widget.name,
                                                )),
                                        (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 2,
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fixedSize: const Size(300, 40)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "Back To Dashboard",
                                    style: TextStyle(
                                        color:AppColors.backColor,
                                         fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Give Name : ',
                                          style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(givenname , style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'SurName : ',
                                           style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600)
                                        ),
                                        Text(surname ,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sex : ',
                                          style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600)
                                        ),
                                        Text(sex,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Country : ',
                                          style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(country,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Natinality : ',
                                          style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(nationality,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Document Type : ',
                                          style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(document_type_raw,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Document : ',
                                         style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(document_type_readable,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Birth Date : ',
                                         style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(dob_readable,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Expiration Date : ',
                                          style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(expiration_date_readable,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Personal Number : ',
                                           style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(document_number,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Personal Number 2 : ',
                                          style: TextStyle(
                                              fontSize: 22,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(document_number_with_check_digit,style: TextStyle(
                                          fontSize: 18,
                                               fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300
                                        ),),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.backColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            side: BorderSide.none),
                                        elevation: 5,
                                        fixedSize: const Size(400, 45)),
                                    onPressed: () {
                                      if (country.isNotEmpty &&
                                          givenname.isNotEmpty &&
                                          surname.isNotEmpty &&
                                          sex.isNotEmpty &&
                                          document_type_raw.isNotEmpty &&
                                          document_type_readable.isNotEmpty &&
                                          dob_readable.isNotEmpty &&
                                          document_number.isNotEmpty &&
                                          document_number_with_check_digit
                                              .isNotEmpty &&
                                          nationality.isNotEmpty &&
                                          expiration_date_readable.isNotEmpty) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AproveEmirates(
                                                      accessToken:
                                                          widget.accesstoken,
                                                      documenttype:
                                                          document_type_raw,
                                                      givennames: givenname,
                                                      nationalitycode:
                                                          nationality,
                                                      birthday: dob_readable,
                                                      sex: sex,
                                                      country: country,
                                                      expriydate:
                                                          expiration_date_readable,
                                                      personalnumber:
                                                          document_number,
                                                      personalnumber1:
                                                          document_number_with_check_digit,
                                                      sername: surname,
                                                      name: widget.name,
                                                    )));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text(
                                              'Please Rescan Id Again'),
                                          backgroundColor: Colors.red.shade300,
                                        ));
                                      }
                                    },
                                    child: const Text(
                                      " Procced ",
                                      style: TextStyle(
                                          fontSize: 14,
                                            fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        },
      );
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentfocus = FocusScope.of(context);
              if (!currentfocus.hasPrimaryFocus) {
                currentfocus.unfocus();
              }
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.backColor,
                body: Container(
                    decoration: const BoxDecoration(
                      color:AppColors.backColor,
                    ),
                    child: Row(
                      children: [
                            SizedBox(
                    width: 60,
                    child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backColor
                    ),
                    ),
                  ),
                        Flexible(
                          flex: 2,
                          child: leftsidedashboard(widget: EmScanning(accesstoken: widget.accesstoken, name: widget.name, context: context), tdata: tdata,),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30))),
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'GIVEN NAME :  ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(givenname, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'SURNAME : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(surname, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'SEX : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(sex, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'COUNTRY : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(country, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'NATIONALITY : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(nationality, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'DOCUMENT TYPE : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(document_type_raw, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'DOCUMENT : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(document_type_readable, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'BIRTH DATE : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(dob_readable, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'EXPIRATION DATE : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(expiration_date_readable, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'PERSONAL NUMBER : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(document_number, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'PERSONAL NUMBER 2 : ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                              document_number_with_check_digit, style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:AppColors.backColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: BorderSide.none),
                                          elevation: 10,
                                          fixedSize: const Size(300, 40)),
                                      onPressed: () {
                                        if (country.isNotEmpty &&
                                            givenname.isNotEmpty &&
                                            surname.isNotEmpty &&
                                            sex.isNotEmpty &&
                                            document_type_raw.isNotEmpty &&
                                            document_type_readable.isNotEmpty &&
                                            dob_readable.isNotEmpty &&
                                            document_number.isNotEmpty &&
                                            document_number_with_check_digit
                                                .isNotEmpty &&
                                            nationality.isNotEmpty &&
                                            expiration_date_readable
                                                .isNotEmpty) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AproveEmirates(
                                                        accessToken:
                                                            widget.accesstoken,
                                                        documenttype:
                                                            document_type_raw,
                                                        givennames: givenname,
                                                        nationalitycode:
                                                            nationality,
                                                        birthday: dob_readable,
                                                        sex: sex,
                                                        country: country,
                                                        expriydate:
                                                            expiration_date_readable,
                                                        personalnumber:
                                                            document_number,
                                                        personalnumber1:
                                                            document_number_with_check_digit,
                                                        sername: surname,
                                                        name: widget.name,
                                                      )));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                'Please Rescan Id Again'),
                                            backgroundColor:
                                                Colors.red.shade300,
                                          ));
                                        }
                                      },
                                      child: const Text(
                                        "PROCEED",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      );
    }
  }

  getTokenFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenValue = prefs.getString(widget.accesstoken);
    return tokenValue;
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 500) {
          return layoutForMobile(orientation);
        } else {
          return layoutForTablet(orientation);
        }
      }),
    );
  }

  Future<void> startScanning() async {

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      Mrzflutterplugin.setIDActive(true);
      Mrzflutterplugin.setPassportActive(true);
      Mrzflutterplugin.setVisaActive(true);
      Mrzflutterplugin.setVibrateOnSuccessfulScan(true);

      scannerType = ScannerType.DOCUMENT_IMAGE_ID;
      Mrzflutterplugin.setScannerType(scannerType);
      Mrzflutterplugin.setMaxThreads(MaxThreads.TWO);
      Mrzflutterplugin.setExtractIdBackImageEnabled(true);

      String jsonResultString = await Mrzflutterplugin.startScanner;

      if (scannerType == ScannerType.MRZ ||
          scannerType == ScannerType.ID_SESSION) {
        Map<String, dynamic> jsonResult = jsonDecode(jsonResultString);

        fullImage = jsonResult['full_image'];
        idBackImage = jsonResult['id_back'];

      } else {
        fullImage = jsonResultString;
      }
    } on PlatformException catch (ex) {
      String? message = ex.message;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  Future startContinuousScanning(BuildContext context) async {
    Mrzflutterplugin.setIDActive(true);
    Mrzflutterplugin.setPassportActive(true);
    Mrzflutterplugin.setVisaActive(true);
    Mrzflutterplugin.setVibrateOnSuccessfulScan(true);

    scannerType = ScannerType.MRZ;
    Mrzflutterplugin.setScannerType(scannerType);

    callback(result) async {
      if (!result.startsWith("Error")) {
        Map<String, dynamic> jsonResult = jsonDecode(result);
        fullImage = jsonResult['full_image'];
        if (!mounted) return;
        jsonResult;

        debugPrint("Successful scan: $result");
        setState(() {
          givenname = jsonResult['given_names_readable'];
          surname = jsonResult['surname'];
          sex = jsonResult['sex'];
          country = jsonResult['issuing_country'];
          document_type_raw = jsonResult['document_type_raw'];
          document_type_readable = jsonResult['document_type_readable'];
          dob_readable = jsonResult['dob_readable'];
          document_number = jsonResult['document_number'];
          document_number_with_check_digit =
              jsonResult['document_number_with_check_digit'];
          nationality = jsonResult['nationality'];
          expiration_date_readable = jsonResult['expiration_date_readable'];
        });
      }
      Mrzflutterplugin.closeScanner();
    }

    Mrzflutterplugin.startContinuousScanner(callback, true);
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}

