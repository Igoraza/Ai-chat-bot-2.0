import 'package:aichatbot/main.dart';
import 'package:aichatbot/screen/splash/splash.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:type_text/type_text.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int Stage = 0;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff040A14),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: SizedBox(
                  width: 150,
                  height: 170,
                  child: FadeInUp(
                    from: 50,
                    child: Image.asset(
                      "asset/image/sbot.png",
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            TypeText("Hi, ....!", duration: Duration(seconds: 1),
                onType: ((progress) {
              if (progress == 1) {
                Stage = 1;

                setState(() {});
              }
            }),
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: "Satoshi")),
            SizedBox(
              height: 20,
            ),
            if (Stage > 0)
              TypeText("Oh No! ", duration: Duration(seconds: 1),
                  onType: ((progress) {
                if (progress == 1) {
                  Stage = 2;

                  setState(() {});
                }
              }),
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: "Satoshi")),
            if (Stage > 1)
              TypeText("What should I call you ?",
                  duration: Duration(seconds: 1), onType: ((progress) {
                if (progress == 1) {
                  Stage = 3;

                  setState(() {});
                }
              }),
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "Satoshi")),
            SizedBox(
              height: 20,
            ),
            if (Stage > 2)
              FadeInRight(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(.07)),
                  child: TextField(
                    controller: textController,
                    textAlign: TextAlign.center,
                    onSubmitted: (value) async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setString("NAME", value);
                      Name = value;
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (Context) => Splash()));
                    },
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: "Satoshi"),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(.4),
                          fontFamily: "Satoshi"),
                      hintText: "Type your Name",
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    ));
  }
}
