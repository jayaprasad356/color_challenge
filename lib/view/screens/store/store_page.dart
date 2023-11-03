import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/view/screens/store/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width, // Set width to the screen width
      height:
          MediaQuery.of(context).size.height, // Set height to the screen height
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primary_color,
            colors.secondary_color,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.only(top: 20, left: 20, right: 15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: size.height * .3,
          childAspectRatio: 1.0,
        ),
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.to(
                const ProductDetail(),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * .2,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
                const Text(
                  'product name',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'MontserratLight',
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  '₹ 123',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'MontserratBold',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
