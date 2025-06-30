import 'package:flutter/material.dart';
import 'package:package_delivery_app/service/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xff6053f8),
                            size: 30.0,
                          ),
                          Text(
                            "Current Location",
                            style: AppWidget.simpleTextfieldStyle(),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        "City Avenue, Nairobi",
                        style: AppWidget.headlineTextfieldStyle(18.0),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height / 2.2,
                decoration: BoxDecoration(
                  color: Color(0xff6053f8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      "Track your Shipment",
                      style: AppWidget.whiteTextfieldStyle(),
                    ),
                    Text(
                      "Please enter your tracking number",
                      style: AppWidget.differentshadeWhiteTextfieldStyle(),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter track Number",
                          hintStyle: AppWidget.headlineTextfieldStyle(15.0),
                          prefixIcon: Icon(Icons.track_changes),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ),
                    Spacer(),
                    Image.asset('images/home.png', height: 200),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/fast-delivery.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Text(
                              "Order a delivery",
                              style: AppWidget.headlineTextfieldStyle(18.0),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Text(
                                "We will pick it up and deliver it across town quickly and securely",
                                textAlign: TextAlign.center,
                                style: AppWidget.slowSimpleTextfieldStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/parcel.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Text(
                              "Track a delivery",
                              style: AppWidget.headlineTextfieldStyle(18.0),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Text(
                                "Track your delivery in real time from pickup to dropoff",
                                textAlign: TextAlign.center,
                                style: AppWidget.slowSimpleTextfieldStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/delivery-bike.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Text(
                              "Check delivery history",
                              style: AppWidget.headlineTextfieldStyle(18.0),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Text(
                                "Check delivery history",
                                textAlign: TextAlign.center,
                                style: AppWidget.slowSimpleTextfieldStyle(),
                              ),
                            ),
                             
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                ),
              ),
             SizedBox(height: 30.0), 
            ],
          ),
        ),
      ),
    );
  }
}
