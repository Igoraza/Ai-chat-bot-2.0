import 'package:hive/hive.dart';
part 'chatMessageModel.g.dart';

@HiveType(typeId: 1)
class ChatMessageModel {
  @HiveField(0)
  bool? isbot;
  @HiveField(1)
  bool? isUser;
  @HiveField(2)
  String? DateTime;
  @HiveField(3)
  String? Message;
  ChatMessageModel(this.DateTime, this.Message, this.isUser, this.isbot);
}
