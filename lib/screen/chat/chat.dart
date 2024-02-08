import 'dart:convert';
import 'dart:developer';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_ui_flutter/adapty_ui_flutter.dart';
import 'package:aichatbot/Constant/EndPoints.dart';
import 'package:aichatbot/Constant/StringConst.dart';
import 'package:aichatbot/screen/chat/componets/botMessage.dart';
import 'package:aichatbot/screen/chat/componets/get_premium_tile.dart';

import 'package:aichatbot/screen/chat/componets/presonMessage.dart';
import 'package:aichatbot/screen/home/Service.dart';
import 'package:aichatbot/screen/settings/subscribe/subscribe.dart';
import 'package:aichatbot/screen/splash/splash.dart';
import 'package:dio/dio.dart' as Request;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

int? freeMessageCountOfTheWeek = null;
bool? isPremiumUser = false;

class chat extends StatefulWidget {
  chat({super.key, this.newInstance = false, required this.instance});
  bool newInstance;
  int instance;
  @override
  State<chat> createState() => _chatState();
}

ChatController ctrl = Get.put(ChatController());

class _chatState extends State<chat> {
  List messageList = [];
  TextEditingController messageText = TextEditingController();

  void initState() {
    super.initState();
    // Your initialization code here
    getFreeMessageCount();
    checkIsPremiumMember();
    if (freeMessageCountOfTheWeek == null || isPremiumUser == null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.width / 384;
    getFreeMessageCount();
    checkIsPremiumMember();
    if (freeMessageCountOfTheWeek == null) freeMessageCountOfTheWeek = 1;
    // if (isPremiumUser == null) isPremiumUser = false;
    return Scaffold(
      body: GetBuilder<ChatController>(
        builder: (_) {
          log("... ${ctrl.SelectedCategory?.title} ");

          return Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xff040A14),

              // Stack to hold  ---Components---
              child: Stack(
                children: [
                  if (false)
                    SizedBox(
                      height: 59,
                      width: double.infinity,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(color: Color(0xff040A14)),
                      ),
                    ),
                  Positioned(
                      top: 80 * ratio,
                      left: 30 * ratio,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                          size: 25 * ratio,
                        ),
                      )),
                  Positioned(
                    top: 60 * ratio,
                    left: 30 * ratio,
                    right: 30 * ratio,
                    child: Container(
                      width: double.infinity,
                      height: 65 * ratio,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20 * ratio),
                      padding: EdgeInsets.symmetric(horizontal: 22 * ratio, vertical: 14 * ratio),
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(25),
                          color: Color(0xff040A14)),
                      child: GradientText(
                        ctrl.SelectedCategory!.title!,
                        textAlign: TextAlign.center,
                        colors: [
                          Color(0xffDF6C83),
                          Color(0xffDC8F8A),
                          Color(0xff9979C8),
                          Color(0xff346BD6),
                        ],
                        style: TextStyle(fontSize: 20 * ratio, fontWeight: FontWeight.w700, fontFamily: "Satoshi"),
                      ),
                    ),
                  ),
                  SizedBox(child: Image.asset('asset/image/Vector 121 (Stroke).png')),
                  if (true)
                    SizedBox(
                      height: 14,
                      width: double.infinity,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(color: Color(0xff040A14)),
                      ),
                    ),

