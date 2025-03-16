import 'package:flutter/material.dart';
import 'Homepage.dart';

/* 
  Authored by: Matt Despuig
  Company: Quadr.io
  Project: Who?/Luh!
  Feature: [WL-002] Clue and Feedback System
  Description: A sample screen for the user text fields for guess inputs, and sample user interface for the clue and feedback system
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

  Map<String, dynamic> get animalOfTheDay {
    final String today = DateTime.now().toIso8601String().substring(0, 10);
    final int seed = int.parse(today.replaceAll('-', ''));
    return animals[seed % animals.length];
  }

  void checkGuess() {
    if (gameOver) return;
    String guess = _controller.text.toLowerCase().trim();
    _controller.clear();
    if (incorrectGuesses.contains(guess)) return;

    var guessedAnimal = animals.firstWhere((animal) => animal['name'] == guess, orElse: () => {});

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
            'class': guessedAnimal['class'] == animalOfTheDay['class'] ? Colors.green : Colors.red,
            'type': guessedAnimal['type'] == animalOfTheDay['type'] ? Colors.green : Colors.red,
            'diet': guessedAnimal['diet'] == animalOfTheDay['diet'] ? Colors.green : Colors.red,
            'weight': guessedAnimal['weight'] == animalOfTheDay['weight'] ? Colors.green : Colors.red,
            'height': guessedAnimal['height'] == animalOfTheDay['height'] ? Colors.green : Colors.red,
          }
        });

        if (guess == animalOfTheDay['name']) {
          gameOver = true;
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
        } else {
          incorrectGuesses.add(guess);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Who?/Luh!',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Vanilla',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            Text(
              "Today's theme: Domestic Beings",
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Text(
              "Guess it!",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
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
              'Attempts: $attemptCounter',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Name', 'Class', 'Type', 'Diet', 'Weight', 'Height']
                  .map((clue) => Expanded(
                        child: Center(
                          child: Text(
                            clue.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
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
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home_page()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "W/L",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.orange),
                textAlign: TextAlign.center,
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}
