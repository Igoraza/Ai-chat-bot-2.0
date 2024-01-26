import 'package:aichatbot/main.dart';
import 'package:aichatbot/screen/chat/chat_list.dart';
import 'package:aichatbot/screen/home/Model/CategoryModel.dart';
import 'package:aichatbot/screen/home/Service.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListCard extends StatelessWidget {
  CategoryModel model;
  int instance;
  int index;
  ChatListCard({super.key, required this.model, required this.instance, required this.index});
  ChatController ctrl = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            icon: Icons.delete,
            label: "Delete",
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            onPressed: (context) async {
              Box bx = await Hive.openBox("${model.title!}${instance}");
              bx.deleteFromDisk();
              model.LastMessageTime = "";
              chatHistoryBox.deleteAt(index);
              deleteNotifier.value = deleteNotifier.value + 1;

              // SharedPreferences preferences = await SharedPreferences.getInstance();
              // preferences.setString("LAST_MESG_${model.title}${instance}", "");
              ctrl.update();
            },
          ),
        ],
      ),
      child: FadeInRight(
        child: GetBuilder<ChatController>(builder: (_) {
          return InkWell(
            onTap: () {
              ctrl.OpenChat(model, instance,false);
            },
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    // leading: Container(
                    //   height: 50,width: 50,
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFFEC9645),
                    //     borderRadius: BorderRadius.circular(10)
                    //   ),
                    // ),
                    leading: Image.asset("asset/image/ChatCard/${model.image}.png"),
                    trailing: (model.LastMessageTime == "" || model.LastMessageTime == "null")
                        ? null
                        : Text(
                            ctrl.findRelativeTime(model.LastMessageTime!, context),
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                    title: Text(
                      "${model.title}",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: "Satoshi", fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      model.firstMessage!,
                      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(.3), fontFamily: "Satoshi", fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
