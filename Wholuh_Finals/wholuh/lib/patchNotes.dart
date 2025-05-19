import 'package:flutter/material.dart';
import 'homepage.dart';

class PatchNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfef7ff),
      appBar: AppBar(
        backgroundColor: Color(0xFFfef7ff),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => home_page()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Who?/Luh!",
              style: TextStyle(
                fontSize: 48,
                color: Colors.orange,
                fontFamily: 'TitanOne',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "PATCH NOTES",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.2,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                child: SingleChildScrollView(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update v1.0.0",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "-Weekly Theme Update: Domestic Beings\n"
                          "-Added new details for animal clues\n"
                          "-Added new icons for animal names\n"
                          "-Guest sign-in has been disabled\n"
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}