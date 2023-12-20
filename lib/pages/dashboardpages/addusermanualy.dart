import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/pages/dashboardpages/UserScan/aproveuser.dart';
import 'package:securitygate/pages/maindashboard.dart';
import 'package:securitygate/utils/validator.dart';

import '../../core/app_icons.dart';

class AddUserManualy extends StatefulWidget {
  final String accesstoken;
  final String name;
  const AddUserManualy(
      {super.key, required this.accesstoken, required this.name});

  @override
  State<AddUserManualy> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddUserManualy> {
  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  Barcode? result;
  QRViewController? controller;
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController fisrtnamecontroller = TextEditingController();
  final TextEditingController lastnamecontroler = TextEditingController();
  final TextEditingController pcontroller = TextEditingController();

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  FocusNode fone = FocusNode();
  FocusNode ftow = FocusNode();
  FocusNode fthree = FocusNode();
  FocusNode ffour = FocusNode();

  late PhoneNumber pp = PhoneNumber(
    countryCode: '',
    countryISOCode: '',
    number: '',
  );

  layoutForMobile(Orientation orientation) {
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
                physics: const BouncingScrollPhysics(),
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
                            "ADD USER MANUALLY",
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
                              color: AppColors.buttoncolor,
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
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 500,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                        controller: emailcontroller,
                                        validator: (value) {
                                          return Validator.validateEmail(
                                              value ?? "");
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Email address",
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
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                            focusNode: ftow,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(fthree);
                                            },
                                            controller: fisrtnamecontroller,
                                            validator: (value) {
                                              return Validator.validateName(
                                                  value ?? "");
                                            },
                                            decoration: InputDecoration(
                                              labelText: "First name",
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
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                            focusNode: fthree,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(ffour);
                                            },
                                            controller: lastnamecontroler,
                                            validator: (value) {
                                              return Validator.validateName(
                                                  value ?? "");
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Last name",
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
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: IntlPhoneField(
                                      initialCountryCode: 'AE',
                                      controller: pcontroller,
                                      focusNode: ffour,
                                      onCountryChanged: (country) {
                                        pp.countryISOCode =
                                            country.fullCountryCode;
                                      },
                                     // languageCode: "en",
                                      onChanged: (phone) {
                                        pp.countryCode = phone.countryCode;
                                        pp.countryISOCode =
                                            phone.countryISOCode;
                                        pp.countryCode = phone.number;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                       // contentPadding: EdgeInsets.all(1),
                                        labelText: "Phone Number",
                                        labelStyle: TextStyle(fontSize: 12),
                                        helperText:
                                            'Standard call, messaging or data rates may apply.',
                                        helperStyle: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Poppins',
                                        ),
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate() &&
                                          pcontroller.text.isNotEmpty) {
                                     
                                            pp.completeNumber.toString();
                                     
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AproveUser(
                                                    accesstoken:
                                                        widget.accesstoken,
                                                    name: widget.name,
                                                    email: emailcontroller.text,
                                                    firstname:
                                                        fisrtnamecontroller
                                                            .text,
                                                    lastname:
                                                        lastnamecontroler.text,
                                                    phone: PhoneNumber(
                                                        countryISOCode:
                                                            pp.countryCode,
                                                        countryCode:
                                                            pp.countryISOCode,
                                                        number: pp
                                                            .completeNumber))));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text(
                                              'Please Check Your Information '),
                                          backgroundColor: Colors.red.shade300,
                                        ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        elevation: 2,
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        backgroundColor: AppColors.backColor,
                                        fixedSize: const Size(300, 4)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text(
                                      "Add User",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w500,fontFamily: 'Poppins',),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  )
                                ],
                              )),
                        ],
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
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                              "ADD USER MANUALLY",
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
                                      color: AppColors.backColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    SizedBox(
                                      width: 360,
                                      child: TextFormField(
                                          focusNode: fone,
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(context)
                                                .requestFocus(ftow);
                                          },
                                          controller: emailcontroller,
                                          validator: (value) {
                                            return Validator.validateEmail(
                                                value ?? "");
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Email address',
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
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                              focusNode: ftow,
                                              onFieldSubmitted: (value) {
                                                FocusScope.of(context)
                                                    .requestFocus(fthree);
                                              },
                                              controller: fisrtnamecontroller,
                                              validator: (value) {
                                                return Validator.validateName(
                                                    value ?? "");
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'First Name',
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
                                                            15),
                                                    borderSide: BorderSide(
                                                        width:
                                                            double.infinity)),
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
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                              focusNode: fthree,
                                              onFieldSubmitted: (value) {
                                                FocusScope.of(context)
                                                    .requestFocus(ffour);
                                              },
                                              controller: lastnamecontroler,
                                              validator: (value) {
                                                return Validator.validateName(
                                                    value ?? "");
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Last Name',
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
                                                            15),
                                                    borderSide: BorderSide(
                                                        width:
                                                            double.infinity)),
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 360,
                                      child: IntlPhoneField(
                                        initialCountryCode: 'AE',
                                        controller: pcontroller,
                                        focusNode: ffour,
                                        onCountryChanged: (country) {
                                          pp.countryISOCode =
                                              country.fullCountryCode;
                                        },
                                        languageCode: "en",
                                        onChanged: (phone) {
                                          pp.countryCode = phone.countryCode;
                                          pp.countryISOCode =
                                              phone.countryISOCode;
                                          pp.countryCode = phone.number;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: "Phone Number ",
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                            helperText:
                                                'Standard call, messaging or data rates may apply.',
                                            helperStyle:
                                                TextStyle(fontSize: 10),
                                            counterText: "",
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black12)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                borderSide: BorderSide(
                                                    color: Colors.black12))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate() &&
                                            pcontroller.text.isNotEmpty) {
                                          pp.completeNumber.toString();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AproveUser(
                                                      accesstoken:
                                                          widget.accesstoken,
                                                      name: widget.name,
                                                      email:
                                                          emailcontroller.text,
                                                      firstname:
                                                          fisrtnamecontroller
                                                              .text,
                                                      lastname:
                                                          lastnamecontroler
                                                              .text,
                                                      phone: PhoneNumber(
                                                          countryISOCode:
                                                              pp.countryCode,
                                                          countryCode:
                                                              pp.countryISOCode,
                                                          number: pp
                                                              .completeNumber))));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                'Please Check Your Information '),
                                            backgroundColor:
                                                Colors.red.shade300,
                                          ));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12))),
                                          elevation: 2,
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                          ),
                                          backgroundColor: AppColors.backColor,
                                          fixedSize: const Size(360, 40)
                                          //minimumSize: const Size.fromHeight(60),
                                          ),
                                      child: const Text(
                                        "Add User",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    )
                                  ],
                                )),
                          ],
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
              physics: const BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.backColor),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 55),
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
                                textAlign: TextAlign.start,
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
                                textAlign: TextAlign.start,
                                widget.name,
                                style: TextStyle(
                                  color: AppColors.buttoncolor,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Add User Manually",
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
                                  color: AppColors.buttoncolor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
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
                                        240, 255, 255, 255),
                                    fixedSize: const Size(200, 40)
                                    //minimumSize: const Size.fromHeight(60),
                                    ),
                                child: const Text(
                                  "Back To Dashboard",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: AppColors.backColor,
                                      fontWeight: FontWeight.w400),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 325,
                                    child: TextFormField(
                                        focusNode: fone,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(ftow);
                                        },
                                        controller: emailcontroller,
                                        validator: (value) {
                                          return Validator.validateEmail(
                                              value ?? "");
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Email address',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: Colors.grey),
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.green,
                                            ),
                                          ),
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 160,
                                        child: TextFormField(
                                            focusNode: ftow,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(fthree);
                                            },
                                            controller: fisrtnamecontroller,
                                            validator: (value) {
                                              return Validator.validateName(
                                                  value ?? "");
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'First Name',
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
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
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child: TextFormField(
                                            focusNode: fthree,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(ffour);
                                            },
                                            controller: lastnamecontroler,
                                            validator: (value) {
                                              return Validator.validateName(
                                                  value ?? "");
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
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
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 330,
                                    child: IntlPhoneField(
                                       initialCountryCode: 'AE',
                                      controller: pcontroller,
                                      focusNode: ffour,
                                      onCountryChanged: (country) {
                                        pp.countryISOCode =
                                            country.fullCountryCode;
                                      },
                                      languageCode: "en",
                                      onChanged: (phone) {
                                        pp.countryCode = phone.countryCode;
                                        pp.countryISOCode =
                                            phone.countryISOCode;
                                        pp.number = phone.number;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(20),
                                        labelText: "Phone Number",
                                        labelStyle: TextStyle(fontSize: 12),
                                        helperText:
                                            'Standard call, messaging or data rates may apply.',
                                        helperStyle: TextStyle(fontSize: 10),
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate() &&
                                          pcontroller.text.isNotEmpty) {
                                        String fff = pp.countryCode;
                                        String eee =
                                            pp.completeNumber.toString();
                                        debugPrint('loay : $fff');
                                        debugPrint('contrycooooood : $eee');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AproveUser(
                                                    accesstoken:
                                                        widget.accesstoken,
                                                    name: widget.name,
                                                    email: emailcontroller.text,
                                                    firstname:
                                                        fisrtnamecontroller
                                                            .text,
                                                    lastname:
                                                        lastnamecontroler.text,
                                                    phone: PhoneNumber(
                                                        countryISOCode:
                                                            pp.countryCode,
                                                        countryCode:
                                                            pp.countryISOCode,
                                                        number: pp
                                                            .completeNumber))));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text(
                                              'Please Check Your Information '),
                                          backgroundColor: Colors.red.shade300,
                                        ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        elevation: 2,
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        backgroundColor: AppColors.backColor,
                                        fixedSize: const Size(325, 35)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text(
                                      "Add User",
                                      style: TextStyle(
                                          color: AppColors.buttoncolor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
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
