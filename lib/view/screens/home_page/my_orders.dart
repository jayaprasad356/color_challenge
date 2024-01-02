import 'package:a1_ads/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.myOrderListData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontFamily: 'MontserratLight',
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/Group 18197.png',height: 10,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListView.builder(
          itemCount: homeController.ordersJson.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              height: size.height * 0.15,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFF8F8F8),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Container(
                      height: size.height * 0.12,
                      width: size.width * 0.3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFECEADD),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                          homeController.ordersJson[index].image),
                ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            homeController.ordersJson[index].status == '0' ? 'Pending' : 'Completed',
                            style: TextStyle(
                              color: homeController.ordersJson[index].status == '0' ? const Color(0xFFFF0000) : const Color(0xFF161C7E),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MontserratLight',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          homeController.ordersJson[index].name,
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratLight',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          homeController.ordersJson[index].originalPrice,
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratBold',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Delivery Time : ${homeController.ordersJson[index].deliveryDate}",
                          style: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratLight',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
