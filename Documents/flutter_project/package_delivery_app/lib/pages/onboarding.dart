import 'package:flutter/material.dart';
import 'package:package_delivery_app/service/widget_support.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
      child: Column(children: [
      Image.asset("images/onboard.png"),
      SizedBox(height: 50.0,),
      Text("Track your parcel \n from anywhere",
      textAlign: TextAlign.center,
       style: AppWidget.headlineTextfieldStyle(30.0),),
       SizedBox(height: 30.0,),
       Text("Check the progress of \n your deliveries",
       textAlign: TextAlign.center,
        style: AppWidget.simpleTextfieldStyle(),),
        SizedBox(height: 30.0,),
        Material(
          elevation: 3.0,
             borderRadius: BorderRadius.circular(40),
          child: Container(
            width: MediaQuery.of(context).size.width/1.7,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xfff8ae39),
              borderRadius: BorderRadius.circular(40)
            ),
            child: Center(child: Text("Track Now", style: AppWidget.whiteTextfieldStyle(),)),
          ),
        )
      ],),),
    );
  }
}
