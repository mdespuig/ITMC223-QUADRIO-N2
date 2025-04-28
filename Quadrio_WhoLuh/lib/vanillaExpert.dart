import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wholuh/vanillaDifficulty.dart';
import 'dart:async';

/* 
  Authored by: Matt Despuig
  Company: Quadr.io
  Project: Who?/Luh!
  Feature: [WL-004] Difficulty Levels
  Description: A sample user interface for choosing a difficulty
 */

void main() {
  runApp(vanillaExpert());
}

class vanillaExpert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanilla: Expert',
      theme: ThemeData(primarySwatch: Colors.green),
      home: VanillaExpertGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VanillaExpertGame extends StatefulWidget {
  @override
  VanillaExpertGameState createState() => VanillaExpertGameState();
}

class VanillaExpertGameState extends State<VanillaExpertGame> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> attempts = [];
  Set<String> incorrectGuesses = {};
  bool gameOver = false;
  int attemptCounter = 0;
  final int maxAttempts = 10;
  late Timer _timer;
  int remainingTime = 60;

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
      selectedAnimal = prefs.getString('vanillaExpertAnimal') ?? 'No animal selected';
    });
  }

  @override
  void initState() {
    super.initState();
    loadSelection();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          gameOver = true;
          _timer.cancel();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Time Up!'),
              content: Text('You ran out of time! The correct answer was $selectedAnimal.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    });
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
          'diet': guessedAnimal['diet'],
          'weight': guessedAnimal['weight'],
          'height': guessedAnimal['height'],
          'colors': {
            'diet': _getDietColor(guessedAnimal['diet']),
            'weight': guessedAnimal['weight'] == animals.firstWhere((animal) => animal['name'].toLowerCase() == selectedAnimal.toLowerCase())['weight'] ? Colors.green : Colors.red,
            'height': guessedAnimal['height'] == animals.firstWhere((animal) => animal['name'].toLowerCase() == selectedAnimal.toLowerCase())['height'] ? Colors.green : Colors.red,
          }
        });

        if (guess == selectedAnimal.toLowerCase()) {
          gameOver = true;
          _timer.cancel();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('You Got It!'),
              content: Text(
                'Congratulations! You guessed the animal correctly!\nAttempts: ${attempts.length}\nPoints: ${100 - (attempts.length - 1) * 10}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else if (attemptCounter >= maxAttempts) {
          gameOver = true;
          _timer.cancel();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Game Over'),
              content: Text('You have used all your attempts! The correct answer was $selectedAnimal.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
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
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vanilla: Expert',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Today's Theme: $selectedTheme",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Time Left: ${remainingTime}s",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Guess it!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Guess the animal...'),
              enabled: !gameOver,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: checkGuess,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Text('Verify', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            Text(
              'Guesses Remaining: ${maxAttempts - attemptCounter}',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Name', 'Diet', 'Weight', 'Height']
                  .map((clue) => Expanded(
                        child: Center(
                          child: Text(
                            clue.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 12),
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
                                style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        ...['diet', 'weight', 'height'].map((clue) {
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
                                  style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
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
    );
  }
}