import 'package:flutter/material.dart';

class FocusScreen extends StatelessWidget {
  final String focusType;
  final IconData icon;
  final Widget content;
  final Widget nextScreen;

  FocusScreen({
    required this.focusType,
    required this.icon,
    required this.content,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Focus on',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              focusType,
              style: TextStyle(fontSize: 24, color: Colors.blueAccent),
            ),
            SizedBox(height: 20),
            content,
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextScreen),
                );
              },
              child: Text('Next'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Finish Session'),
            ),
          ],
        ),
      ),
    );
  }
}

class FocusOnTouch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusScreen(
      focusType: 'Touch',
      icon: Icons.touch_app,
      content: Icon(Icons.touch_app, size: 100, color: Colors.blueAccent),
      nextScreen: FocusOnSight(),
    );
  }
}

class FocusOnSight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusScreen(
      focusType: 'Sight',
      icon: Icons.remove_red_eye,
      content: Icon(Icons.remove_red_eye, size: 100, color: Colors.blueAccent),
      nextScreen: FocusOnSound(),
    );
  }
}

class FocusOnSound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusScreen(
      focusType: 'Sound',
      icon: Icons.hearing,
      content: Icon(Icons.hearing, size: 100, color: Colors.blueAccent),
      nextScreen: FocusOnBreathing(),
    );
  }
}

class FocusOnBreathing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusScreen(
      focusType: 'Breathing',
      icon: Icons.air,
      content: Icon(Icons.air, size: 100, color: Colors.blueAccent),
      nextScreen: FocusOnTouch(), // Loop back to the first screen
    );
  }
}
