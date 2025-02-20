import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:my_first_app/tap_game_screen.dart';


class FocusSelectionScreen extends StatefulWidget {
  @override
  _FocusSelectionScreenState createState() => _FocusSelectionScreenState();
}

class _FocusSelectionScreenState extends State<FocusSelectionScreen> with TickerProviderStateMixin {
  late AnimationController _twinkleController;
  late Animation<double> _twinkleAnimation;

  @override
  void initState() {
    super.initState();
    _twinkleController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _twinkleAnimation = Tween<double>(begin: 0.1, end: 0.7).animate(_twinkleController);
  }

  @override
  void dispose() {
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _twinkleAnimation,
              builder: (context, child) {
                return AnimatedBackground(
                  behaviour: RandomParticleBehaviour(
                    options: ParticleOptions(
                      baseColor: Colors.white,
                      spawnOpacity: _twinkleAnimation.value,
                      opacityChangeRate: 0.25,
                      minOpacity: 0.1,
                      maxOpacity: 0.7,
                      particleCount: 100,
                      spawnMaxRadius: 3,
                      spawnMaxSpeed: 0.3,
                      spawnMinSpeed: 0.1,
                    ),
                  ),
                  vsync: this,
                  child: Container(),
                );
              },
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Choose Your Focus Activity",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildGlassButton(
                      icon: Icons.music_note,
                      label: "Listen to Music",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicScreen(),
                          ),
                        );
                      },
                    ),
                    _buildGlassButton(
                      icon: Icons.touch_app,
                      label: "Tap to Feel Better",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TapGameScreen(),
                          ),
                        );
                      },
                    ),

                    _buildGlassButton(
                      icon: Icons.bubble_chart,
                      label: "Guided Meditation",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageScreen(imagePath: 'assets/meditation.jpg'),
                          ),
                        );
                      },
                    ),
                    _buildGlassButton(
                      icon: Icons.self_improvement,
                      label: "Affirmations",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageScreen(imagePath: 'assets/affirmations.jpg'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        width: 150,
        height: 150,
        borderRadius: BorderRadius.circular(20),
        blur: 10,
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New Screen to Play Music
class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playMusic();
  }

  void _playMusic() async {
    await _audioPlayer.play(AssetSource('audio/calm_music.mp3'));
    setState(() {
      isPlaying = true;
    });
  }

  void _toggleMusic() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calm Music"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_note,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              "Playing: Calm Music",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _toggleMusic,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(isPlaying ? "Pause Music" : "Play Music"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Screen to Display Images
class ImageScreen extends StatelessWidget {
  final String imagePath;

  ImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Focus Image"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
