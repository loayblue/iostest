import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:securitygate/pages/dashboardpages/UserScan/userop/remove.dart';
import 'package:securitygate/pages/dashboardpages/UserScan/userop/update.dart';
import 'package:securitygate/pages/maindashboard.dart';

class UserCheckMain extends StatefulWidget {
  final String accesstoken;
  final String name;

  const UserCheckMain({
    Key? key,
    required this.accesstoken,
    required this.name,
  }) : super(key: key);

  @override
  State<UserCheckMain> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserCheckMain> {
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                            fontSize: 30,
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
                            fontSize: 26,
                            fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Text(
                        "User CHECK IN ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
                            fontSize: 16,
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
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
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
            const SizedBox(height: 5),
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
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateUserCheckIn(
                                        name: widget.name,
                                        accesstoken: widget.accesstoken,
                                        unitid: '',
                                        userid: '',
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            elevation: 20,
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor:
                                const Color.fromARGB(255, 72, 39, 239),
                            shadowColor: const Color.fromARGB(255, 9, 9, 141),
                            fixedSize: const Size(300, 45)
                            //minimumSize: const Size.fromHeight(60),
                            ),
                        child: const Text("Update User Check In"),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RemoveUserFromUnit(
                                        name: widget.name,
                                        accesstoken: widget.accesstoken,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            elevation: 20,
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor:
                                const Color.fromARGB(255, 72, 39, 239),
                            shadowColor: const Color.fromARGB(255, 9, 9, 141),
                            fixedSize: const Size(300, 45)
                            //minimumSize: const Size.fromHeight(60),
                            ),
                        child: const Text("Remove User From Unit"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
