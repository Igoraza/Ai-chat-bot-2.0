import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:aichatbot/screen/OnBoardingScreen.dart';
import 'package:aichatbot/screen/home/Model/CategoryModel.dart';
import 'package:aichatbot/screen/home/Model/chatHistoryModel.dart';
import 'package:aichatbot/screen/home/Model/chatHistoryModel.dart';
import 'package:aichatbot/screen/home/Model/chatMessageModel.dart';
import 'package:aichatbot/screen/home/home.dart';
import 'package:aichatbot/screen/question/question.dart';
import 'package:aichatbot/screen/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:aichatbot/screen/settings/settings.dart';
import 'package:aichatbot/screen/subscription/subscription.dart';
import 'package:aichatbot/screen/chat/chat.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/about/about.dart';
import 'screen/chat/chat_list.dart';

String Name = "";

var chatHistoryBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ChatMessageModelAdapter().typeId)) {
    Hive.registerAdapter(ChatMessageModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ChatHistoryModelAdapter().typeId)) {
    Hive.registerAdapter(ChatHistoryModelAdapter());
  }
  chatHistoryBox = await Hive.openBox<ChatHistoryModel>("chatHistory");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Name = preferences.getString("NAME").toString();
  // chatHistory = await Hive.openBox("chat_history");
  try {
    Adapty.activate();
  } catch (e) {
    print("adapty activation error :$e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AIChat Bot',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
