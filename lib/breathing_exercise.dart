import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'focus_selection_screen.dart'; // Import the next screen

class BreathingExercise extends StatefulWidget {
  @override
  _BreathingExerciseState createState() => _BreathingExerciseState();
}

class _BreathingExerciseState extends State<BreathingExercise>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late VideoPlayerController _videoController;
  String breatheText = "INHALE";

  @override
  void initState() {
    super.initState();

    // Video Background
    _videoController = VideoPlayerController.asset("assets/videos/background1.mp4")
      ..initialize().then((_) {
        setState(() {}); // Refresh UI when video is loaded
      })
      ..setLooping(true)
      ..setVolume(0)
      ..play();

    // Breathing Animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Full breath cycle (Inhale + Exhale)
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          setState(() => breatheText = "INHALE");
        } else if (status == AnimationStatus.reverse) {
          setState(() => breatheText = "EXHALE");
        }
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark Theme
      body: Stack(
        children: [
          // Video Background
          Positioned.fill(
            child: _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  )
                : Container(color: Colors.black),
          ),

          // Semi-transparent overlay for better visibility
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          // Inhale-Exhale Text & Animated Circle
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  breatheText,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFD740), // Blue theme for text
                  ),
                ),
                SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      width: 150 * _animation.value,
                      height: 150 * _animation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // Black Circle
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFD740).withOpacity(0.6), // ✨ Golden Glow
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Next Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FocusSelectionScreen()),
                  );
                },
                child: Text("Next"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
