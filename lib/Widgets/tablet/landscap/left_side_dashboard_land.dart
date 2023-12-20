import 'package:flutter/material.dart';
import 'package:securitygate/core/app_colors.dart';
import 'package:securitygate/core/app_icons.dart';
import 'package:securitygate/pages/dashboardpages/Em/emscannig.dart';
import 'package:securitygate/pages/maindashboard.dart';

class leftsidedashboard extends StatelessWidget {
  const leftsidedashboard({
    super.key,
    required this.widget,
    required this.tdata,
  });

  final EmScanning widget;
  final String tdata;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding:
            const EdgeInsets.only(top: 60,left: 55),
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
              SizedBox(
                height: 8,
              ),
           
              const Text(
                "SCAN EMIRATES ID",
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
                  Navigator.of(context)
                      .pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  MainDashboard(
                                    accesstoken: widget
                                        .accesstoken,
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
                    backgroundColor:Color.fromARGB(240, 255, 255, 255),
                    fixedSize: const Size(200, 40)
                    //minimumSize: const Size.fromHeight(60),
                    ),
                child: const Text(
                  "Back To Dashboard",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                      color:AppColors.backColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
