import 'package:aichatbot/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "asset/image/Group 3.svg",
              ),
              Text(
                "Hi, .....!",
                style: TextStyle(
                    fontFamily: "Satoshi",
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: AppColors.primaryWhite),
              ),
              const SizedBox(height: 20,),
              Text(
                "Oh No! ",
                style: TextStyle(
                    fontFamily: "Satoshi",
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: AppColors.primaryWhite),
              ),
              const Text(
                "What should I call you ?",
                style: TextStyle(fontSize: 19,color: Colors.white),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryWhite?.withOpacity(.3)
                ),
                height: 50,
                width: 300,
                child: Center(child: Text("Type your name",
                 style: TextStyle(fontSize: 15,color: Colors.white.withOpacity(.3)),)),
              )
            ]),
      ),
    );
  }
}
