// import 'package:aichatbot/Constant/colors.dart';
// import 'package:aichatbot/screen/chat/chatlistCard.dart';
// import 'package:aichatbot/screen/splash/splash.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/route_manager.dart';

// class NewComerChatList extends StatelessWidget {
//   const NewComerChatList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.primaryBlack,
//         appBar: AppBar(
//           leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Icon(
//               Icons.arrow_back,
//               color: AppColors.primaryWhite,
//             ),
//           ),
//           title: Padding(
//             padding: const EdgeInsets.only(left: 98.0),
//             child: Text(
//               "Chats",
//               style: TextStyle(color: AppColors.primaryWhite),
//             ),
//           ),
//           backgroundColor: AppColors.primaryBlack,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               for (var data in CategoryList) SizedBox(width: MediaQuery.of(context).size.width, height: 100, child: ChatListCard(model: data)),
//             ],
//           ),
//         ));
//   }
// }
