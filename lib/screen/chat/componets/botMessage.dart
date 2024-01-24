import 'package:flutter/material.dart';
import 'package:type_text/type_text.dart';

botMessage(String message) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 15,
      ),
      SizedBox(
          width: 55,
          height: 55,
          child: Image.asset(
            "asset/image/botprofile.png",
            fit: BoxFit.fill,
          )),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 22),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff5C628F),
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20))),
        child: TypeText(
          "$message",
          duration: Duration(milliseconds: 15 * message.length),
          style: TextStyle(
              color: Color.fromARGB(255, 109, 113, 143),
              fontFamily: "hk",
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ),
    ],
  );
}
