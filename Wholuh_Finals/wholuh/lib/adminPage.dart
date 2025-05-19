import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wholuh/login.dart';

/*
  Authored by: Matt Despuig
  Company: Quadr.io
  Project: Who?/Luh!
  Feature: [WL-005]: Admin Page
  Description: A user interface for the Admin Page to access the Time-based content selection page.
*/

void main() {
  runApp(MaterialApp(
    home: adminPage(),
  ));
}

class adminPage extends StatefulWidget {
  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends State<adminPage> {
  String selectedTheme = 'Choose-a-theme';
  String vanillaEasyAnimal = 'Choose-an-animal';
  String vanillaAdvancedAnimal = 'Choose-an-animal';
  String vanillaExpertAnimal = 'Choose-an-animal';

  final Map<String, List<String>> themeAnimals = {
    'Choose-a-theme': ['Choose-an-animal'],
    'Domestic beings': [
      'Choose-an-animal',
      'Dog',
      'Cat',
      'Horse',
      'Cattle',
      'Sheep',
      'Goat',
      'Chicken',
      'Pig',
      'Rabbit',
      'Duck',
    ],
    'Primordial beasts': ['Choose-an-animal', 'Tyrannosaurus Rex', 'Triceratops', 'Pterodactyl', 'Velociraptor', 'Stegosaurus'],
    'Jungle kingdom': ['Choose-an-animal', 'Lion', 'Tiger', 'Rhinoceros', 'Wolf'],
    'Mythical creatures': ['Choose-an-animal', 'Dragon', 'Minotaur', 'Phoenix', 'Griffin', 'Unicorn'],
    'Ocean dwellers': ['Choose-an-animal', 'Crab', 'Shark', 'Whale', 'Clownfish', 'Octopus'],
  };

  Future<void> saveSelection() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('weeklyTheme', selectedTheme);
    await prefs.setString('vanillaEasyAnimal', vanillaEasyAnimal);
    await prefs.setString('vanillaAdvancedAnimal', vanillaAdvancedAnimal);
    await prefs.setString('vanillaExpertAnimal', vanillaExpertAnimal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin',
          style: TextStyle(
            fontStyle: FontStyle.italic, 
            color: Colors.orange, 
            fontFamily: 'Montserrat'
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.orange),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Who?/Luh!",
              style: TextStyle(
                fontSize: 48,
                color: Colors.orange,
                fontFamily: 'TitanOne',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Set Answers",
              style: TextStyle(
                fontSize: 24,
                color: Colors.orange,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Weekly Theme",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              value: selectedTheme,
              items: themeAnimals.keys.map((theme) {
                return DropdownMenuItem(
                  value: theme,
                  child: Text(theme),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTheme = value!;
                  vanillaEasyAnimal = 'Choose-an-animal';
                  vanillaAdvancedAnimal = 'Choose-an-animal';
                  vanillaExpertAnimal = 'Choose-an-animal';
                });
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Daily Animal - Vanilla Easy",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              value: vanillaEasyAnimal,
              items: selectedTheme != 'Choose-a-theme'
                  ? themeAnimals[selectedTheme]!.map((animal) {
                      return DropdownMenuItem(
                        value: animal,
                        child: Text(animal),
                      );
                    }).toList()
                  : null,
              onChanged: selectedTheme != 'Choose-a-theme'
                  ? (value) {
                      setState(() {
                        vanillaEasyAnimal = value!;
                      });
                    }
                  : null,
              disabledHint: Text("Select a theme first"),
              menuMaxHeight: 200,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Daily Animal - Vanilla Advanced",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              value: vanillaAdvancedAnimal,
              items: selectedTheme != 'Choose-a-theme'
                  ? themeAnimals[selectedTheme]!.map((animal) {
                      return DropdownMenuItem(
                        value: animal,
                        child: Text(animal),
                      );
                    }).toList()
                  : null,
              onChanged: selectedTheme != 'Choose-a-theme'
                  ? (value) {
                      setState(() {
                        vanillaAdvancedAnimal = value!;
                      });
                    }
                  : null,
              disabledHint: Text("Select a theme first"),
              menuMaxHeight: 200,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Daily Animal - Vanilla Expert",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              value: vanillaExpertAnimal,
              items: selectedTheme != 'Choose-a-theme'
                  ? themeAnimals[selectedTheme]!.map((animal) {
                      return DropdownMenuItem(
                        value: animal,
                        child: Text(animal),
                      );
                    }).toList()
                  : null,
              onChanged: selectedTheme != 'Choose-a-theme'
                  ? (value) {
                      setState(() {
                        vanillaExpertAnimal = value!;
                      });
                    }
                  : null,
              disabledHint: Text("Select a theme first"),
              menuMaxHeight: 200,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedTheme == 'Choose-a-theme' ||
                      vanillaEasyAnimal == 'Choose-an-animal' ||
                      vanillaAdvancedAnimal == 'Choose-an-animal' ||
                      vanillaExpertAnimal == 'Choose-an-animal') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select all fields correctly')),
                    );
                  } else {
                    await saveSelection();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selections saved successfully!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text("Confirm", 
                  style: TextStyle(
                    color: Colors.white, 
                    fontFamily: 'Montserrat'
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}