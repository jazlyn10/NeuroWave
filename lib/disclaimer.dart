import 'package:flutter/material.dart';
import 'upload.dart'; // Import the upload.dart file

class DisclaimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set app bar background color to white
      ),
      body: Container(
        color: Colors.white, // Background color of the entire screen
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center items vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 350, // Adjust the height of the grey background
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white, // Set grey box background to white
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning,
                    size: 80.0,
                    color: Color(0xFF0F67FE), // Changing warning symbol color
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Disclaimer:',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'This app is intended for use by professional healthcare providers only. It should not be used for self-diagnosis or treatment without consultation with a qualified medical professional.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 290.0),
            Container(
              width: 360,
              height: 56,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the Upload screen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadDataPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xFF0F67FE), // Set button background color
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
