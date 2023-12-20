import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:securitygate/core/api_client.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/core/app_icons.dart';
import 'package:securitygate/modle/units.dart';
import 'package:securitygate/pages/maindashboard.dart';
import 'package:securitygate/utils/validator.dart';

class AprovescanUser extends StatefulWidget {
  final String accesstoken;
  final String userid;
  final String name;

  const AprovescanUser({
    Key? key,
    required this.accesstoken,
    required this.userid,
    required this.name,
  }) : super(key: key);

  @override
  State<AprovescanUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AprovescanUser> {
  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  var loading = false;
  bool isDataLoaded = false;
  final ApiClient _apiClient = ApiClient();
  final TextEditingController reasonofEntry = TextEditingController();
  final TextEditingController unitname = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Units namelist = Units();
  Units idlist = Units();
  UnitsModle invitationList = UnitsModle();
  FocusNode fone = FocusNode();
  FocusNode ftow = FocusNode();
  FocusNode fthree = FocusNode();
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  layoutForMobile(Orientation orientation) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        var size = MediaQuery.of(context).size;
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
                          
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      width: size.width,
                        height: 500,
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
                                                        FocusScope.of(
                                                                context)
                                                            .requestFocus(
                                                                fthree);
                                                      },
                                                      controller: unitname,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: IntlPhoneField(
                                        focusNode: fthree,
                                         initialCountryCode: 'AE',
                                        keyboardType: TextInputType.number,
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (phonecontroller
                                            .text.isNotEmpty) {
                                          fromUserScan();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
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
                                          fixedSize: const Size(300, 40)
                                          //minimumSize: const Size.fromHeight(60),
                                          ),
                                      child: const Text(
                                        " Submit ",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w500,fontFamily:
                                                                  'Poppins',),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),
                          ]),
                    ),
                  ],
                ),
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
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
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
                                            height: 10,
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
                                                              labelText: 'Appartment number',
                                                labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.only(left: 20),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
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
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 350,
                                            child: IntlPhoneField(
                                              focusNode: fthree,
                                             initialCountryCode: 'AE',
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: phonecontroller,
                                              decoration:  InputDecoration(
                                               labelText: "Phone Number ",
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                          helperText:
                                              'Standard call, messaging or data rates may apply.',
                                          helperStyle: TextStyle(fontSize: 10),
                                          counterText: "",
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (phonecontroller
                                                  .text.isNotEmpty) {
                                                fromUserScan();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
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
                                            height: 10,
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
                body: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.backColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                    SizedBox(
                    width: 60,
                    child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backColor
                    ),
                    ),
                  ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 60, left: 55),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 300,
                                      child: Container(
                                        child: Image.asset(AppIcons.mainlogo,
                                            fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    const Text(
                                      "Welcome",
                                     style: TextStyle(
                                        color: AppColors.buttoncolor,
                                        fontSize: 34,
                                        fontWeight: FontWeight.w700,
                                         fontFamily: 'Poppins',
                                         letterSpacing: 0.5,
                                      
                                        ),
                                    ),
                                 
                                    Text(
                                      widget.name,
                                      style: TextStyle(
                                        color: AppColors.buttoncolor,
                                        fontSize: 34,
                                        fontWeight: FontWeight.w700,
                                         fontFamily: 'Poppins',
                                         letterSpacing: 0.5,
                                      
                                        ),
                                    ),
                               
                                    const Text(
                                      "Approve User",
                                      textScaleFactor: 1.1,
                                    style: TextStyle(
                                        color: AppColors.buttoncolor,
                                        fontSize: 18,
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
                                         fontFamily: 'Poppins',
                                        color:
                                            AppColors.buttoncolor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
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
                                children: [
                               
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
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
                                                     fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 20),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                      color: Colors.green,
                                                    ),
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
                                                                  "Unit Name",
                                                             labelStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 20),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                      color: Colors.green,
                                                    ),
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
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 355,
                                            child: IntlPhoneField(
                                              focusNode: fthree,
                                             initialCountryCode: 'AE',
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: phonecontroller,
                                              decoration:  InputDecoration(
                                                  labelText: "Phone Number",
                                                counterText: "",
                                          helperText:
                                              'Standard call, messaging or data rates may apply.',
                                              helperStyle: TextStyle(
                                                fontSize: 10
                                              ),
                                                  border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                           focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:  Colors.black12
                                                )
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.black12
                                                )
                                              ),
                                                          
                                                          ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (phonecontroller
                                                  .text.isNotEmpty) {
                                                fromUserScan();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
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
                                                                    12))),
                                                elevation: 2,
                                                textStyle: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                                backgroundColor:
                                                     AppColors.backColor,
                                                fixedSize: const Size(355, 40)
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
                                            height: 10,
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

  Future<void> fromUserScan() async {
    String accesstoken = widget.accesstoken;
    String userid = widget.userid;
    String reason = reasonofEntry.text;
    String unitename = unitname.text;
    String prefixphone = phonecontroller.text;
    String phonenumber = phonecontroller.text;

    if (_formKey.currentState!.validate()) {
      dynamic res = await _apiClient.postfromuserscan(
          accesstoken, userid, unitename, reason, prefixphone, phonenumber);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sucess'),
          backgroundColor: Color.fromARGB(255, 43, 155, 5),
        ));
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MainDashboard(
                      accesstoken: accesstoken,
                      name: widget.name,
                    )),
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${res['error']}'),
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
