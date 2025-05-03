import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Features/ForgetPasswordView/reset_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodePassword extends StatelessWidget {
  const VerifyCodePassword({super.key});

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
            const SizedBox(height: 200),
            Center(
              child: Text(
                'Enter Verification Code',
                style: FontStyles.style26weight700.copyWith(fontSize: 36),
              ),
            ),
            SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 4, // number of squares
              onChanged: (value) {
                print(value);
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 72,
                fieldWidth: 72,
                activeFillColor: Colors.white,
                selectedColor: Colors.blue,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20),
            Center(
              child: Text(
                'Enter code that we have sent to your email ',
                style: FontStyles.style14wight400.copyWith(
                  color: Color(0xff666666),
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
              ),
            ),
            const SizedBox(height: 85),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle sign in
                  NavigateTo(context, ResetPassword());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0B8FAC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Send',
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
