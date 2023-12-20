import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/core/app_icons.dart';
import 'package:securitygate/pages/dashboardpages/UserScan/aproveuserscan.dart';
import 'package:securitygate/pages/maindashboard.dart';

class ScanFromUserPhone extends StatefulWidget {
  final String accesstoken;
  final String name;

  const ScanFromUserPhone({
    Key? key,
    required this.accesstoken,
    required this.name,
  }) : super(key: key);

  @override
  State<ScanFromUserPhone> createState() => _MyWidgetState();
}

late StreamSubscription subscription;
bool isDeviceConnected = false;
bool isAlertSet = false;

class _MyWidgetState extends State<ScanFromUserPhone> {
  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());

  layoutForMobile(Orientation orientation) {
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
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.backColor,
              body: Column(
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
                          "SCAN FROM USER PHONE",
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Focuse The Camera On The QR Code ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins',),
                              ),
                              const Text(
                                'From The User Phone',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins',),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 300,
                                width: 300,
                                child: QRView(
                                    key: qrKey,
                                    onQRViewCreated: _onQRViewCreated),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                body: Column(
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
                            "SCAN FROM USER PHONE",
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
                                      fontWeight: FontWeight.w500, fontFamily: 'Poppins',),
                                ),
                              ),
                            ],
                          ),
                             const SizedBox(height: 20),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Focuse he Camera On The QR Code From ',
                                  style: TextStyle(
                                      fontSize: 20,
                                       fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'The User Phone',
                                  style: TextStyle(
                                      fontSize: 20,
                                       fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 400,
                                  width: 500,
                                  child: QRView(
                                      key: qrKey,
                                      onQRViewCreated: _onQRViewCreated),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                body: Row(
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
                                      child:  Image.asset(AppIcons.mainlogo,fit: BoxFit.fitWidth),
                                    ) ,
                                  ),
                                    const SizedBox(
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
                                    SizedBox(height: 8,),
                                const Text(
                                  "SCAN FROM USERS PHONE",
                                        
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
                                 Text( textAlign: TextAlign.start,
                                   'Time: $tdata',
                                     style: const TextStyle(
                                       color:AppColors.buttoncolor,
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
                                                  accesstoken:
                                                      widget.accesstoken,
                                                  name: widget.name,
                                                )),
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
                                      backgroundColor: AppColors.buttoncolor,
                                      fixedSize: const Size(200, 40)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                      
                                  child: const Text(
                                    "Back To Dashboard",
                                    style: TextStyle(
                                    fontFamily: 'Poppins',
                                        color: AppColors.backColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
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
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Focuse The Camera On The QR CODE FROM',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                        
                                const Text(
                                  'THE Users Phone',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 300,
                                  width: 500,
                                  child: QRView(
                                      key: qrKey,
                                      onQRViewCreated: _onQRViewCreated),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.pauseCamera();
      });
      if (result?.code != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AprovescanUser(
                    name: widget.name,
                    accesstoken: widget.accesstoken,
                    userid: result!.code.toString())));
        controller.pauseCamera();
      }
    });
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Scanning Successful'),
            content: TextButton(
              child: const Text('Procced'),
              onPressed: () {},
            ),
          ));
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
