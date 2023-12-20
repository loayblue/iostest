// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:securitygate/Widgets/tablet/landscap/left_side_dashboard_land.dart';
import 'package:securitygate/Widgets/tablet/landscap/left_side_tablet_land.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/core/app_icons.dart';
import 'package:securitygate/pages/dashboardpages/Em/emscannig.dart';
import 'package:securitygate/utils/validator.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:securitygate/core/api_client.dart';
import 'package:securitygate/pages/maindashboard.dart';

class AproveEmirates extends StatefulWidget {
  final String accessToken;
  final String documenttype;
  final String givennames;
  final String nationalitycode;
  final String birthday;
  final String sex;
  final String expriydate;
  final String personalnumber;
  final String personalnumber1;
  final String sername;
  final String name;
  final String country;

  const AproveEmirates({
    Key? key,
    required this.accessToken,
    required this.documenttype,
    required this.givennames,
    required this.nationalitycode,
    required this.birthday,
    required this.sex,
    required this.expriydate,
    required this.personalnumber,
    required this.personalnumber1,
    required this.sername,
    required this.name,
    required this.country,
  }) : super(key: key);

  @override
  State<AproveEmirates> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AproveEmirates> {
  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  FocusNode fone = FocusNode();
  FocusNode ftow = FocusNode();
  FocusNode fthree = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiClient _apiClient = ApiClient();
  final TextEditingController reasonofEntry = TextEditingController();
  final TextEditingController unitname = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());

