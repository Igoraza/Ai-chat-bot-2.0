import 'package:aichatbot/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.primaryWhite,
          ),
        ),
        title: Text(
          "About Us",
          style: TextStyle(color: AppColors.primaryWhite),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryBlack,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 600,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0, right: 15, left: 15),
                  child: Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0xff14173C).withOpacity(.6),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                        ),
                        Text(
                          "Chatman AI",
                          style: TextStyle(color: AppColors.primaryWhite),
                        ),
                        Text(
                          "Version 1.0.1",
                          style: TextStyle(color: AppColors.primaryWhite?.withOpacity(.3)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Lorem ipsum dolor sit amet consectetur. Vel facilisis feugiat sit molestie a. Sed tristique nisl ut dictum enim. Sem placerat morbi varius interdum ut non consequat sed. Interdum purus dolor aliquam molestie id. Eu turpis faucibus morbi est maecenas quisque egestas sit integer. Maecenas quis aliquam eget et ut. Viverra quam erat purus a aliquam gravida convallis pretium ut. Dui maecenas magna vitae vel sit in faucibus convallis. Purus ullamcorper sit sit ac aliquam convallis volutpat mattis.",
                            style: TextStyle(
                              color: AppColors.primaryWhite?.withOpacity(.3),
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 100,
                right: 100,
                top: 0,
                child: SvgPicture.asset(
                  "asset/image/Avatar.svg",
                  width: 280,
                  height: 280,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
