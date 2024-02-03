import 'dart:developer';

import 'package:aichatbot/main.dart';
import 'package:aichatbot/screen/chat/chat.dart';
import 'package:aichatbot/screen/home/Model/CategoryModel.dart';
import 'package:aichatbot/screen/home/Model/chatHistoryModel.dart';
import 'package:aichatbot/screen/home/Model/chatMessageModel.dart';
import 'package:aichatbot/screen/splash/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lit_relative_date_time/lit_relative_date_time.dart';
import 'package:lit_relative_date_time/model/relative_date_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  CategoryModel? SelectedCategory;
  List<ChatMessageModel> MessageList = [];
  String authToken = "";
  List<Map<String, dynamic>> categoriesHistory = [];
  loadMessage(int instance) async {
    Box bk = await Hive.openBox("${SelectedCategory!.title!}${instance}");

    for (var data in bk.keys) {
      ChatMessageModel md = bk.get(data);

      MessageList.add(md);
    }
    log(MessageList.toString());
  }

  addCategoryToChatHistory(CategoryModel categoryModel, int instance, String lastMessage) async {
    // chatHistory.add(categoryTitle);
    // final list = chatHistory.values.toList();

    chatHistoryBox.put(
        "${SelectedCategory!.title!}${instance}", ChatHistoryModel(category: "${categoryModel.title!}", instance: instance, lastMessageTime: DateTime.now().toString(), lastMessage: lastMessage));
    // final newchatHistory = await Hive.openBox("chat_history");
    // log("Length of history ${chatHistoryBox.length}");
    // log("values in chat history : ${chatHistoryBox.values}");
  }

  removeCategoryFromChatHistory(int index) {
    // categoriesHistory.removeLast();

    print("length before delete:${categoriesHistory.length}");
    categoriesHistory.clear();
    print("length after delete:${categoriesHistory.length}");
  }

  loadHistory() async {
    // print(chatHistoryBox);

    categoriesHistory.clear();
    for (int i = 0; i < chatHistoryBox.length; i++) {
      String title = chatHistoryBox.getAt(i).category;
      String instance = chatHistoryBox.getAt(i).instance.toString();
      String lastTime = chatHistoryBox.getAt(i).lastMessageTime.toString();
      String lastMessage = chatHistoryBox.getAt(i).lastMessage.toString();

      // log(title);
      // log(instance);
      for (var category in CategoryList) {
        String categoryTitle = category.title!;

        if (title == categoryTitle) {
          var categoryInstance = {
            'model': category,
            'instance': instance,
            'lastMessageTime': lastTime,
            'lastMessage': lastMessage,
          };

          if (categoriesHistory.isEmpty) {
            // log("null");
            categoriesHistory = [categoryInstance];
          } else {
            // log("not empty");
            categoriesHistory.add(categoryInstance);
          }
        }
      }

      // log(categoriesHistory[0]['model'].toString());
    }
    categoriesHistory.sort((a, b) => a['lastMessageTime'].compareTo(b['lastMessageTime']));
    categoriesHistory = categoriesHistory.reversed.toList();
  }

  AddMessage(String message, bool isUser, int instance) async {
    print("Message---->$message");
    ChatMessageModel chatData = ChatMessageModel(DateTime.now().toString(), message, isUser, !isUser);
    Box bk = await Hive.openBox("${SelectedCategory!.title!}${instance}");
    bk.put(DateTime.now().toString(), chatData);
    MessageList.add(chatData);
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedPref.setString("LAST_MESG_${SelectedCategory!.title!}$instance", DateTime.now().toString());
    if (isUser) {
      log("instance:::::::::::$instance");
      chatHistoryBox.put(
          "${SelectedCategory!.title!}${instance}", ChatHistoryModel(category: "${SelectedCategory!.title!}", instance: instance, lastMessageTime: DateTime.now().toString(), lastMessage: message));
    }

    loadLogs();
    autoDown();
    update();
  }

  OpenChat(CategoryModel model, int instance, bool newInstance, String lastMessage) {
    SelectedCategory = model;
    MessageList = [];
    // String lastMessagee = "def";
    // for (int i = 0; i < chatHistoryBox.length; i++) {
    //   String title = chatHistoryBox.getAt(i).category;
    //   String instanceInBox = chatHistoryBox.getAt(i).instance.toString();
    //   // String lastTime = chatHistoryBox.getAt(i).lastMessageTime.toString();
    //   // if (model.title == title && instance == instanceInBox) {
    //   //   lastMessagee = chatHistoryBox.getAt(0).lastMessage.toString();
    //   // }

    //   //  lastMessagee = chatHistoryBox.getAt(i).lastMessage.toString();
    // }
    // logSession();
    // chatHistoryBox.put("${model!.title!}${instance + 1}", ChatHistoryModel(category: "${model.title!}", instance: instance, lastMessageTime: DateTime.now().toString(), lastMessage: lastMessagee));

    update();
    loadMessage(instance);
    Get.to(
        () => chat(
              newInstance: newInstance,
              instance: instance,
            ),
        transition: Transition.topLevel);
    autoDown();
  }

  // logSession(int instance) async {
  //   ChatMessageModel chatData = ChatMessageModel(DateTime.now().toString(), "", false, false);
  //   Box bk = await Hive.openBox("${SelectedCategory!.title!}");
  //   bk.put(DateTime.now().toString(), chatData);
  //   loadLogs();
  // }
  logSession(int instance) async {
    ChatMessageModel chatData = ChatMessageModel(DateTime.now().toString(), "", false, false);
    Box bk = await Hive.openBox("${SelectedCategory!.title!}${instance}");
    bk.put(DateTime.now().toString(), chatData);
    loadLogs();
  }

  loadToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    authToken = pref.getString("TOKEN").toString();
    update();
  }

  loadLogs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    for (var data in CategoryList) {
      data.LastMessageTime = preferences.getString("LAST_MESG_${data.title}").toString();
    }

    update();
  }
  // loadLogs() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   for (var data in categoriesHistory) {
  //     data['model'].LastMessageTime = preferences.getString("LAST_MESG_${data['model'].title}").toString();
  //   }

  //   update();
  // }

  String findRelativeTime(String time, BuildContext context) {
    RelativeDateTime _relativeDateTime = RelativeDateTime(dateTime: DateTime.now(), other: DateTime.parse(time));

    RelativeDateFormat _relativeDateFormatter = RelativeDateFormat(Localizations.localeOf(context));
    return (_relativeDateFormatter.format(_relativeDateTime));
  }

  ScrollController scrollController = ScrollController();

  autoDown() async {
    await Future.delayed(Duration(milliseconds: 400));
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    loadToken();
    loadLogs();
    super.onInit();
  }
}