  layoutForMobile(Orientation orientation) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentfocus = FocusScope.of(context);
            if (!currentfocus.hasPrimaryFocus) {
              currentfocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.backColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                          "Approve User ",
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
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    width: size.width,
                    height:500,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         SizedBox(
                          height: 40,
                         ),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                        focusNode: fone,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(ftow);
                                        },
                                        controller: reasonofEntry,
                                        validator: (value) {
                                          return Validator.validateText(
                                              value ?? "");
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Reason of entry',
                                        labelStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey),
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                width: double.infinity)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 5),
                                        color: Colors.white,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 300,
                                                child: TextFormField(
                                                    focusNode: ftow,
                                                    onFieldSubmitted:
                                                        (value) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              fthree);
                                                    },
                                                    controller: unitname,
                                                    validator: (value) {
                                                      return Validator
                                                          .validateText(
                                                              value ?? "");
                                                    },
                                                    decoration:
                                                        InputDecoration(
                                                     labelText:
                                                              "Appartment number",
                                                          labelStyle: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .green,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          Colors.black12)),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          Colors.black12)),
                                                    )),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: IntlPhoneField(
                                       initialCountryCode: 'AE',
                                      focusNode: fthree,
                                      controller: phonecontroller,
                                      decoration:  InputDecoration(
                                          fillColor: Colors.white,
                                            contentPadding:
                                                EdgeInsets.all(1),
                                            labelText: "Phone Number",
                                            labelStyle:
                                                TextStyle(fontSize: 12),
                                            helperText:
                                                'Standard call, messaging or data rates may apply.',
                                            helperStyle:
                                                TextStyle(fontSize: 10,fontFamily:
                                                                  'Poppins',),
                                            counterText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .black12)),
                                            enabledBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .black12)),),
                                    ),
                                  ),
                                  SizedBox(height: 20),
            
                                  ElevatedButton(
                                    onPressed: () {
                                      if (phonecontroller.text.isNotEmpty) {
                                        postEmirates();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text(
                                              'Please Enter PhoneNumber'),
                                          backgroundColor:
                                              Colors.red.shade300,
                                        ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        elevation: 2,
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        backgroundColor:
                                            AppColors.backColor,
                                        fixedSize: const Size(300, 40 )
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text(
                                      "Add User",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w500,fontFamily:
                                                                  'Poppins',),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              )),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  layoutForTablet(Orientation orientation) {
    var size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
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
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.backColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Approve User ",
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          width: size.width,
                          height: size.height,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            width: 350,
                                            child: TextFormField(
                                                focusNode: fone,
                                                onFieldSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .requestFocus(ftow);
                                                },
                                                controller: reasonofEntry,
                                                validator: (value) {
                                                  return Validator.validateText(
                                                      value ?? "");
                                                },
                                                decoration: InputDecoration(
                                                labelText: 'Reason of Entry',
                                            labelStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    width: double.infinity)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black12)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black12)),
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 5),
                                                color: Colors.white,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 350,
                                                        child: TextFormField(
                                                            focusNode: ftow,
                                                            onFieldSubmitted:
                                                                (value) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      fthree);
                                                            },
                                                            controller:
                                                                unitname,
                                                            validator: (value) {
                                                              return Validator
                                                                  .validateText(
                                                                      value ??
                                                                          "");
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Appartment number",
                                                              labelStyle: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 20),
                                                              fillColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.black12)),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.black12)),
                                                            )),
                                                      ),
                                                    ]),
                                              ),
                                         
                                            ],
                                          ),
                                               const SizedBox(
                                                height: 20,
                                              ),
                                      
                                          SizedBox(
                                            width: 350,
                                            child: IntlPhoneField(
                                               initialCountryCode: 'AE',
                                              focusNode: fthree,
                                              controller: phonecontroller,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.all(20),
                                                labelText: "Phone Number",
                                                labelStyle:
                                                    TextStyle(fontSize: 12),
                                                helperText:
                                                    'Standard call, messaging or data rates may apply.',
                                                helperStyle:
                                                    TextStyle(fontSize: 10),
                                                counterText: "",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .black12)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .black12)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (phonecontroller
                                                  .text.isNotEmpty) {
                                                postEmirates();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: const Text(
                                                      'Please Enter PhoneNumber'),
                                                  backgroundColor:
                                                      Colors.red.shade300,
                                                ));
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                elevation: 2,
                                                textStyle: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                                backgroundColor:
                                                    AppColors.backColor,
                                                fixedSize: const Size(350, 40)
                                                //minimumSize: const Size.fromHeight(60),
                                                ),
                                            child: const Text(
                                              " Submit ",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 60,
                                          ),
                                        ],
                                      )),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.backColor,
                  ),
                  child: SingleChildScrollView(
                    // reverse: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60,
                          child: Container(
                            decoration:
                                BoxDecoration(color: AppColors.backColor),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: leftsidedashboard(
                            widget: EmScanning(
                                accesstoken: widget.accessToken,
                                name: widget.name,
                                context: context),
                            tdata: tdata,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: size.width,
                            height: size.height,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            width: 355,
                                            child: TextFormField(
                                                focusNode: fone,
                                                onFieldSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .requestFocus(ftow);
                                                },
                                                controller: reasonofEntry,
                                                validator: (value) {
                                                  return Validator.validateText(
                                                      value ?? "");
                                                },
                                                decoration: InputDecoration(
                                                  labelText: "Reason of Entry",
                                                  labelStyle: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 20),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .black12)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .black12)),
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 5),
                                                color: Colors.white,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 355,
                                                        child: TextFormField(
                                                            focusNode: ftow,
                                                            onFieldSubmitted:
                                                                (value) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      fthree);
                                                            },
                                                            controller:
                                                                unitname,
                                                            validator: (value) {
                                                              return Validator
                                                                  .validateText(
                                                                      value ??
                                                                          "");
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Appartment number",
                                                              labelStyle: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 20),
                                                              fillColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.black12)),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.black12)),
                                                            )),
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 360,
                                            height: 75,
                                            child: IntlPhoneField(
                                               initialCountryCode: 'AE',
                                              focusNode: fthree,
                                              controller: phonecontroller,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.all(20),
                                                labelText: "Phone Number",
                                                labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                                helperText:
                                                    'Standard call, messaging or data rates may apply.',
                                                helperStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .black12)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .black12)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (phonecontroller
                                                  .text.isNotEmpty) {
                                                postEmirates();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: const Text(
                                                      'Please Enter PhoneNumber'),
                                                  backgroundColor:
                                                      Colors.red.shade300,
                                                ));
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                elevation: 2,
                                                textStyle: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                                backgroundColor:
                                                    AppColors.backColor,
                                                fixedSize: const Size(355, 40)
                                                //minimumSize: const Size.fromHeight(60),
                                                ),
                                            child: const Text(
                                              "Submit",
                                              style: TextStyle(
                                                  letterSpacing: 0.4,
                                                  color: AppColors.buttoncolor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 60,
                                          ),
                                        ],
                                      )),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> postEmirates() async {
    String accesstoken = widget.accessToken;
    if (_formKey.currentState!.validate()) {
      dynamic res = await _apiClient.postFroEmirates(
          accesstoken,
          widget.documenttype,
          widget.givennames,
          widget.nationalitycode,
          widget.birthday,
          widget.sex,
          widget.expriydate,
          widget.personalnumber,
          widget.personalnumber1,
          widget.sername,
          phonecontroller.text,
          unitname.text,
          reasonofEntry.text,
          phonecontroller.text);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res['statusCode'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sucess'),
          backgroundColor: Color.fromARGB(255, 43, 155, 5),
        ));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MainDashboard(
                      accesstoken: accesstoken,
                      name: widget.name,
                    )),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Error: Server Error}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
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
