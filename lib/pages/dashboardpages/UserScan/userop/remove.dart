import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:securitygate/pages/dashboardpages/invitation/aprovinitation.dart';
import 'package:securitygate/pages/maindashboard.dart';

class RemoveUserFromUnit extends StatefulWidget {
  final String accesstoken;
  final String name;

  const RemoveUserFromUnit({
    Key? key,
    required this.accesstoken,
    required this.name,
  }) : super(key: key);

  @override
  State<RemoveUserFromUnit> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RemoveUserFromUnit> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 72, 39, 239),
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
                      Image.asset('assets/images/tlogo.png'),
                    ],
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Text(
                        "Remove User From Unit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: Text(
                        tdata,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      )),
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
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            elevation: 2,
                            textStyle: const TextStyle(
                              fontSize: 15,
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            fixedSize: const Size(200, 40)
                            //minimumSize: const Size.fromHeight(60),
                            ),
                        child: const Text(
                          "Back To DashBoard",
                          style: TextStyle(
                              color: Color.fromARGB(255, 72, 39, 239),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                      children: [
                        const Text(
                          'Focuse he Camera On The QR Code ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        const Text(
                          ' From The User Phone',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: QRView(
                              key: qrKey, onQRViewCreated: _onQRViewCreated),
                        ),
                        Center(
                          child: (result != null)
                              ? Text(
                                  'Barcode Type: ${describeEnum(result!.format)}  ')
                              : const Text(''),
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
                builder: (context) => AproveInvitation(
                    name: widget.name,
                    accesstoken: widget.accesstoken,
                    visitid: result.toString())));
        controller.pauseCamera();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
