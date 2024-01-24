import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:adapty_flutter/models/adapty_period.dart';
import 'package:aichatbot/helper/value_to_string.dart';
import 'package:flutter/material.dart';

class PaywallsScreen extends StatefulWidget {
  const PaywallsScreen({super.key, this.paywalls});

  final List<AdaptyPaywall>? paywalls;

  @override
  State<PaywallsScreen> createState() => _PaywallsScreenState();
}

class _PaywallsScreenState extends State<PaywallsScreen> {
  @override
  Widget build(BuildContext context) {
    final paywalls = widget.paywalls;
    return Scaffold(
      body: (paywalls != null && paywalls.isNotEmpty)
          ? ListView.builder(
              itemCount: paywalls.length,
              itemBuilder: (ctx, index) {
                final paywall = paywalls[index];
                return Column(
                  children: [
                    Text("Choose plan"),
                    if (paywall.products != null)
                      ListView.builder(
                        itemCount: paywall.products!.length,
                        itemBuilder: (context, index) {
                          final paywall = paywalls[index];
                          final product = paywall.products![index];
                          // final details = {

                          // }
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // selectedItem = index;
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: Wrap(
                                  children: [
                                    // adaptyPeriodToString(product.subscriptionPeriod),
                                    Text("data")
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await Adapty.makePurchase(paywall.products![0]);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text("sdfs"),
                    )
                  ],
                );
              },
            )
          : Center(child: Text("Paywall not recieved")),
    );
  }
}
