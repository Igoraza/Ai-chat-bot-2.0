import 'dart:developer';

import 'package:aichatbot/Constant/StringConst.dart';
import 'package:aichatbot/screen/chat/chat_list.dart';
import 'package:aichatbot/screen/chat/chat_start_screen.dart';
import 'package:aichatbot/screen/home/Components/chatHome.dart';
import 'package:aichatbot/screen/home/Components/profilebar.dart';
import 'package:aichatbot/screen/home/Service.dart';
import 'package:aichatbot/screen/settings/settings.dart';
import 'package:aichatbot/screen/splash/splash.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

int option = 0;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List items = ["Education", "Career Councelor", "Relationship Coach", "Personal Trainer", "Traveller", "philosopher"];

late bool? haveChatHistory;

List<double> sliderPosition = [35, 100, 200];
ChatController ctrl = Get.put(ChatController());

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.width / 384;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff040A14),
        child: Stack(
          children: [
            if (option == 0)
              Positioned(
                  top: 40 * ratio,
                  left: 20 * ratio,
                  right: 20 * ratio,
                  bottom: 90,
                  child: Column(
                    children: [
                      ProfileBar(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            //  alignment: WrapAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset("asset/image/premiumCard.png"),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "What’s in your mind ?",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(.7), fontFamily: "Satoshi"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Wrap(
                                  runSpacing: 15,
                                  spacing: 15,
                                  children: [
                                    for (var data in CategoryList)
                                      FadeInUp(
                                        child: InkWell(
                                            onTap: () {
                                              ctrl.OpenChat(data);
                                            },
                                            child: SizedBox(
                                              width: 160 * ratio,
                                              height: 120 * ratio,
                                              child: Image.asset(
                                                "asset/image/homeCard/${data.image}.png",
                                                fit: BoxFit.fitWidth,
                                              ),
                                            )),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            if (option == 1)
              Positioned(
                top: 0 * ratio,
                left: 0,
                right: 0,
                bottom: 0 * ratio,
                child: haveChatHistory == true ? ChatListScreen() : ChatStartScreen(),
              ),
            if (option == 2)
              Positioned(
                top: 20 * ratio,
                left: 10 * ratio,
                right: 5 * ratio,
                bottom: 5 * ratio,
                child: settings(),
              ),
            Positioned(
                bottom: 0,
                left: -10,
                right: -10,
                child: Container(
                  height: 90 * ratio,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 25, 28, 59),
                      borderRadius: BorderRadius.only(
                        // bottomLeft: Radius.circular(60),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        // bottomRight: Radius.circular(60),
                      )),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10 * ratio,
                        child: AnimatedContainer(
                          margin: EdgeInsets.only(left: (54 + option * 94) * ratio),
                          duration: Duration(microseconds: 200),
                          curve: Curves.easeIn,
                          child: SvgPicture.asset(
                            "asset/image/slider.svg",
                          ),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        bottom: 25,
                        left: 45,
                        right: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: (option != 0) ? .4 : 1,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      option = 0;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    "asset/image/Explore.svg",
                                  )),
                            ),
                            SizedBox(
                              width: 47,
                            ),
                            Opacity(
                              opacity: (option != 1) ? .4 : 1,
                              child: InkWell(
                                  onTap: () async {
                                    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
                                    haveChatHistory = sharedPref.getBool(HAVECHATHISTORY);
                                    log("history :: ${haveChatHistory}");
                                    setState(() {
                                      option = 1;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    "asset/image/chat.svg",
                                  )),
                            ),
                            SizedBox(
                              width: 47,
                            ),
                            Opacity(
                              opacity: (option != 2) ? .4 : 1,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      option = 2;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    "asset/image/Profile.svg",
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