                  // Created ListView to Display components there ...!
                  //Load Data from Components
                  Positioned(
                    top: 120 * ratio,
                    left: 0 * ratio,
                    right: 0 * ratio,
                    bottom: 50 * ratio,
                    child: ListView(
                      controller: ctrl.scrollController,
                      children: [
                        for (int i = 0; i < ctrl.MessageList.length; i++)
                          // for (var mess in ctrl.MessageList)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (i % 2 == 0)
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(ctrl.findRelativeTime(ctrl.MessageList[i].DateTime!, context), textAlign: TextAlign.center, style: TextStyle(color: Color(0xff5C628F), fontFamily: "hk")),
                                ),
                              if (ctrl.MessageList[i].isUser!)
                                personMessage(ctrl.MessageList[i].Message!)
                              else if (ctrl.MessageList[i].isbot!)
                                botMessage(ctrl.MessageList[i].Message!)
                              else
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(ctrl.findRelativeTime(ctrl.MessageList[i].DateTime!, context), textAlign: TextAlign.center, style: TextStyle(color: Color(0xff5C628F), fontFamily: "hk")),
                                ),
                              SizedBox(
                                height: 30 * ratio,
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: Container(
        // margin: EdgeInsets.symmetric(horizontal: 20),
        // height: 52 * ratio,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Color(0XFF071223), borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: !isPremiumUser!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Free message this week : $freeMessageCountOfTheWeek",
                          style: TextStyle(fontFamily: "hk", color: Colors.white54),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () async {
                            AdaptyPaywall? paywall;
                            try {
                              paywall = await Adapty().getPaywall(placementId: "chatgpt.smartchatbot");
                              // paywall.printInfo();
                              // log("paywall: ${paywall}");
                              // Get.to(() => MainScreen());

                              final view = await AdaptyUI().createPaywallView(paywall: paywall, locale: "en");
                              AdaptyUI().addObserver(AdaptyObserver());

                              log(view.toString());
                              await view.present();
                            } catch (e) {
                              print("e:$e");
                            }
                          },
                          child: GetPremiumTile(),
                        ),
                      ],
                    )
                  : SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: messageText,
                onSubmitted: (value) async {
                  SharedPreferences sharedPref = await SharedPreferences.getInstance();
                  ctrl.addCategoryToChatHistory(ctrl.SelectedCategory!, widget.instance, messageText.text);
                  if (widget.newInstance) {
                    print("true");
                    sharedPref.setInt(ctrl.SelectedCategory!.title!, widget.instance);
                    widget.newInstance = false;
                    sharedPref.setInt(ctrl.SelectedCategory!.title!, widget.instance + 1)!;
                  }
                  sendMessage(value, widget.instance);
                },
                style: TextStyle(fontFamily: "hk", color: Colors.white54),
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0), // Adjust border radius as needed
                      borderSide: BorderSide(color: Colors.transparent), // Set border color to transparent
                    ),
                    filled: true,
                    fillColor: Color(0XFF101227), // Set background color
                    hintText: "Send Message",
                    hintStyle: TextStyle(fontFamily: "hk", color: Colors.white54),
                    suffixIcon: InkWell(
                      onTap: () async {
                        print("adding to history");
                        SharedPreferences sharedPref = await SharedPreferences.getInstance();
                        int instance = sharedPref.getInt(ctrl.SelectedCategory!.title!)!;
                        if (widget.newInstance) {
                          ctrl.addCategoryToChatHistory(ctrl.SelectedCategory!, instance, messageText.text);
                          widget.newInstance = false;
                          // print("true.......................");
                          instance++;
                        } else {
                          // print("false............");
                        }

                        sharedPref.setInt(ctrl.SelectedCategory!.title!, instance);
                        sendMessage(messageText.text.trim(), widget.instance);
                        // change time here
                        setState(() {
                          messageText.text = "";
                        });
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white70,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> getFreeMessageCount() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int? freeMessageCount = await sharedPref.getInt("freeMessageCount");

    log(freeMessageCountOfTheWeek.toString());
    if (freeMessageCount == null) {
      freeMessageCountOfTheWeek = 1;
      log(freeMessageCount.toString());
    }
    return freeMessageCountOfTheWeek!;
  }

  Future<bool> checkIsPremiumMember() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.getBool('isSubscribed') == true) {
      return true;
    } else {
      return false;
    }
  }

  sendMessage(String message, int instance) async {
    messageList.add(personMessage(message));

    // SharedPreferences sharedPref = await SharedPreferences.getInstance();
    // int instance = sharedPref.getInt(ctrl.SelectedCategory!.title!)!;
    // log("message :: $message");
    ctrl.AddMessage(message, true, instance);
    ctrl.autoDown();
    final jsonResponse = jsonEncode(
      {
        "message": message,
        "history": [
          for (int i = 0; i < 10 && i < ctrl.MessageList.length; i++)
            if (ctrl.MessageList[i].isUser! || ctrl.MessageList[i].isbot!)
              {if (ctrl.MessageList[i].isUser!) "user": ctrl.MessageList[i].Message else if (ctrl.MessageList[i].isbot!) "ai": ctrl.MessageList[i].Message}
        ],
        "category": ctrl.SelectedCategory!.categoryID!
      },
    );
    final messages = jsonDecode(jsonResponse);
    // log("messages : $messages");
    // print("message :: $messages['message']");
    //scrollController.animateTo(scrollController.position.maxScrollExtent,
    // duration: Duration(milliseconds: 200), curve: Curves.easeInOut);

    try {
      final isUserHaveAccess = await verifyUserAccess();

      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      // log("history ${sharedPref.getBool(HAVECHATHISTORY)}");
      final haveChatHistory = sharedPref.getBool(HAVECHATHISTORY);
      if (haveChatHistory == null) {
        sharedPref.setBool(HAVECHATHISTORY, true);
      }
      if (isUserHaveAccess) {
        final Request.Dio dio = Request.Dio();
        // log("Sending message");
        String token = (ctrl.authToken).toString();
        // log(token);

        final response = await dio.post(
          endpoint + "chat/message",
          options: Request.Options(
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          ),
          data: {
            "message": message,
            "history": messages["history"],
            "category": ctrl.SelectedCategory!.categoryID!,
          },
        );

        // log(response.data.toString());
        print(response.statusCode);

        if (response.statusCode == 200) {
          // log("success");
          var data = response.data;
          if (data["status"] == "success") {
            SharedPreferences sharedPref = await SharedPreferences.getInstance();
            freeMessageCountOfTheWeek = sharedPref.getInt("freeMessageCount")!;
            sharedPref.setInt("freeMessageCount", (freeMessageCountOfTheWeek! - 1));
            setState(() {
              ctrl.AddMessage(data["message"], false, instance);
              freeMessageCountOfTheWeek = sharedPref.getInt("freeMessageCount")!;
            });
          } else {
            // Handle other cases if needed
          }
        } else if (response.statusCode == 401) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("TOKEN", "null");
          pref.setString("NAME", "null");
          pref.clear();
          Get.offAll(() => Splash());
        }
      } else {
        // print("User have no free messages");
        setState(() {
          ctrl.AddMessage("Sorry... Your free messages are over. Please upgrade to premium!", false, instance);
        });
      }
      setState(() {});
    } catch (e) {
      print("Error: $e");
      // Handle error
    }
  }

  verifyUserAccess() async {
    // log("verifying user");
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    final currentDate = DateTime.now();

    // print("subscribed ${sharedPref.getBool('isSubscribed')}");
    if (sharedPref.getBool('isSubscribed') == true) {
      return true;
    } else if (sharedPref.getString("refreshedDate") == null || sharedPref.getInt("freeMessageCount") == null) {
      sharedPref.setString('refreshedDate', DateTime.now().toString());
      sharedPref.setInt("freeMessageCount", 1);

      return true;
    } else {
      final freeMessageCount = sharedPref.getInt("freeMessageCount");
      final refreshedDate = DateTime.parse(sharedPref.getString("refreshedDate")!);
      final dayDiff = currentDate.difference(refreshedDate).inDays;
      // print("refreshed date : $refreshedDate");
      // print("current date : $currentDate");
      // print("day diff $dayDiff");
      // print("free msg $freeMessageCount");
      if (dayDiff > 7 || freeMessageCount! > 0) {
        sharedPref.setInt("freeMessageCount", 1);
        return true;
      } else {
        return false;
      }
    }
  }
}
