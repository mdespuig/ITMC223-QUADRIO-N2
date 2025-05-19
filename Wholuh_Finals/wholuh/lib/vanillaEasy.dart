import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wholuh/vanillaDifficulty.dart';

/* 
  Authored by: Matt Despuig
  Company: Quadr.io
  Project: Who?/Luh!
  Feature: [WL-004] Difficulty Levels, [WL-002] Clue and Feedback, [WL-014] Points System
  Description: A sample user interface for choosing a difficulty. As a player, 
  I will be able to track the progress of my answers through clues and feedbacks.
  As a player, I want to know how many points I have got while playing the game.
 */

void main() {
  runApp(VanillaEasy());
}

class VanillaEasy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanilla Easy',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Vanilla_ez(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Vanilla_ez extends StatefulWidget {
  @override
  ezVanilla createState() => ezVanilla();
}

class ezVanilla extends State<Vanilla_ez> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> attempts = [];
  Set<String> incorrectGuesses = {};
  bool gameOver = false;
  int attemptCounter = 0;

  String selectedTheme = '';
  String selectedAnimal = '';

  final List<Map<String, dynamic>> animals = [
    {'name': 'dog', 'class': 'Mammal', 'type': 'Land', 'diet': 'Omnivore', 'weight': '10-35kg', 'height': '10-30in'},
    {'name': 'cat', 'class': 'Mammal', 'type': 'Land', 'diet': 'Carnivore', 'weight': '3-7kg', 'height': '9-12in'},
    {'name': 'horse', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '400-600kg', 'height': '55-70in'},
    {'name': 'cattle', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '500-1000kg', 'height': '48-62in'},
    {'name': 'sheep', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '45-160kg', 'height': '24-40in'},
    {'name': 'goat', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '20-140kg', 'height': '17-42in'},
    {'name': 'chicken', 'class': 'Bird', 'type': 'Land', 'diet': 'Omnivore', 'weight': '1-5kg', 'height': '10-27in'},
    {'name': 'pig', 'class': 'Mammal', 'type': 'Land', 'diet': 'Omnivore', 'weight': '50-350kg', 'height': '20-40in'},
    {'name': 'rabbit', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '1-2kg', 'height': '8-16in'},
    {'name': 'duck', 'class': 'Bird', 'type': 'Land/Water', 'diet': 'Omnivore', 'weight': '1-5kg', 'height': '12-24in'},
    {'name': 'turkey', 'class': 'Bird', 'type': 'Land', 'diet': 'Omnivore', 'weight': '4-15kg', 'height': '30-45in'},
    {'name': 'donkey', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '180-570kg', 'height': '36-60in'},
    {'name': 'camel', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '300-1000kg', 'height': '72-84in'},
    {'name': 'alpaca', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '50-85kg', 'height': '32-39in'},
    {'name': 'llama', 'class': 'Mammal', 'type': 'Land', 'diet': 'Herbivore', 'weight': '130-200kg', 'height': '42-46in'},
    {'name': 'ferret', 'class': 'Mammal', 'type': 'Land', 'diet': 'Carnivore', 'weight': '0.7-2kg', 'height': '8-18in'},
    {'name': 'goose', 'class': 'Bird', 'type': 'Land/Water', 'diet': 'Herbivore', 'weight': '3-6kg', 'height': '30-43in'},
    {'name': 'goldfish', 'class': 'Fish', 'type': 'Water', 'diet': 'Omnivore', 'weight': '0.1-2kg', 'height': '2-12in'},
    {'name': 'parrot', 'class': 'Bird', 'type': 'Land', 'diet': 'Herbivore', 'weight': '0.1-1.5kg', 'height': '5-40in'},
    {'name': 'pigeon', 'class': 'Bird', 'type': 'Land', 'diet': 'Herbivore', 'weight': '0.2-0.5kg', 'height': '10-14in'}
  ];

  Future<void> loadSelection() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTheme = prefs.getString('weeklyTheme') ?? 'No theme selected';
      selectedAnimal = prefs.getString('vanillaEasyAnimal') ?? 'No animal selected';
    });
  }

  @override
  void initState() {
    super.initState();
    loadSelection();
  }

  void checkGuess() {
    if (gameOver) return;
    String guess = _controller.text.toLowerCase().trim();
    _controller.clear();
    if (incorrectGuesses.contains(guess)) return;

    var guessedAnimal = animals.firstWhere((animal) => animal['name'].toLowerCase() == guess, orElse: () => {});

    if (guessedAnimal.isNotEmpty) {
      setState(() {
        attemptCounter++;
        attempts.insert(0, {
          'name': guessedAnimal['name'],
          'class': guessedAnimal['class'],
          'type': guessedAnimal['type'],
          'diet': guessedAnimal['diet'],
          'weight': guessedAnimal['weight'],
          'height': guessedAnimal['height'],
          'colors': {
            'class': guessedAnimal['class'] == animals.firstWhere((animal) => animal['name'].toLowerCase() == selectedAnimal.toLowerCase())['class'] ? Colors.green : Colors.red,
            'type': _getTypeColor(guessedAnimal['type']),
            'diet': _getDietColor(guessedAnimal['diet']),
            'weight': guessedAnimal['weight'] == animals.firstWhere((animal) => animal['name'].toLowerCase() == selectedAnimal.toLowerCase())['weight'] ? Colors.green : Colors.red,
            'height': guessedAnimal['height'] == animals.firstWhere((animal) => animal['name'].toLowerCase() == selectedAnimal.toLowerCase())['height'] ? Colors.green : Colors.red,
          }
        });

        if (guess == selectedAnimal.toLowerCase()) {
          gameOver = true;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('You Got It!', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
              content: Text(
                'Congratulations! You guessed the animal correctly!\nAttempts: ${attempts.length}\nPoints: ${100 - (attempts.length - 1) * 10}',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK', style: TextStyle(fontFamily: 'Montserrat')),
                ),
              ],
            ),
          );
        } else {
          incorrectGuesses.add(guess);
        }
      });
    }
  }

  Color _getTypeColor(String guessedType) {
    final correctType = animals.firstWhere((animal) => animal['name'].toLowerCase() == selectedAnimal.toLowerCase())['type'];

    if (guessedType == correctType) {
      return Colors.green;
    }

    if (correctType == 'Land/Water') {
      return (guessedType == 'Land' || guessedType == 'Water') ? Colors.orange : Colors.red;
    } else if (correctType == 'Land') {
      return guessedType == 'Land/Water' ? Colors.orange : Colors.red;
    } else if (correctType == 'Water') {
      return guessedType == 'Land/Water' ? Colors.orange : Colors.red;
    }

    return Colors.red;
  }

  Color _getDietColor(String guessedDiet) {
    final correctDiet = animals.firstWhere((animal) => animal['name'].toLowerCase() == selectedAnimal.toLowerCase())['diet'];

    if (guessedDiet == correctDiet) {
      return Colors.green;
    }

    if (correctDiet == 'Omnivore') {
      return (guessedDiet == 'Herbivore' || guessedDiet == 'Carnivore') ? Colors.orange : Colors.red;
    } else if (correctDiet == 'Herbivore') {
      return guessedDiet == 'Omnivore' ? Colors.orange : Colors.red;
    } else if (correctDiet == 'Carnivore') {
      return guessedDiet == 'Omnivore' ? Colors.orange : Colors.red;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vanilla: Easy',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange, fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => vanillaDifficulty()),
            );
          },
        ),
      ),
      body: DefaultTextStyle(
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 16,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Today's Theme: $selectedTheme",
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.orange, fontFamily: 'Montserrat'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text(
                "Guess it!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange, fontFamily: 'Montserrat'),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Guess the animal...'),
                enabled: !gameOver,
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: checkGuess,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: Text('Verify', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat')),
              ),
              SizedBox(height: 10),
              Text(
                'Attempts: $attemptCounter',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.orange, fontFamily: 'Montserrat'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Name', 'Class', 'Type', 'Diet', 'Weight', 'Height']
                    .map((clue) => Expanded(
                          child: Center(
                            child: Text(
                              clue.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 12, fontFamily: 'Montserrat'),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              Divider(color: Colors.black),
              Expanded(
                child: ListView.builder(
                  itemCount: attempts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  attempts[index]['name'].toUpperCase(),
                                  style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                          ...['class', 'type', 'diet', 'weight', 'height'].map((clue) {
                            return Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: attempts[index]['colors'][clue],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    attempts[index][clue],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}