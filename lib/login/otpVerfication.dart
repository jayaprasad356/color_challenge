import 'package:color_challenge/homePage.dart';
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
  TextStyle style = const TextStyle(color: Colors.white,
      fontSize: 18,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold);

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
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: OTPTextField(
                    controller: otpController,
                    length: 5,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: const TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      print("Changed: " + pin);
                    },
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    }),
              ),
              const SizedBox(height: 60),
              const Text(
                "Resend OTP",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.primary,
                    fontFamily: "Montserrat"
                ),
              ),
              const SizedBox(height: 60,),
              MaterialButton(
                onPressed: () {
                  btmSheet();
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
                  child: Center(
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

  btmSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 30,),
                 const Center(
                   child: Text(
                    "Enter Referal Code (optional)",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.greyss,
                        fontFamily: "Montserrat"
                    ),
                ),
                 ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.primary),
                      ),
                    ),
                    style: TextStyle(backgroundColor: Colors.transparent),
                  ),
                ),
                const SizedBox(height: 60),

                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 80,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Verify.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
        ]
            ),
          );
        });
  }
}
