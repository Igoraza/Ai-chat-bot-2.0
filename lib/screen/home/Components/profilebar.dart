import 'package:aichatbot/Constant/functions.dart';
import 'package:aichatbot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${greetUser(DateTime.now().hour)}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(.5),
                      fontFamily: "Satoshi"),
                ),
                Text(
                  "$Name",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Satoshi"),
                ),
              ],
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              //   border: Border.all(width: 2, color: Color(0xff0D1227))
            ),
            child: Image.asset(
              "asset/image/pavatar.png",
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
