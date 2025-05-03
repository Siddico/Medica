import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Features/ForgetPasswordView/verify_code_password.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(Imagestyles.goBack),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Forget Password',
                style: FontStyles.style26weight700,
              ),
            ),

            const SizedBox(height: 20),
            Text('Email', style: FontStyles.style22weight600),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Your Email',
                hintStyle: FontStyles.style18weight400.copyWith(
                  color: Color(0xff858585),
                ),
                filled: true,
                fillColor: Color(0xffD9D9D9).withOpacity(0.30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  NavigateTo(context, VerifyCodePassword());
                  // Handle sign in
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0B8FAC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: FontStyles.style22weight700.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: Image.asset(Imagestyles.forgetPasswordImage, height: 413),
            ),
          ],
        ),
      ),
    );
  }
}
