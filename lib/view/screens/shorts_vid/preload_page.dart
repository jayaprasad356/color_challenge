import 'package:color_challenge/controller/pcc_controller.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/view/screens/shorts_vid/player.dart';
import 'package:color_challenge/view/screens/shorts_vid/shorts_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PreloadPage extends StatefulWidget {
  const PreloadPage({Key? key}) : super(key: key);

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  final PCC c = Get.find<PCC>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.shortsVideoData();
  }

  @override
  Widget build(BuildContext context) {
    // final PCC c = Get.find<PCC>();
    // final c = Get.put(PCC());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // body: Obx(
      //   () => PreloadPageView.builder(
      //     scrollDirection: Axis.vertical,
      //     itemCount: c.videoURL.length,
      //     itemBuilder: (context, index) {
      //       // YT Controller
      //       final _ytController = YoutubePlayerController(
      //         initialVideoId: YoutubePlayer.convertUrlToId(c.videoURL[index])!,
      //         flags: const YoutubePlayerFlags(
      //           autoPlay: false,
      //           enableCaption: true,
      //           captionLanguage: 'en',
      //         ),
      //       );
      //       bool _isPlaying = false;
      //       return Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 8.0),
      //         child: Stack(
      //           alignment: Alignment.bottomCenter,
      //           children: [
      //             // Youtube Player
      //             Container(
      //               height: 220.0,
      //               decoration: const BoxDecoration(
      //                 color: Color(0xfff5f5f5),
      //                 borderRadius: BorderRadius.all(Radius.circular(12)),
      //               ),
      //               child: ClipRRect(
      //                 borderRadius: const BorderRadius.all(Radius.circular(12)),
      //                 child: YoutubePlayer(
      //                   controller: _ytController
      //                     ..addListener(() {
      //                       if (_ytController.value.isPlaying) {
      //                         setState(() {
      //                           _isPlaying = true;
      //                         });
      //                       } else {
      //                         _isPlaying = false;
      //                       }
      //                     }),
      //                   showVideoProgressIndicator: true,
      //                   progressIndicatorColor: Colors.lightBlueAccent,
      //                   bottomActions: [
      //                     CurrentPosition(),
      //                     ProgressBar(isExpanded: true),
      //                     FullScreenButton(),
      //                   ],
      //                   onEnded: (YoutubeMetaData _md) {
      //                     ///---------------------------   ISSUE NO. 2
      //                     _ytController.reset();
      //                     // _ytController.seekTo(const Duration(seconds: 1));
      //                     // _ytController.pause();
      //                     _md.videoId;
      //                     print(_md.title);
      //                   },
      //                 ),
      //               ),
      //             ),
      //             _isPlaying
      //                 ? Container()
      //                 : Container(
      //                     width: double.infinity,
      //                     decoration: BoxDecoration(
      //                       color: Colors.white.withOpacity(0.9),
      //                       borderRadius: const BorderRadius.only(
      //                         bottomRight: Radius.circular(12),
      //                         bottomLeft: Radius.circular(12),
      //                       ),
      //                     ),
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Text(
      //                         ///--------------------------   ISSUE NO. 4
      //                         _ytController.metadata.title,
      //                         style: const TextStyle(
      //                           fontSize: 20.0,
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      // ),
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
            // padding: EdgeInsets.only(
            //     left: size.height * 0.04,
            //     right: size.height * 0.04,
            //     bottom: size.width * 0.07),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Container(
                  alignment: Alignment.topRight,
                    padding: EdgeInsets.only(
                        right: size.height * 0.02,),
                  child: MaterialButton(
                    onPressed: () async {
                      Get.to(const ShortsUpload());
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 40,
                      width: size.width * 0.5,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/btnbg.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Post video earn Money',
                          style: TextStyle(
                              color: colors.white,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   padding: const EdgeInsets.all(10),
                //   margin: const EdgeInsets.all(10),
                //   alignment: Alignment.topLeft,
                //   child: const Text(
                //     "Post your video Get views and get money",
                //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.height * 0.04,
                    right: size.height * 0.04,
                    bottom: size.width * 0.07),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Obx(
                      () => PreloadPageView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: c.videoURL.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          // YT Controller
                          final _ytController = YoutubePlayerController(
                            initialVideoId: YoutubePlayer.convertUrlToId(
                                c.videoURL[index])!,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                              enableCaption: true,
                              captionLanguage: 'en',
                            ),
                          );
                          bool _isPlaying = false;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 8.0),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                // Youtube Player
                                Container(
                                  height: size.height * 0.7,
                                  decoration: const BoxDecoration(
                                    color: Color(0xfff5f5f5),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: YoutubePlayer(
                                      controller: _ytController
                                        ..addListener(() {
                                          if (_ytController
                                              .value.isPlaying) {
                                            setState(() {
                                              _isPlaying = true;
                                            });
                                          } else {
                                            _isPlaying = false;
                                          }
                                        }),
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor:
                                          Colors.lightBlueAccent,
                                      bottomActions: [
                                        CurrentPosition(),
                                        ProgressBar(isExpanded: true),
                                        FullScreenButton(),
                                      ],
                                      onEnded: (YoutubeMetaData _md) {
                                        _ytController.reset();
                                        // _ytController.seekTo(const Duration(seconds: 1));
                                        // _ytController.pause();
                                        _md.videoId;
                                        print(_md.title);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      margin:  EdgeInsets.only(
                        right: size.width * 0.02,
                        bottom: size.height * 0.02,
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
                                  // c.shortsVideoData();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
