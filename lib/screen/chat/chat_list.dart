import 'dart:developer';

import 'package:aichatbot/Constant/colors.dart';
import 'package:aichatbot/controllers/app_controller.dart';
import 'package:aichatbot/main.dart';
import 'package:aichatbot/screen/chat/chatlistCard.dart';
import 'package:aichatbot/screen/home/Model/CategoryModel.dart';
import 'package:aichatbot/screen/home/Service.dart';
import 'package:aichatbot/screen/home/home.dart';
import 'package:aichatbot/screen/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

List<CategoryModel> categoriesInChatHistory = [];
ValueNotifier<int> deleteNotifier = ValueNotifier(0);

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});
  AppController controller = Get.put(AppController());
  ChatController ctrl = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    // ctrl.loadHistory();
    // print("Chathistory length : ${chatHistory.length}");
    // for (var category in CategoryList) {
    //   String title = category.title!;
    //   if (chatHistory.values.contains(title)) {
    //     categoriesInChatHistory.add(category);
    //   }
    // }
    //
    return Scaffold(
        backgroundColor: AppColors.primaryBlack,
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              controller.setOption(0);
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
        body: ValueListenableBuilder(
            valueListenable: deleteNotifier,
            builder: (context, value, _) {
              ctrl.loadHistory();

              return ListView.builder(
                itemBuilder: (context, index) {
                  // log("chathistory item ${chatHistoryBox.getAt(index).category}");
                  log("chathistory item ${ctrl.categoriesHistory[index]['lastMessageTime']}");
                  log("chathistory time ${sharedPref.getString("${ctrl.categoriesHistory[index]['model']}${ctrl.categoriesHistory[index]['instance']}")}");
                  return ChatListCard(
                    model: ctrl.categoriesHistory[index]['model'],
                    instance: int.parse(ctrl.categoriesHistory[index]['instance']),
                    index: index,
                    lastMessageTime: "${ctrl.categoriesHistory[index]['lastMessageTime']}",
                  );
                },
                itemCount: ctrl.categoriesHistory.length,
              );
            })

        // SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       for (var data in chatHistory)
        //         SizedBox(
        //           width: MediaQuery.of(context).size.width,
        //           height: 100,
        //           child: ChatListCard(model: data),
        //         ),
        //     ],
        //   ),
        // ),
        );
  }
}
