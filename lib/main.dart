import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Cricket',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CricketScreen(),
    );
  }
}

class CricketScreen extends StatefulWidget {
  const CricketScreen({super.key});

  @override
  State<CricketScreen> createState() => _CricketScreenState();
}

class _CricketScreenState extends State<CricketScreen> {
  int totalRuns = 0;
  int remainingBalls = 6;
  String currentStatus = '';

  final List<int> possibleRuns = [0, 1, 2, 3, 4, 6];
  final Random random = Random();

  void bat() {
    if (remainingBalls > 0) {
      setState(() {
        // Generate a random score from the list
        int runsScored = possibleRuns[random.nextInt(possibleRuns.length)];

        totalRuns += runsScored;
        remainingBalls -= 1;

        // Update the status text
        if (runsScored == 0) {
          currentStatus = 'No Runs';
        } else if (runsScored == 1) {
          currentStatus = '1 Run';
        } else {
          currentStatus = '$runsScored Runs';
        }
      });
    }
  }

  void restart() {
    setState(() {
      totalRuns = 0;
      remainingBalls = 6;
      currentStatus = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      appBar: AppBar(
        title: const Text(
          'Mini Cricket',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Images Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImagePlaceholder(
                  Icons.sports_cricket,
                  Colors.brown,
                ), // Bat placeholder
                const SizedBox(width: 20),
                _buildImagePlaceholder(
                  Icons.sports_baseball,
                  Colors.red,
                ), // Ball placeholder
              ],
            ),
            const SizedBox(height: 30),

            // Runs and Balls Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 80,
                  child: Center(
                    child: Text(
                      'Runs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 80,
                  child: Center(
                    child: Text(
                      'Balls',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Runs and Balls Values
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: Center(
                    child: Text(
                      '$totalRuns',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 80,
                  child: Center(
                    child: Text(
                      '$remainingBalls',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Status Text (e.g., "3 Runs", "No Runs")
            if (currentStatus.isNotEmpty)
              Text(
                currentStatus,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 20),

            // Action Button (Bat or Restart)
            ElevatedButton(
              onPressed: remainingBalls > 0 ? bat : restart,
              style: ElevatedButton.styleFrom(
                backgroundColor: remainingBalls > 0
                    ? Colors.blue[900]
                    : Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
              ),
              child: Text(
                remainingBalls > 0 ? 'Bat' : 'Restart',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to simulate the white square images in your UI
  Widget _buildImagePlaceholder(IconData icon, Color iconColor) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.white,
      child: Center(child: Icon(icon, size: 60, color: iconColor)),
    );
  }
}
