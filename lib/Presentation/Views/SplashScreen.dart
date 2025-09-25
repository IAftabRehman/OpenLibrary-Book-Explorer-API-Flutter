import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/splashScreen.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(false);

        Future.delayed(Duration(seconds: 5), () {
          Navigator.pushReplacementNamed(context, AppRoutes.onBoarding);
        });
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
