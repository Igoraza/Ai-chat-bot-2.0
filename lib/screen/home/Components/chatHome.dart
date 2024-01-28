import 'dart:developer';

import 'package:aichatbot/Constant/StringConst.dart';
import 'package:aichatbot/controllers/app_controller.dart';
import 'package:aichatbot/screen/chat/chat.dart';
import 'package:aichatbot/screen/chat/chat_list.dart';
import 'package:aichatbot/screen/chat/chat_start_screen.dart';
import 'package:aichatbot/screen/chat/chatlistCard.dart';
import 'package:aichatbot/screen/home/Model/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ChatHome extends StatefulWidget {
  ChatHome({
    super.key,
    required this.model,
  });

  final CategoryModel model;
  AppController controller = Get.put(AppController());
  @override
  State<ChatHome> createState() => _chatHomeState();
}

class _chatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.width / 384;
    return Container(
      padding: EdgeInsets.all(25 * ratio),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60 * ratio,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
                height: 260 * ratio,
                width: 190 * ratio,
                child: Image.asset(
                  "asset/image/botimage.JPG",
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
              width: 55 * ratio,
              height: 55 * ratio,
              child: Image.asset(
                "asset/image/botprofile.png",
                fit: BoxFit.fill,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14 * ratio, vertical: 22 * ratio),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff5C628F),
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20), topRight: Radius.circular(20))),
            child: Text(
              Stringchome,
              style: TextStyle(color: Color.fromARGB(255, 109, 113, 143), fontFamily: "hk", fontSize: 14 * ratio, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 30 * ratio,
          ),
          InkWell(
            onTap: () async {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => chat()));
              // Get.to(() => ChatListScreen(), transition: Transition.downToUp, duration: Duration(milliseconds: 700));
              SharedPreferences sharedPref = await SharedPreferences.getInstance();
              int instance = sharedPref.getInt(widget.model.title!)!;
              log("category : ${widget.model.title!}");
              log("instance : $instance");

              await ctrl.OpenChat(widget.model, instance, true);
              Future.delayed(Duration(milliseconds: 500), () {
                widget.controller.setOption(0);
              });
            },
            child: Container(
              width: 179 * ratio,
              height: 65 * ratio,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 75 * ratio),
              padding: EdgeInsets.symmetric(horizontal: 22 * ratio, vertical: 14 * ratio),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Color(0xff0B0F20)),
              child: GradientText(
                "Chat Now",
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
          Container(
            padding: EdgeInsets.all(5 * ratio),
            margin: EdgeInsets.all(25 * ratio),
            child: Image.asset("asset/image/getpreminum.JPG"),
          )
        ],
      ),
    );
  }
}
