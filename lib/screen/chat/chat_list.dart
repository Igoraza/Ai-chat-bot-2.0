import 'package:aichatbot/Constant/colors.dart';
import 'package:aichatbot/screen/chat/chatlistCard.dart';
import 'package:aichatbot/screen/home/home.dart';
import 'package:aichatbot/screen/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryBlack,
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              // when using Get.back, ChatController getting deleted
              // Get.back();
              option = 0;
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primaryWhite,
            ),
          ),
          title: Text(
            "Chats",
            style: TextStyle(color: AppColors.primaryWhite),
          ),
          backgroundColor: AppColors.primaryBlack,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var data in CategoryList) SizedBox(width: MediaQuery.of(context).size.width, height: 100, child: ChatListCard(model: data)),
            ],
          ),
        ));
  }
}
