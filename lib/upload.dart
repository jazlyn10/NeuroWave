import 'package:flutter/material.dart';
import 'package:neuro/spiral.dart'; // Import your spiral.dart file
import 'package:neuro/wave.dart';

class UploadDataPage extends StatelessWidget {
  const UploadDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF0F67FE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 180,
                  child: Image.asset(
                    'lib/images/top.png', // Replace 'assets/top.png' with the actual path to your image
                    width: 50,
                    height: 50,
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Upload Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 27),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TaskCard(
                  taskName: 'Draw Spiral',
                  statusIcon: Icons.chevron_right,
                  taskIcon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpiralDrawingScreen()),
                    );
                  },
                ),
                SizedBox(height: 10),
                TaskCard(
                  taskName: 'Draw Wave',
                  statusIcon: Icons.chevron_right,
                  taskIcon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WaveDrawingScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: ElevatedButton(
              onPressed: () {
                // Action when Show Results button is pressed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F67FE),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                    child: Text(
                      'Show Results',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String taskName;
  final IconData statusIcon;
  final IconData taskIcon;
  final VoidCallback? onTap;

  const TaskCard({
    Key? key,
    required this.taskName,
    required this.statusIcon,
    required this.taskIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Colors.white, // Set background color to white
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                taskIcon,
                size: 24,
                color: Colors.black, // Set icon color to black
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(fontSize: 16, color: Colors.black), // Set text color to black
                ),
              ),
              Icon(
                statusIcon,
                size: 24,
                color: Colors.black, // Set icon color to black
              ),
            ],
          ),
        ),
      ),
    );
  }
}
