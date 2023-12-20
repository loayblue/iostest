import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:securitygate/Widgets/tablet/landscap/left_side_tablet_land.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/core/app_icons.dart';
import 'package:securitygate/login_screen.dart';
import 'package:securitygate/pages/dashboardpages/Em/emscannig.dart';
import 'package:securitygate/pages/dashboardpages/UserScan/newusercheck.dart';
import 'package:securitygate/pages/dashboardpages/UserScan/scanfromuserphone.dart';
import 'package:securitygate/pages/dashboardpages/addusermanualy.dart';
import 'package:securitygate/pages/dashboardpages/invitation/scanfrominvation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboard extends StatefulWidget {
  final String accesstoken;

  final String name;
  const MainDashboard({Key? key, required this.accesstoken, required this.name})
      : super(key: key);

  @override
  State<MainDashboard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainDashboard> {
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());

  layoutForMobile(Orientation orientation) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context) ,
      child: LayoutBuilder(
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
                              "DASHBOARD",
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
                                  onPressed: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.clear();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen()),
                                        (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      elevation: 2,
                                      textStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fixedSize: const Size(140, 30)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(
                                        color: AppColors.backColor,
                                        fontWeight: FontWeight.w600,   fontFamily: 'Poppins',),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
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
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EmScanning(
                                                name: widget.name,
                                                accesstoken: widget.accesstoken,
                                                context: context)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 10,
                                      textStyle: const TextStyle(fontSize: 14, fontFamily: 'Poppins',),
                                      backgroundColor:
                                          AppColors.backColor,
                                     
                                      fixedSize: const Size(300, 40)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text("SCAN EMITRATES ID"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScanFromUserPhone(
                                                  name: widget.name,
                                                  accesstoken: widget.accesstoken,
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 10,
                                      textStyle: const TextStyle(fontSize: 14, fontFamily: 'Poppins',),
                                      backgroundColor:
                                         AppColors.backColor,
                                      
                                      fixedSize: const Size(300, 40)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text("SCAN FROM USERS PHONE"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ScanInvatition(
                                                  name: widget.name,
                                                  accesstoken: widget.accesstoken,
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 10,
                                      textStyle: const TextStyle(fontSize: 14, fontFamily: 'Poppins',),
                                      backgroundColor:
                                        AppColors.backColor,
                                    
                                      fixedSize: const Size(300, 40)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text("SCAN INVITATION CODE"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddUserManualy(
                                                accesstoken: widget.accesstoken,
                                                name: widget.name)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 10,
                                      textStyle: const TextStyle(fontSize: 14, fontFamily: 'Poppins',),
                                      backgroundColor:
                                    AppColors.backColor,
                                   
                                      fixedSize: const Size(300, 40)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text("ADD USER MANUALLY"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NewUserCheckIn(
                                                  name: widget.name,
                                                  accesstoken: widget.accesstoken,
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 10,
                                      textStyle: const TextStyle(fontSize: 14, fontFamily: 'Poppins',),
                                      backgroundColor:
                                      AppColors.backColor,
                                    
                                      fixedSize: const Size(300, 40)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text("NEW USER CHECK IN "),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 10,
                                      textStyle: const TextStyle(fontSize: 14, fontFamily: 'Poppins',),
                                      backgroundColor:
                                       AppColors.backColor,
                                    
                                      fixedSize: const Size(300, 40)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text("SERVICE CHECK IN "),
                                )
                              ],
                            ),
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
      ),
    );
  }

  layoutForTablet(Orientation orientation) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    var size = MediaQuery.of(context).size;
    if (orientation == Orientation.portrait) {
      return WillPopScope(
         onWillPop: () => _onBackButtonPressed(context) ,
        child: LayoutBuilder(
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
                                height: 15,
                              ),
                              const Text(
                                "DASHBOARD",
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
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.clear();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                          (route) => false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        elevation: 2,
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fixedSize: const Size(140, 40)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: AppColors.backColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
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
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EmScanning(
                                                  name: widget.name,
                                                  accesstoken: widget.accesstoken,
                                                  context: context)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        elevation: 5,
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                        backgroundColor: AppColors.backColor,
                                        fixedSize: const Size(400, 45)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text("SCAN EMITRATES ID"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScanFromUserPhone(
                                                    name: widget.name,
                                                    accesstoken:
                                                        widget.accesstoken,
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        elevation: 5,
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                        backgroundColor: AppColors.backColor,
                                        fixedSize: const Size(400, 45)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text("SCAN FROM USERS PHONE"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScanInvatition(
                                                    name: widget.name,
                                                    accesstoken:
                                                        widget.accesstoken,
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        elevation: 5,
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                        backgroundColor: AppColors.backColor,
                                        fixedSize: const Size(400, 45)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text("SCAN INVITATION CODE"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddUserManualy(
                                                      accesstoken:
                                                          widget.accesstoken,
                                                      name: widget.name)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        elevation: 5,
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                        ),
                                        backgroundColor: AppColors.backColor,
                                        fixedSize: const Size(400, 45)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text("ADD USER MANUALLY"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewUserCheckIn(
                                                    name: widget.name,
                                                    accesstoken:
                                                        widget.accesstoken,
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        elevation: 5,
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                        backgroundColor: AppColors.backColor,
                                        fixedSize: const Size(400, 45)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text("NEW USER CHECK IN "),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        elevation: 5,
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                        backgroundColor: AppColors.backColor,
                                        fixedSize: const Size(400, 45)
                                        //minimumSize: const Size.fromHeight(60),
                                        ),
                                    child: const Text("SERVICE CHECK IN "),
                                  )
                                ],
                              ),
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
        ),
      );
    } else {
      return WillPopScope(
         onWillPop: () => _onBackButtonPressed(context) ,
        child: LayoutBuilder(
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
                      color: Color.fromRGBO(65, 78, 227, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          child: Container(
                            decoration: BoxDecoration(color: AppColors.backColor),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: leftsidelandscap(widget: widget, tdata: tdata),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: size.width,
                            height: size.height,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomLeft: Radius.circular(25))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EmScanning(
                                                name: widget.name,
                                                accesstoken: widget.accesstoken,
                                                context: context)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 5,
                                      textStyle: const TextStyle(fontSize: 12),
                                      backgroundColor: AppColors.backColor,
                                      fixedSize: const Size(320, 30)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "SCAN EMITRATES ID",
                                    style: TextStyle(
                                        color: AppColors.buttoncolor,
                                        fontSize: 12,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScanFromUserPhone(
                                                  name: widget.name,
                                                  accesstoken: widget.accesstoken,
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 5,
                                      textStyle: const TextStyle(fontSize: 12),
                                      backgroundColor: AppColors.backColor,
                                      fixedSize: const Size(320, 30)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "SCAN FROM USERS PHONE",
                                    style: TextStyle(
                                      color: AppColors.buttoncolor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ScanInvatition(
                                                  name: widget.name,
                                                  accesstoken: widget.accesstoken,
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 5,
                                      textStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      backgroundColor: AppColors.backColor,
                                      fixedSize: const Size(320, 30)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "SCAN INVITATION CODE",
                                    style: TextStyle(
                                        color: AppColors.buttoncolor,
                                        fontSize: 12,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddUserManualy(
                                                accesstoken: widget.accesstoken,
                                                name: widget.name)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 5,
                                      textStyle: const TextStyle(fontSize: 12),
                                      backgroundColor: AppColors.backColor,
                                      fixedSize: const Size(320, 30)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "ADD USER MANUALLY",
                                    style: TextStyle(
                                        color: AppColors.buttoncolor,
                                        fontSize: 12,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NewUserCheckIn(
                                                  name: widget.name,
                                                  accesstoken: widget.accesstoken,
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 5,
                                      textStyle: const TextStyle(fontSize: 12),
                                      backgroundColor: AppColors.backColor,
                                      fixedSize: const Size(320, 30)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "NEW USER CHECK IN ",
                                    style: TextStyle(
                                        color: AppColors.buttoncolor,
                                        fontSize: 12,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      elevation: 5,
                                      textStyle: const TextStyle(fontSize: 12),
                                      backgroundColor: AppColors.backColor,
                                      fixedSize: const Size(320, 30)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "SERVICE CHECK IN ",
                                    style: TextStyle(
                                        color: AppColors.buttoncolor,
                                        fontSize: 12,
                                        fontFamily: 'Poppins'),
                                  ),
                                )
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
          },
        ),
      );
    }
  }

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

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



      Future<bool> _onBackButtonPressed  (BuildContext context) async {
        bool? exitApp = await showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text("Exit The Application"),
              content: Text("Do You Want To Close The App "),
              actions: <Widget>[
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(false); 
                  },
                   child: Text("No")),
                   TextButton(onPressed: () {
                     Navigator.of(context).pop(true);
                   },
                    child: Text("yes"))
              ],
            );
          },);
          return exitApp ?? false;
      }
}
