import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:securitygate/core/api_client.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/core/app_icons.dart';
import 'package:securitygate/pages/maindashboard.dart';
import 'package:securitygate/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  layoutForMobile(Orientation orientation) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.backColor,
              body: SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Welcome To The Metagate',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Security Mobile App',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Metanest Product',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 216, 211, 211),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Form(
                              key: _formKey,
                              child: SizedBox(
                                width: size.width * 0.85,
                                height: size.height * 0.65,
                                child: Container(
                                  width: size.width * 0.85,
                                  height: size.height * 0.70,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 60,
                                            width: 160,
                                            child: Container(
                                              child: Image.asset(
                                                  AppIcons.loginlogo,
                                                  fit: BoxFit.fitWidth),
                                            ),
                                          ),
                                       
                                          Padding(
                                            padding: const EdgeInsets.only(left :8.0),
                                            child: Text(
                                              "Sign in ",
                                              style: TextStyle(
                                                fontSize: 26,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                      
                                          SizedBox(
                                              height: size.height * 0.05),
                                          TextFormField(
                                            focusNode: fone,
                                            controller: emailController,
                                            validator: (value) {
                                              return Validator
                                                  .validateEmail(
                                                      value ?? "");
                                            },
                                            decoration: InputDecoration(
                                            labelText: "Email address",
                                            labelStyle:
                                                TextStyle(fontSize: 12),
                                        
                                            hintStyle: const TextStyle(
                                                fontSize: 12),
                                            isDense: true,
                                            border: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                            ),
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(ftow);
                                            },
                                          ),
                                  SizedBox(height: 10,),
                                          TextFormField(
                                            focusNode: ftow,
                                            obscureText: _showPassword,
                                            onEditingComplete: () {
                                             login();
                                           },
                                            controller: passwordController,
                                            validator: (value) {
                                              return Validator
                                                  .validatePassword(
                                                      value ?? "");
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Password",
                                            labelStyle:
                                                TextStyle(fontSize: 12),
                                            alignLabelWithHint: false,
                                            hintStyle: const TextStyle(
                                                fontSize: 12),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() =>
                                                    _showPassword =
                                                        !_showPassword);
                                              },
                                              child: Icon(
                                                _showPassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.grey,
                                                size: 14,
                                              ),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                            ),
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(fthree);
                                            },
                                          ),
                                          SizedBox(
                                              height: size.height * 0.03),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                focusNode: fthree,
                                                onPressed: login,
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.backColor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8)),
                                                    padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                                40,
                                                            vertical: 8)),
                                                child: const Text(
                                                  "Sign in",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                     fontFamily: 'Poppins',
                                                    fontWeight:
                                                        FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
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

  layoutForTablet(Orientation orientation) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
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
              body: SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Wlecome To The Metagate',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Security Mobile App',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Metanest Product',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Form(
                              key: _formKey,
                              child: Stack(children: [
                                SizedBox(
                                  width: size.width * 0.85,
                                  height: size.height * 0.65,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: size.width * 0.85,
                                      height: size.height * 0.70,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 100),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 100,
                                                        width: 300,
                                                        child: Container(
                                                          child: Image.asset(
                                                              AppIcons
                                                                  .loginlogo,
                                                              fit: BoxFit
                                                                  .fitWidth),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              // SizedBox(height: size.height * 0.08),
                                              Text(
                                                "Sign in ",
                                                style: TextStyle(
                                                  fontSize: 40,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),

                                              SizedBox(
                                                  height: size.height * 0.09),
                                              TextFormField(
                                                focusNode: fone,
                                                controller: emailController,
                                                validator: (value) {
                                                  return Validator
                                                      .validateEmail(
                                                          value ?? "");
                                                },
                                                decoration: InputDecoration(
                                                  labelText: "Email address",
                                                  labelStyle:
                                                      TextStyle(fontSize: 12),
                                                  alignLabelWithHint: true,
                                                  hintStyle: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                  isDense: true,
                                                  border: UnderlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                ),
                                                onFieldSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .requestFocus(ftow);
                                                },
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.02),
                                              TextFormField(
                                                focusNode: ftow,
                                                obscureText: _showPassword,
                                                onEditingComplete: () {
                                             login();
                                           },
                                                controller: passwordController,
                                                validator: (value) {
                                                  return Validator
                                                      .validatePassword(
                                                          value ?? "");
                                                },
                                                decoration: InputDecoration(
                                                  labelText: "Password",
                                                  labelStyle:
                                                      TextStyle(fontSize: 12),
                                                  alignLabelWithHint: true,
                                                  
                                                  hintStyle: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      setState(() =>
                                                          _showPassword =
                                                              !_showPassword);
                                                    },
                                                    child: Icon(
                                                      _showPassword
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.grey,
                                                      size: 18,
                                                    ),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                ),
                                                onFieldSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .requestFocus(fthree);
                                                },
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.04),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    focusNode: fthree,
                                                    onPressed: login,
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            AppColors.backColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 60,
                                                                vertical: 15)),
                                                    child: const Text(
                                                      "Sign in ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
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
                backgroundColor: Color.fromARGB(255, 61, 76, 238),
                body: Container(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 20),
                            child: Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 100),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 100,
                                            width: 300,
                                            child: Container(
                                              child: Image.asset(
                                                  AppIcons.loginlogo,
                                                  fit: BoxFit.fitWidth),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "Sign in ",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          208, 0, 0, 0)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          SizedBox(height: size.height * 0.05),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: TextFormField(
                                              focusNode: fone,
                                              controller: emailController,
                                              validator: (value) {
                                                return Validator.validateEmail(
                                                    value ?? "");
                                              },
                                              decoration: InputDecoration(
                                                labelText: "Email address",
                                                labelStyle:
                                                    TextStyle(fontSize: 12),
                                                alignLabelWithHint: true,
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
                                                isDense: true,
                                                border: UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                              ),
                                              onFieldSubmitted: (value) {
                                                FocusScope.of(context)
                                                    .requestFocus(ftow);
                                              },
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.03),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: TextFormField(
                                              focusNode: ftow,
                                             textInputAction: TextInputAction.go,
                                           onEditingComplete: () {
                                             login();
                                           },
                                              obscureText: _showPassword,
                                              controller: passwordController,
                                              validator: (value) {
                                                return Validator
                                                    .validatePassword(
                                                        value ?? "");
                                              },
                                              decoration: InputDecoration(

                                                labelText: "Password",
                                                labelStyle:
                                                    TextStyle(fontSize: 12),
                                                alignLabelWithHint: true,
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    setState(() =>
                                                        _showPassword =
                                                            !_showPassword);
                                                  },
                                                  child: Icon(
                                                    _showPassword
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Colors.grey,
                                                    size: 14,
                                                  ),
                                                ),
                                                border: UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                              ),
                                              onFieldSubmitted: (value) {
                                                FocusScope.of(context)
                                                    .requestFocus(fthree);
                                              },
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.02),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                focusNode: fthree,
                                                onPressed: login,
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.backColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 50,
                                                        vertical: 10)),
                                                child: const Text(
                                                  "Sign In",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .buttoncolor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 60,
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            height: size.height,
                            width: size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/images/login.png'),
                              fit: BoxFit.fill,
                              opacity: 2,
                            )),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
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

  bool isDeviceConnected = false;
  bool isAlertSet = false;
  FocusNode fone = FocusNode();
  FocusNode ftow = FocusNode();
  FocusNode fthree = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool _showPassword = true;
  late StreamSubscription subscription;

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

  Future<void> login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    SharedPreferences preferencesname = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('   Processing your login information   '),
        backgroundColor: Color.fromARGB(255, 3, 114, 20),
      ));
      dynamic res = await _apiClient.login(
        emailController.text,
        passwordController.text,
      );
      if (res['statusCode'] == 200) {
        String name = res['data']['security']['email'];
        String accessToken = res['data']['token'];
        preferences.setString("accessToken", accessToken);
        preferencesname.setString("email", name);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainDashboard(name: name, accesstoken: accessToken)));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
      if (res['statusCode'] == 401) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${res['error']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
      if (res['statusCode'] == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${res['error']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please Fill Your Info'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    //  final double shortestSide = MediaQuery.of(context).size.shortestSide;
    // final bool useMobileLayout = shortestSide < 600.0;
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
