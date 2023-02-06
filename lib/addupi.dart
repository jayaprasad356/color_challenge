import 'package:flutter/material.dart';



class addupi extends StatefulWidget {
  const addupi({Key? key}) : super(key: key);

  @override
  State<addupi> createState() => _addupiState();
}

class _addupiState extends State<addupi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(



      child: Container(

        child: Column(
          children: [
            const SizedBox(height: 10,),
            AppBar(
              centerTitle: true,
              leading: Icon(Icons.arrow_back_outlined,color: Colors.black),

              title: Text('Add UPI',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),),

              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20,),
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
                    'Verify',style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"

                  ) ,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
