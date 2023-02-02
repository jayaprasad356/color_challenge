import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  OtpFieldController otpController = OtpFieldController();
  TextStyle style=const TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'Montserrat',fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(

          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 160),
              Image.asset(
                "assets/images/otp_mobile.png",
                height: 150,
                width: 180,
              ),
              const SizedBox(height: 80),
              //todo OTP Text view
              const Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat"
                ),
              ),
              const SizedBox(height: 20),
              //todo description OTP view
              const Text(
                "The OTP sent to +998 91 234 56 87",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.greyss,
                    fontFamily: "Montserrat"
                ),
              ),

              MaterialButton(
                onPressed: () {
                  // Perform some action
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Verify.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child:  Center(
                    child: Text(
                      'Verify',
                      style: style,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
