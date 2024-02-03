import 'package:aichatbot/screen/home/Model/CategoryModel.dart';
import 'package:hive/hive.dart';
part 'chatHistoryModel.g.dart';

@HiveType(typeId: 2)
class ChatHistoryModel {
  ChatHistoryModel({
    required this.category,
    required this.instance,
    required this.lastMessageTime,
    required this.lastMessage,
  });
  @HiveField(0)
  String category;
  @HiveField(1)
  int instance;
  @HiveField(2)
  String lastMessageTime;
  @HiveField(3)
  String lastMessage;
}
