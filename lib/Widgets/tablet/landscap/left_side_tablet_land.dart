
import 'package:flutter/material.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/core/app_icons.dart';
import 'package:securitygate/login_screen.dart';
import 'package:securitygate/pages/maindashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class leftsidelandscap extends StatelessWidget {
  const leftsidelandscap({
    super.key,
    required this.widget,
    required this.tdata,
  });

  final MainDashboard widget;
  final String tdata;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60,left: 55),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(
                height: 100,
                width: 300,
                child: Container(
                  child:  Image.asset(AppIcons.mainlogo,fit: BoxFit.fitWidth),
                ) ,
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
         
              Text( textAlign: TextAlign.start,
          
                widget.name,
                style: TextStyle(             
                    color: AppColors.buttoncolor,
                    fontSize: 34,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700,  
                    fontFamily: 'Poppins',                            
                    ),
              ),
          const SizedBox(
                height: 8,
              ),
              const Text( textAlign: TextAlign.start,
                "DASHBOARD",
                textScaleFactor: 1.1,
                style: TextStyle(
                    color: AppColors.buttoncolor,
                    fontSize: 16,
                  //  letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
              
                    
                    ),
              ),
               const SizedBox(
                height: 8,
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
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences
                          .getInstance();
                  pref.clear();
                  Navigator.of(context)
                      .pushAndRemoveUntil(
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
                      fontSize: 12,
                    ),
                    backgroundColor:Colors.white,
                    fixedSize: const Size(135, 40)
                    //minimumSize: const Size.fromHeight(60),
                    ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      color: AppColors.backColor,
                       fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}