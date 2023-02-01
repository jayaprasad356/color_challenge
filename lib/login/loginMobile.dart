import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 250),
              Image.asset(
                "assets/images/app_logo.png",
                height: 130,
                width: 150,
              ),
              const SizedBox(height: 50),
              //todo login Text view
              const Text(
                "Log in",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 60),
              //todo description text view
              const Text(
                "Enter Mobile Number",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.greyss,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                child:  Material(
                  child: TextField(
                    controller: _mobileNumberController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.primary),
                      ),

                    ),
                    style: const TextStyle(backgroundColor: Colors.transparent),

                  ),
                ),
              ),
              const SizedBox(height: 60),

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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Verify.png"),
                      fit: BoxFit.fill,

                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.white, fontSize: 18),
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
