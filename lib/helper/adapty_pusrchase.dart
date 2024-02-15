import 'dart:developer';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_ui_flutter/adapty_ui_flutter.dart';
import 'package:aichatbot/screen/settings/subscribe/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AdaptyPurchaseHelper {
  static final GlobalKey<NavigatorState> popupKey = GlobalKey<NavigatorState>();

  startPurchase(BuildContext context) async {
    AdaptyPaywall? paywall;
    try {
      showPopup(context);
      paywall = await Adapty().getPaywall(placementId: "chatgpt.smartchatbot");

      final view = await AdaptyUI().createPaywallView(paywall: paywall, locale: "en");
      AdaptyUI().addObserver(AdaptyObserver());

      log(view.toString());

      await view.present();
      Navigator.of(context).pop();
    } catch (e) {
      print("e:$e");
    }
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loading Premium Plans'),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 20,
              ),
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: const Color(0xFFEA3799),
                size: 50,
              ),
            ),
          ),
        );
      },
    );
  }
}
