
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:securitygate/core/api_client.dart';
import 'package:securitygate/pages/maindashboard.dart';
import 'package:securitygate/utils/validator.dart';

class AproveInvitation extends StatefulWidget {
  final String accesstoken;
  final String visitid;
  final String name;

  const AproveInvitation({
    Key? key,
    required this.accesstoken,
    required this.visitid,
    required this.name,
  }) : super(key: key);

  @override
  State<AproveInvitation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AproveInvitation> {
  var loading = false;
  bool isDataLoaded = false;
  final ApiClient _apiClient = ApiClient();
  final TextEditingController reasonofEntry = TextEditingController();
  final TextEditingController unitnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode fone = FocusNode();
  FocusNode ftow = FocusNode();
  FocusNode fthree = FocusNode();

  Future<void> fromInvitationCode() async {
    String accesstoken = widget.accesstoken;
    String visitid = widget.visitid;

    if (_formKey.currentState!.validate()) {
      dynamic res = await _apiClient.postFromInvitation(accesstoken, visitid);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res['status'] == true) {
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

        // ignore: use_build_context_synchronously
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['Message']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 72, 39, 239),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 72, 39, 239),
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
                        "Approve User ",
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
                ],
              ),
            ),
            const SizedBox(height: 5),
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
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
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
                                        hintText: "Reason of Entry",
                                        fillColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.1),
                                        filled: true,
                                        prefixIcon:
                                            const Icon(Icons.email_outlined),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: BorderSide.none),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                          focusNode: ftow,
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(context)
                                                .requestFocus(fthree);
                                          },
                                          controller: unitnamecontroller,
                                          validator: (value) {
                                            return Validator.validatePassword(
                                                value ?? "");
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Unit Name",
                                            fillColor: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.1),
                                            filled: true,
                                            prefixIcon: const Icon(Icons.home),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                borderSide: BorderSide.none),
                                          )),
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
                                    focusNode: fthree,
                                    controller: phonecontroller,
                                    decoration: const InputDecoration(
                                        labelText: "Phone Number",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide())),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (phonecontroller.text.isNotEmpty) {
                                      fromInvitationCode();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text('Please Enter PhoneNumber'),
                                        backgroundColor: Colors.red.shade300,
                                      ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const BeveledRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3))),
                                      elevation: 2,
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 72, 39, 239),
                                      fixedSize: const Size(300, 60)
                                      //minimumSize: const Size.fromHeight(60),
                                      ),
                                  child: const Text(
                                    "Add User",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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
    );
  }
}
