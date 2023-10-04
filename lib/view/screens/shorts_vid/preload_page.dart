import 'package:carousel_slider/carousel_slider.dart';
import 'package:color_challenge/controller/pcc_controller.dart';
import 'package:color_challenge/controller/utils.dart';
import 'package:color_challenge/model/slider_data.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:color_challenge/util/index_path.dart';
import 'package:color_challenge/view/screens/shorts_vid/player.dart';
import 'package:color_challenge/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
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
  bool isLiked = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
    // c.imageListData();
    _handleRefresh();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    });
    // c.shortsVideoData();
  }

  Future<void> _initializeData() async {
    prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(Constant.ID);
    debugPrint("userId : $userId");
    c.imageListData(userId!);
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    print("object");
    print("c.userLike: ${c.userLike}");

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
                      Get.to(const PostUpload());
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
                          'post image earn money',
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
                      right: 20,
                    ),
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
                        Obx(() => RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: ListView.builder(
                              itemCount: c.imageURS.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, int index) {
                                return Posts(
                                    imageURL: c.imageURS[index],
                                    name: c.name[index],
                                    ID: c.ID[index],
                                    caption: c.caption[index],
                                    isLiked: isLiked,
                                    likes: c.likes[index],
                                    onTapLike: () async {
                                      String? userId = await c.getUserId();
                                      String? postID = c.ID[index];
                                      debugPrint("userId : $userId");
                                      if (userId != null) {
                                        await c.likeAPI(userId, postID!);
                                      } else {
                                        debugPrint('User ID not available.');
                                      }
                                    },
                                  shareOnPress: (){
                                    shareTextOnWhatsApp(c.shareLink[index].toString());
                                  },
                                  apiValue: c.userLike[index],
                                    );
                              }),
                        ),)
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
void shareTextOnWhatsApp(String sharelink) async {
  try {
    await FlutterShare.share(
      title: 'Share via WhatsApp',
      text: sharelink + '\nGive a like to my post so i can earn money.',
      chooserTitle: 'Share via',
    );
  } catch (e) {
    print('Error sharing text on WhatsApp: $e');
  }
}

class ShortsPlayer extends StatefulWidget {
  final String shortsUrl;
  const ShortsPlayer({Key? key, required this.shortsUrl}) : super(key: key);

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
  late YoutubePlayerController _controller;
  bool isLiked = false;

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
  final String likes;
  final String caption;
  final String ID;
  final String apiValue;
  final Function shareOnPress;
  // final Function likeOnPress;
  // final Widget likeWidget;
  final bool isLiked;
  final VoidCallback onTapLike;
  const Posts({
    super.key,
    required this.imageURL,
    required this.shareOnPress,
    // required this.likeOnPress,
    // required this.likeWidget,
    required this.name,
    required this.likes,
    required this.caption,
    required this.ID,
    required this.isLiked,
    required this.onTapLike, required this.apiValue,
  });

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  // bool isLiked = false;
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
                  color: Colors.white,
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
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.imageURL,
                fit: BoxFit.fill,
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              // "widget.caption                                                                                                             w",
              widget.caption,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: Container()),
            LikeButton(
              id: widget.ID,
              isLiked: widget.isLiked,
              apiValue: widget.apiValue,
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 3),
              icon: const Icon(
                Icons.share,
                color: Colors.white,
                size: 35.0,
              ),
              onPressed: () => widget.shareOnPress(),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class LikeButton extends StatefulWidget {
  final String id;
  final String apiValue;

  bool isLiked; // ID to associate with the like button

  LikeButton({required this.id, required this.isLiked, required this.apiValue});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  // late bool isLiked;
  final PCC c = Get.find<PCC>();
  late SharedPreferences prefs;

  // void handleAsyncInit() async {
  //   prefs = await SharedPreferences.getInstance();
  //   c.likeAPI(prefs.getString(Constant.ID));
  //
  //   setState(() {
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(right: 3),
      icon: Icon(
        Icons.favorite,
        color: widget.apiValue == "0" ? Colors.white : Colors.red,
        size: 35.0,
      ),
      onPressed: () async {
        print('Like button pressed for item with ID: ${widget.id}');
        prefs = await SharedPreferences.getInstance();
        String? user_Id = prefs.getString(Constant.ID);
        debugPrint("userId : $user_Id");
        String? postID = widget.id;
        if (user_Id != null) {
          await c.likeAPI(user_Id, postID!);
        } else {
          debugPrint('User ID not available.');
        }
        setState(() {
          widget.isLiked = !widget.isLiked;
        });
        print("isLiked : ${widget.isLiked}");
        print('Like button pressed for item with ID: ${widget.id}');
      },
    );
  }
}
