import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 60),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Refer  a friend and get 50 coins',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/copy.png",
                                  width: 24.0,
                                  height: 24.0,
                                ),
                                const SizedBox(width: 8.0),
                                const Text(
                                  'GBD 21',
                                  style: TextStyle(
                                    color: Colors.primary,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(width: 16.0),
                      MaterialButton(
                        onPressed: () {},
                        color: Colors.primary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                'Button Text',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cc_green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/fly.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Join Green',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("1:2", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cc_skyblue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/fly.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Join Blue',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("1:2", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cc_red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/fly.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Join Red',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("1:2", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cc_pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/fly.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Join Pink',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("1:2", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cc_yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/fly.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Join Yellow',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("1:2", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cc_purpul,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            btmSheet();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/fly.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Join Purple',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("1:2", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
          height: 1,
          color: Colors.primary,
        ),
        SizedBox(height: 20,),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: Card(
                  color: Colors.cc_list_grey,
                  margin: const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                  child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          SizedBox(width: 5,),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 32.0,
                            height: 30.0,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "5",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.primary),
                          ),
                          Expanded(child: Container()),
                          const Text(
                            "Purple",
                            style: TextStyle(fontFamily: "Montserrat"),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            width: 45,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.cc_purpul,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            },
          ),
        ),
      ])),
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
                   Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(
                          "Challenge",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          " - Green",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.cc_green,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Text("My Coins",style: TextStyle(fontFamily: "Montserrat"),)),
                  SizedBox(height: 10,),
                  Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Image.asset(
                      "assets/images/coin.png",
                      width: 24.0,
                      height: 24.0,
                    ),
                      SizedBox(width: 4),
                      Text("data"),
                      SizedBox(width: 4),

                      Image.asset(
                        "assets/images/add.png",
                        width: 24.0,
                        height: 24.0,
                      ),
                    ]
                  ),
                  ),

                  

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
                          'Confirm',
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
