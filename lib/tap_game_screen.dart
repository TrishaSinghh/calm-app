import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class TapGameScreen extends StatefulWidget {
  @override
  _TapGameScreenState createState() => _TapGameScreenState();
}

class _TapGameScreenState extends State<TapGameScreen> {
  int score = 0;
  bool isGameActive = false;
  String message = "Tap the bubbles!";
  late Timer _timer;
  List<Widget> bubbles = [];
  Random random = Random();

  void startGame() {
    setState(() {
      score = 0;
      isGameActive = true;
      message = "Tap the bubbles fast!";
      bubbles.clear();
    });

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (timer.tick >= 20) {
        timer.cancel();
        setState(() {
          isGameActive = false;
          message = "Game Over! \nScore: $score 🎉";
        });
      } else {
        _addBubble();
      }
    });
  }

  void _addBubble() {
    double size = random.nextDouble() * 40 + 40;
    double left = random.nextDouble() * (MediaQuery.of(context).size.width - size);
    double top = random.nextDouble() * (MediaQuery.of(context).size.height - size - 100);

    setState(() {
      bubbles.add(Positioned(
        left: left,
        top: top,
        child: GestureDetector(
          onTap: () {
            setState(() {
              score++;
              bubbles.removeLast();
            });
          },
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: isGameActive ? 1.0 : 0.0,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color.fromARGB(122, 239, 179, 198), const Color.fromARGB(127, 250, 250, 250)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 238, 237, 237).withOpacity(0.6),
                    blurRadius: 12,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D324D),
      appBar: AppBar(
        title: Text(
          "Bubbly Tap Game :)",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(91, 0, 0, 0),
        elevation: 5,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D324D), Color(0xFF7F5A83)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 246, 246, 246),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: startGame,
                  child: Text("Start Game"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(71, 202, 89, 145),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Score: $score",
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 246, 246, 247),
                  ),
                ),
              ],
            ),
          ),
          Stack(children: bubbles),
        ],
      ),
    );
  }
}
