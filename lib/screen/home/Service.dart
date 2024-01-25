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

  loadMessage() async {
    Box bk = await Hive.openBox(SelectedCategory!.image!);

    for (var data in bk.keys) {
      ChatMessageModel md = bk.get(data);

      MessageList.add(md);
    }
    log(MessageList.toString());
  }

  addCategoryToChatHistory(CategoryModel categoryModel) async {
    log("working.......");
    
    // chatHistory.add(categoryTitle);
    // final list = chatHistory.values.toList();

    chatHistoryBox.put("${categoryModel.title}a", ChatHistoryModel(category: "${categoryModel.title!}", instance: 0));
    // final newchatHistory = await Hive.openBox("chat_history");
    log("Length of history ${chatHistoryBox.length}");
    log("values in chat history : ${chatHistoryBox.values}");
  }

  loadHistory() async {
    // final chatHistoryBox = await Hive.openBox<ChatHistoryModel>("chatHistory");
    log(chatHistoryBox.getAt(2)!.category.toString());
  }

  AddMessage(String message, bool isUser) async {
    print("here");
    ChatMessageModel chatData = ChatMessageModel(DateTime.now().toString(), message, isUser, !isUser);
    Box bk = await Hive.openBox(SelectedCategory!.image!);
    bk.put(DateTime.now().toString(), chatData);
    MessageList.add(chatData);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("LAST_MESG_${SelectedCategory!.image}", DateTime.now().toString());
    loadLogs();
    autoDown();
    update();
  }

  OpenChat(CategoryModel model) {
    SelectedCategory = model;
    MessageList = [];
    // logSession();

    update();
    loadMessage();
    Get.to(() => chat(), transition: Transition.topLevel);
    autoDown();
  }

  logSession() async {
    ChatMessageModel chatData = ChatMessageModel(DateTime.now().toString(), "", false, false);
    Box bk = await Hive.openBox(SelectedCategory!.image!);
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
      data.LastMessageTime = preferences.getString("LAST_MESG_${data.image}").toString();
    }

    update();
  }

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
