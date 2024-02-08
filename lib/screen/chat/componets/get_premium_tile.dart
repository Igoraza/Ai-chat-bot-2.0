import 'package:flutter/material.dart';

class GetPremiumTile extends StatelessWidget {
  const GetPremiumTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Adjust as needed

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red,
            Colors.blue,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0XFF071223),
            borderRadius: BorderRadius.circular(20), // Adjust as needed
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red,
                    Colors.blue,
                  ],
                ).createShader(bounds);
              },
              child: Text(
                'Get Premium',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // This color will be overridden by the gradient
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
