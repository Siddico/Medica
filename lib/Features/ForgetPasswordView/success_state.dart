import 'package:flutter/material.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';

class SuccessStateOfResetPassword extends StatelessWidget {
  const SuccessStateOfResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(Imagestyles.successState)),
          SizedBox(height: 30),
          Text(
            'Thanks',
            style: FontStyles.style28wight500.copyWith(
              color: Color(0xff0B8FAC),
              fontSize: 40,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Your Action Is Successfully',
            style: FontStyles.style22weight600.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
