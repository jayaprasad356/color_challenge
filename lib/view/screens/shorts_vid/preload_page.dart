import 'package:color_challenge/controller/pcc_controller.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/view/screens/shorts_vid/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PreloadPage extends StatelessWidget {
  const PreloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PCC());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary_color, colors.secondary_color],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: size.height * 0.04, vertical: size.width * 0.07),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                PreloadPageView.builder(
                  itemBuilder: (ctx, i) {
                    return Player(i: i);
                  },
                  onPageChanged: (i) async {
                    c.updateAPI(i);
                  },
                  preloadPagesCount: 1,
                  controller: PreloadPageController(initialPage: 0),
                  itemCount: c.videoURLs.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(1000),
                        gradient: const LinearGradient(
                          colors: [
                            colors.primary_color,
                            colors.secondary_color
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      margin: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID_no_one",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                       SizedBox(
                        height: 5,),
                          Text(
                            "abc123",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(
                    right: 15,
                    bottom: 15,
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () {
                              c.incrementCounter();
                            },
                            icon: const Icon(
                              Icons.favorite,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${c.counter}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
