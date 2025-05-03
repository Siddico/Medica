import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Features/ForgetPasswordView/success_state.dart';
import 'package:medical/Features/ForgetPasswordView/verify_code_password.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(Imagestyles.goBack),
            const SizedBox(height: 180),
            Center(
              child: Text('New Password', style: FontStyles.style26weight700),
            ),

            const SizedBox(height: 20),
            Text('Password', style: FontStyles.style22weight600),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter Your Password',
                hintStyle: FontStyles.style18weight400.copyWith(
                  color: Color(0xff858585),
                ),
                filled: true,
                fillColor: Color(0xffD9D9D9).withOpacity(0.30),
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: Color(0xff0B8FAC),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Confirm Password', style: FontStyles.style22weight600),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm Your Password',
                hintStyle: FontStyles.style18weight400.copyWith(
                  color: Color(0xff858585),
                ),
                filled: true,
                fillColor: Color(0xffD9D9D9).withOpacity(0.30),
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: Color(0xff0B8FAC),
                ),
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
                  NavigateTo(context, SuccessStateOfResetPassword());
                  // Handle sign in
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0B8FAC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save',
                  style: FontStyles.style22weight700.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
