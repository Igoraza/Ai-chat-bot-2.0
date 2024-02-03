import 'dart:developer';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/results/get_paywalls_result.dart';
import 'package:aichatbot/screen/adapty/paywalls_screen.dart';
import 'package:aichatbot/screen/subscription/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class subscribe extends StatefulWidget {
  const subscribe({super.key});

  @override
  State<subscribe> createState() => _subscribeState();
}

class _subscribeState extends State<subscribe> {
  bool loading = false;
  @override
  void initState() {
    try {
      Adapty.activate();
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  Future<bool> callAdaptyMethod(Function method) async {
    bool success = true;
    setState(() {
      loading = true;
    });
    try {
      await method();
    } catch (e) {
      success = false;
      print(e);
    }
    setState(() {
      loading = false;
    });
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 70,
          width: double.infinity,
          color: Color(0xff040A14),
        ),
        Positioned(
          left: 20,
          child: InkWell(
            onTap: () {
              GetPaywallsResult? paywallResult;
              callAdaptyMethod(() async {
                paywallResult = await Adapty.getPaywalls();
                // log("paywall result :${paywallResult}");
              }).then((value) {
                if (value) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Subscription(
                        paywalls: paywallResult!.paywalls,
                      ),
                    ),
                  );
                } else {
                  print("error");
                }
              });
            },
            child: Image.asset('asset/image/Frame 3796_Subscribe.png'),
          ),
        )
      ],
    );
  }
}
