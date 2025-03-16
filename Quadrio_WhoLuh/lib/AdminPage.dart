import 'package:flutter/material.dart';

/* 
  Authored by: Matt Despuig
  Company: Quadr.io
  Project: Who?/Luh!
  Feature: [WL-005] Admin Page
  Description: A user interface for the Admin Page to access the Time-based content selection page.
 */

void main() {
  runApp(Admin());
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String selectedTheme = 'Choose-a-theme';
  String selectedAnimal = 'Choose-an-animal';

  final Map<String, List<String>> themeAnimals = {
    'Choose-a-theme': ['Choose-an-animal'],
    'Domestic beings': ['Choose-an-animal', 'Dog', 'Cat', 'Horse', 'Cattle', 'Goat'],
    'Primordial beasts': ['Choose-an-animal', 'Tyrannosaurus Rex', 'Triceratops', 'Pterodactyl', 'Velociraptor', 'Stegosaurus'],
    'Jungle kingdom': ['Choose-an-animal', 'Lion', 'Tiger', 'Rhinoceros', 'Wolf'],
    'Mythical creatures': ['Choose-an-animal', 'Dragon', 'Minotaur', 'Phoenix', 'Griffin', 'Unicorn'],
    'Ocean dwellers': ['Choose-an-animal', 'Crab', 'Shark', 'Whale', 'Clownfish', 'Octopus'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.orange),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Who?/Luh!",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Set Answers",
              style: TextStyle(fontSize: 24, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Weekly Theme",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
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
                  selectedAnimal = 'Choose-an-animal';
                });
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Daily Animal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              value: selectedAnimal,
              items: themeAnimals[selectedTheme]!.map((animal) {
                return DropdownMenuItem(
                  value: animal,
                  child: Text(animal),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAnimal = value!;
                });
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedTheme == 'Choose-a-theme' || selectedAnimal == 'Choose-an-animal') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select both fields correctly')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Saved: $selectedTheme - $selectedAnimal')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text("Confirm", style: TextStyle(color: Colors.white)),
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                "W/L",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}