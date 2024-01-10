import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/view/screens/home_page/address_fill.dart';
import 'package:a1_ads/view/screens/home_page/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String productId;
  final String description;
  const ProductDetails({super.key, required this.imageUrl, required this.name, required this.price, required this.productId, required this.description});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: size.height * 0.56,
                    width: double.infinity,child: Image.asset('assets/images/Ellipse 1.png',fit: BoxFit.fill,),),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 20.0,top: 20),
                        child: Image.asset('assets/images/Group 18197.png',height: 35,color: Colors.white,),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    SizedBox(
                      height: size.height * 0.4,
                      width: size.width * 0.8,child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),),
                    SizedBox(height: size.height * 0.02,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 13,
                          width: 13,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF16A26),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          height: 13,
                          width: 13,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        widget.name,
                        style: const TextStyle(
                          fontFamily: 'MontserratLight',
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(const MyOrders());
                        },
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
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Align(
                     alignment: Alignment.topLeft,
                     child: Text(
                       "₹ ${widget.price}",
                       style: const TextStyle(
                         fontFamily: 'MontserratBold',
                         color: Color(0xFF000000),
                         fontWeight: FontWeight.bold,
                         fontSize: 18,
                       ),
                     ),
                   ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'About',
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     Get.to( AddressFill(productId: widget.productId));
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     width: size.width * 0.6,
                  //     decoration: BoxDecoration(
                  //       color: const Color(0xFF161C7E),
                  //       borderRadius: BorderRadius.circular(16),
                  //     ),
                  //     alignment: Alignment.center,
                  //     child: const Text(
                  //       'Purchase Now',
                  //       style: TextStyle(
                  //         fontFamily: 'MontserratBold',
                  //         color: Color(0xFFFFFFFF),
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 18,
                  //       ),
                  //     ),
                  //   )
                  // ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
