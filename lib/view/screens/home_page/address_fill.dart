import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/view/screens/home_page/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressFill extends StatefulWidget {
  final String productId;
  const AddressFill({super.key, required this.productId});

  @override
  State<AddressFill> createState() => _AddressFillState();
}

class _AddressFillState extends State<AddressFill> {
  final HomeController homeController = Get.find<HomeController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinCondeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Address',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Get.to(const MyOrders()),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icon/icons8_buy.png',
                        height: 30,
                      ),
                      const Text(
                        'My Order',
                        style: TextStyle(
                          fontFamily: 'MontserratLight',
                          color: Color(0xFF67666D),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(
                    fontFamily: 'MontserratBold',
                    color: Colors.black54,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Address',
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: addressController,
                maxLines: 5,
                minLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(
                    fontFamily: 'MontserratBold',
                    color: Colors.black54,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Mobile',
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(
                    fontFamily: 'MontserratBold',
                    color: Colors.black54,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Pin Code',
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: pinCondeController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(
                    fontFamily: 'MontserratBold',
                    color: Colors.black54,
                    fontSize: 14),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              InkWell(
                onTap: () {
                  homeController.placeOrder(widget.productId, addressController.text, pinCondeController.text);
                },
                  child: Container(
                    height: 50,
                    width: size.width * 0.6,
                    decoration: BoxDecoration(
                      color: const Color(0xFF161C7E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Order',
                      style: TextStyle(
                        fontFamily: 'MontserratBold',
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
