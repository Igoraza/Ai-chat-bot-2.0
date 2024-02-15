import 'dart:developer';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_ui_flutter/adapty_ui_flutter.dart';
import 'package:aichatbot/helper/adapty_pusrchase.dart';

import 'package:aichatbot/screen/subscription/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdaptyObserver implements AdaptyUIObserver {
  // Implement necessary methods here

  @override
  void paywallViewDidFailLoadingProducts(AdaptyUIView view, AdaptyError error) {
    print("Failed product loading :${error}");
  }

  @override
  void paywallViewDidFailPurchase(AdaptyUIView view, AdaptyPaywallProduct product, AdaptyError error) {
    log(error.message);
  }

  @override
  void paywallViewDidFailRendering(AdaptyUIView view, AdaptyError error) {
    log("failed rendering:$error");
  }

  @override
  void paywallViewDidFailRestore(AdaptyUIView view, AdaptyError error) {
    log("failed restore:${error}");
  }

  @override
  void paywallViewDidFinishPurchase(AdaptyUIView view, AdaptyPaywallProduct product, AdaptyProfile profile) async {
    log("Finished purchase");

    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('isSubscribed', true);
  }

  @override
  void paywallViewDidFinishRestore(AdaptyUIView view, AdaptyProfile profile) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('isSubscribed', true);
  }

  @override
  void paywallViewDidSelectProduct(AdaptyUIView view, AdaptyPaywallProduct product) {
    void paywallViewDidSelectProduct(AdaptyUIView view, AdaptyPaywallProduct product) {
      log(product.toString());
    }
  }

  @override
  void paywallViewDidStartPurchase(AdaptyUIView view, AdaptyPaywallProduct product) {
    log("Started purchase of $product");
  }

  @override
  void paywallViewDidCancelPurchase(AdaptyUIView view, AdaptyPaywallProduct product) {
    log("Canceled purchase of $product");
  }

  @override
  void paywallViewDidPerformAction(AdaptyUIView view, AdaptyUIAction action) {
    switch (action.type) {
      case AdaptyUIActionType.close:
        view.dismiss();
        break;
      default:
        break;
    }
  }
}

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
      Adapty().activate();
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  Future<bool> callAdaptyMethod(Function method) async {
    log("message");
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
              AdaptyPurchaseHelper().startPurchase(context);
            },
            child: Image.asset('asset/image/Frame 3796_Subscribe.png'),
          ),
        )
      ],
    );
  }
}
