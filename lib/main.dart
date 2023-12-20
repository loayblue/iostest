import 'package:flutter/material.dart';

import 'package:securitygate/login_screen.dart';
import 'package:securitygate/pages/maindashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  SharedPreferences preferencesname = await SharedPreferences.getInstance();
  var token = preferences.getString("accessToken");
  var nametoken = preferencesname.getString("email");
 
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      home: token == null
          ? const MyApp()
          : MainDashboard(
              accesstoken: token,
              name: nametoken.toString(),
            )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Security App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins'
      ),
      home: const LoginScreen(),
    );
  }
}
