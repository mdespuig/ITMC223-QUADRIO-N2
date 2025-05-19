import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wholuh/factsDifficulty.dart';
import 'package:wholuh/database.dart';

void main() {
  runApp(factsEasy());
}

class factsEasy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fact Easy',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: FactsEasyScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FactsEasyScreen extends StatefulWidget {
  @override
  _FactsEasyScreenState createState() => _FactsEasyScreenState();
}

class _FactsEasyScreenState extends State<FactsEasyScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> animals = [
    {'name': 'dog', 'fact': "Man's best friend"},
    {'name': 'cat', 'fact': "Worshipped as gods in the ancient times"},
    {'name': 'horse', 'fact': "Essential for transportation"},
    {'name': 'cattle', 'fact': "Produces meat and dairy"},
    {'name': 'sheep', 'fact': "Produces wool"},
    {'name': 'goat', 'fact': "Can climb steep cliffs, sometimes trees"},
    {'name': 'chicken', 'fact': "Most common domesticated bird"},
    {'name': 'pig', 'fact': "Uses mud to cool off"},
    {'name': 'rabbit', 'fact': "They can live in burrows"},
    {'name': 'duck', 'fact': "Known for their webbed feet and waddling walk"},
  ];

  final Map<String, String> animalIcons = {
    'dog': '🐶',
    'cat': '🐱',
    'horse': '🐴',
    'cattle': '🐮',
    'sheep': '🐑',
    'goat': '🐐',
    'chicken': '🐔',
    'pig': '🐷',
    'rabbit': '🐰',
    'duck': '🦆',
  };

  late String selectedAnimal;
  late String selectedFact;
  int attempts = 0;
  int points = 100;
  List<Map<String, dynamic>> answerHistory = [];
  List<bool> boxEnabled = [false, false, false];

  @override
  void initState() {
    super.initState();
    _pickRandomAnimal();
    _shuffleAnimalList();
  }

  void _shuffleAnimalList() {
    animals.shuffle(Random());
  }

  void _pickRandomAnimal() {
    final animal = (animals..shuffle()).first;
    selectedAnimal = animal['name']!;
    selectedFact = animal['fact']!;
  }

  void _updateBoxEnabled() {
    setState(() {
      boxEnabled[0] = attempts >= 3;
      boxEnabled[1] = attempts >= 6;
      boxEnabled[2] = attempts >= 9;
    });
  }

  void _onGuess() async {
    String guess = _controller.text.trim().toLowerCase();
    if (guess.isEmpty) return;
    bool isCorrect = guess == selectedAnimal;
    bool isInList = animals.any((a) => a['name'] == guess);
    setState(() {
      attempts++;
      if (isInList) {
        answerHistory.insert(0, {
          'guess': guess,
          'isCorrect': isCorrect,
          'icon': animalIcons[guess] ?? '❓',
        });
      }
      points = (100 - (attempts - 1) * 10).clamp(0, 100);
      _updateBoxEnabled();
    });

    if (isCorrect) {
      await _saveUserPoints(points);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'You Got It!',
            style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Congratulations! You guessed the animal correctly!\n'
            'Attempts: $attempts\n'
            'Points: $points\n'
            'Your points have been saved!',
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
    }
    _controller.clear();
  }

  Future<void> _saveUserPoints(int points) async {
    final dbHelper = DatabaseHelper.instance;
    final currentUser = await dbHelper.getCurrentUser();
    if (currentUser != null) {
      await dbHelper.updateUserPoints(currentUser['username'], points);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> animalOrder = [selectedAnimal];
    final List<String> otherAnimals = animals
        .where((a) => a['name'] != selectedAnimal)
        .map((a) => a['name']!)
        .toList();
    otherAnimals.shuffle(Random());
    animalOrder.addAll(otherAnimals.take(2));
    animalOrder.shuffle(Random());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.orange),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => factsDifficulty()),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Fact: Easy',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: Colors.orange,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: DefaultTextStyle(
          style: TextStyle(fontFamily: 'Montserrat', color: Colors.black, fontSize: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Text(
                '"$selectedFact"',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18),
              SizedBox(height: 4),
              Text(
                'Guess it!',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _onGuess,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(12),
                    ),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  reverse: false,
                  itemCount: answerHistory.length,
                  itemBuilder: (context, index) {
                    final entry = answerHistory[index];
                    final bool isCorrect = entry['isCorrect'];
                    final Color bgColor = isCorrect
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2);
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: bgColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            entry['icon'],
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(width: 12),
                          Text(
                            entry['guess'],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: isCorrect ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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