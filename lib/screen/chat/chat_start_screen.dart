import 'package:aichatbot/Constant/colors.dart';
import 'package:aichatbot/controllers/app_controller.dart';
import 'package:aichatbot/screen/chat/chat_list.dart';
import 'package:aichatbot/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class ChatStartScreen extends StatelessWidget {
  ChatStartScreen({super.key});
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("asset/image/bg.png"), fit: BoxFit.fill)),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Chats",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Satoshi", fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.primaryWhite),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  )
                ],
              ),
              const SizedBox(
                height: 230,
              ),
              Text(
                "Start to Chat",
                style: TextStyle(fontFamily: "Satoshi", fontWeight: FontWeight.w700, fontSize: 32, color: AppColors.primaryWhite),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "You haven’t started cny chats.\nStart a chat now.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.3), fontFamily: "Satoshi"),
              ),
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                "asset/image/arrow.svg",
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  // Get.to(ChatListScreen());
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => ChatListScreen())));
                  controller.setOption(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(colors: [Color(0xffDF6C83), Color(0xffF38A83), Color(0xff9979C8), Color(0xff346BD6)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  height: 64,
                  width: 300,
                  child: Center(
                      child: Text(
                    "Start a chat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Satoshi"),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
