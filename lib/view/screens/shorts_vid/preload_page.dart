import 'package:carousel_slider/carousel_slider.dart';
import 'package:color_challenge/controller/pcc_controller.dart';
import 'package:color_challenge/model/slider_data.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/index_path.dart';
import 'package:color_challenge/view/screens/shorts_vid/player.dart';
import 'package:color_challenge/view/screens/shorts_vid/shorts_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:like_button/like_button.dart';

class PreloadPage extends StatefulWidget {
  const PreloadPage({Key? key}) : super(key: key);

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  final PCC c = Get.find<PCC>();
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.imageListData();
    _handleRefresh();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {});
    // c.shortsVideoData();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    print("object");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final PCC c = Get.find<PCC>();
    // final c = Get.put(PCC());
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
            // padding: EdgeInsets.only(
            //     left: size.height * 0.04,
            //     right: size.height * 0.04,
            //     bottom: size.width * 0.07),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,),
                        // bottom: size.width * 0.07),
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        // Obx(
                        //   () => PreloadPageView.builder(
                        //     scrollDirection: Axis.vertical,
                        //     itemCount: c.videoURL.length,
                        //     physics: const BouncingScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //       return YoutubePlayerPage( youtubeUrl: c.videoURL[index],);
                        //     },
                        //   ),
                        // ),
                        RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: ListView.builder(
                              itemCount: c.imageURS.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, int index) {
                                return Posts(
                                  imageURL: c.imageURS[index],
                                  name: c.name[index],
                                  ID: c.ID[index],
                                  description: c.description[index],
                                  likeWidget:
                                      // LikeButton(
                                      //   size: 24,
                                      //   circleColor:
                                      //   CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                      //   bubblesColor: BubblesColor(
                                      //     dotPrimaryColor: Color(0xff33b5e5),
                                      //     dotSecondaryColor: Color(0xff0099cc),
                                      //   ),
                                      //   likeBuilder: (bool isLiked) {
                                      //     return Icon(
                                      //       Icons.home,
                                      //       color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                                      //       size: 24,
                                      //     );
                                      //   },
                                      //   likeCount: 665,
                                      //   countBuilder: (int count, bool isLiked, String text)? {
                                      //     var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                                      //     Widget result;
                                      //     if (count == 0) {
                                      //       result = Text(
                                      //         "love",
                                      //         style: TextStyle(color: color),
                                      //       );
                                      //     } else
                                      //     {result = Text(
                                      //     text,
                                      //     style: TextStyle(color: color),
                                      //     );}
                                      //     return result;
                                      //   }
                                      // ),
                                      Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          c.toggleLike();
                                          // c.incrementCounter();
                                          // c.shortsVideoData();
                                        },
                                        icon: Obx(
                                          () => Icon(
                                            c.isLiked.value
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 35,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        // Container(
                        //   alignment: Alignment.bottomRight,
                        //   margin: EdgeInsets.only(
                        //     right: size.width * 0.02,
                        //     bottom: size.height * 0.02,
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Expanded(child: Container()),
                        //       Column(
                        //         // crossAxisAlignment: CrossAxisAlignment.end,
                        //         children: [
                        //           Expanded(child: Container()),
                        //           IconButton(
                        //             onPressed: () {
                        //               c.incrementCounter();
                        //               // c.shortsVideoData();
                        //             },
                        //             icon: const Icon(
                        //               Icons.favorite,
                        //               size: 35,
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //           Obx(
                        //             () => Text(
                        //               "${c.counter}",
                        //               style: const TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 15,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
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

  handleLikePost() {}
}

class ShortsPlayer extends StatefulWidget {
  final String shortsUrl;
  const ShortsPlayer({Key? key, required this.shortsUrl}) : super(key: key);

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.shortsUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Scaffold(
          body: Container(height: size.height, child: player),
        );
      },
    );
  }
}

class YoutubePlayerPage extends StatefulWidget {
  final String youtubeUrl;

  const YoutubePlayerPage({Key? key, required this.youtubeUrl})
      : super(key: key);

  @override
  _YoutubePlayerPageState createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.youtubeUrl)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          // Set options after WebView is created
          _setWebViewOptions();
        },
      ),
    );
  }

  void _setWebViewOptions() async {
    if (_webViewController != null) {
      await _webViewController!.setOptions(
        options: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
          ),
        ),
      );
    }
  }
}

class Posts extends StatefulWidget {
  final String imageURL;
  final String name;
  final String description;
  final String ID;
  // final Function likeOnPress;
  final Widget likeWidget;
  const Posts({
    super.key,
    required this.imageURL,
    // required this.likeOnPress,
    required this.likeWidget,
    required this.name,
    required this.description,
    required this.ID,
  });

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    widget.imageURL;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  // borderRadius: BorderRadius.circular(10000)
                  shape: BoxShape.circle),
              padding: const EdgeInsets.all(5),
              child: const Icon(
                Icons.person,
                size: 40,
                color: Colors.black26,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      color: colors.white,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.ID,
                  style: const TextStyle(
                      color: colors.white,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(16)),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(widget.imageURL)),
              widget.likeWidget,
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    // child: IconButton(
                    //   onPressed: () {
                    //     widget.likeOnPress();
                    //     // c.incrementCounter();
                    //     // c.shortsVideoData();
                    //   },
                    //   icon: const Icon(
                    //     isLiked ? Icons.favorite : Icons.favorite_border,
                    //     size: 35,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.description,
            style: const TextStyle(
                color: colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
