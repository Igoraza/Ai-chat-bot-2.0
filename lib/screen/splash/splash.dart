import 'dart:convert';
import 'dart:developer';

import 'package:aichatbot/Constant/EndPoints.dart';
import 'package:aichatbot/main.dart';
import 'package:aichatbot/screen/OnBoardingScreen.dart';
import 'package:aichatbot/screen/home/Model/CategoryModel.dart';
import 'package:aichatbot/screen/home/home.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CategoryModel> CategoryList = [];

class Splash extends StatelessWidget {
  const Splash({super.key});

  loadCategory(BuildContext context) async {
    print("Loading");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("TOKEN").toString();

    final Response = await get(
        Uri.parse(
          endpoint + "chat/categories",
        ),
        headers: {"Authorization": "Bearer $token"});
    print(Response.body);
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      for (var data in js["categories"]) {
        CategoryList.add(CategoryModel.fromJson(data));
      }
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      pref.setString("TOKEN", "null");
      loadNext(context);
    }
  }

  loadNext(BuildContext context) async {
    try {
      print("Loading Start");
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("TOKEN").toString();
      if (token == "null") {
        final Response = await get(Uri.parse(endpoint + "session/create"), headers: {"Authorization": "Bearer W38LdkiXVrykGMriQagCuoRjvHcXEEJG"});
        var js = json.decode(Response.body);
        // print(Response.body);
        log(Response.body);

        if (Response.statusCode == 200) {
          token = js["sessionId"];
          pref.setString("TOKEN", token);
          

          loadCategory(context);
        }
      } else
        loadCategory(context);
    } catch (e) {
      print("Error in session creation :$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // loadNext();
    Future.delayed(Duration(seconds: 1), () {
      if (Name != "null") {
        print("netx");
        loadNext(context);
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnBoardingScreen()));
      }
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "asset/image/Splash.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(top: 100, bottom: 100, left: 100, right: 100, child: FadeOut(child: Image.asset("asset/image/logo.png")))
          ],
        ),
      ),
    );
  }
}
