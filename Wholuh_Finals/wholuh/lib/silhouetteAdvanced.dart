import 'package:flutter/material.dart';
import 'dart:math';
import 'package:wholuh/silhouetteDifficulty.dart';

/* 
  Authored by: Matt Despuig
  Company: Quadr.io
  Project: Who?/Luh!
  Feature: [WL-015]: Advanced and Expert Difficulty
  Description: A sample user interface for choosing a difficulty
 */

void main() {
  runApp(silhouetteAdvanced());
}

class silhouetteAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silhouette Advanced',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SilhouetteAdvancedGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SilhouetteAdvancedGame extends StatefulWidget {
  @override
  _SilhouetteAdvancedGameState createState() => _SilhouetteAdvancedGameState();
}

class _SilhouetteAdvancedGameState extends State<SilhouetteAdvancedGame> {
  double _zoomLevel = 50.0;
  late String _imagePath;
  late String _correctAnswer;
  String _userGuess = '';
  int _points = 100;
  int _guessesRemaining = 10;
  final Set<String> _usedGuesses = {};
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _guessHistory = [];

  final List<Map<String, String>> animals = [
    {'name': 'dog'},
    {'name': 'cat'},
    {'name': 'horse'},
    {'name': 'cattle'},
    {'name': 'sheep'},
    {'name': 'goat'},
    {'name': 'chicken'},
    {'name': 'pig'},
    {'name': 'rabbit'},
    {'name': 'duck'},
  ];

  late final List<String> _possibleAnswers = animals.map((animal) => animal['name']!).toList();

  final Map<String, String> _imagePaths = {
    'dog': 'assets/images/dog_silhouette.jpg',
    'cat': 'assets/images/cat_silhouette.jpg',
    'horse': 'assets/images/horse_silhouette.jpg',
    'cattle': 'assets/images/cattle_silhouette.jpg',
    'sheep': 'assets/images/sheep_silhouette.jpg',
    'goat': 'assets/images/goat_silhouette.jpg',
    'chicken': 'assets/images/chicken_silhouette.jpg',
    'pig': 'assets/images/pig_silhouette.jpg',
    'rabbit': 'assets/images/rabbit_silhouette.jpg',
    'duck': 'assets/images/duck_silhouette.jpg',
  };

  void _selectRandomImage() {
    final random = Random();
    _correctAnswer = _possibleAnswers[random.nextInt(_possibleAnswers.length)];
    _imagePath = _imagePaths[_correctAnswer]!;
  }

  @override
  void initState() {
    super.initState();
    _selectRandomImage();
  }

  void _onGuessSubmitted() {
    if (_userGuess.trim().isEmpty) return;
    if (_usedGuesses.contains(_userGuess.toLowerCase())) return;

    setState(() {
      bool isCorrect = _userGuess.toLowerCase() == _correctAnswer.toLowerCase();
      _usedGuesses.add(_userGuess.toLowerCase());
      _guessHistory.insert(0, {
        'guess': _userGuess,
        'isCorrect': isCorrect,
      });

      if (isCorrect) {
        _showCongratulationsDialog();
      } else {
        _guessesRemaining--;
        _points = (_points > 10) ? _points - 10 : 10;
        _controller.clear();
        _userGuess = '';

        if (_guessesRemaining == 0) {
          _showGameOverDialog();
        }
      }
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('You Got It!', 
          style: TextStyle(
            fontFamily: 'Montserrat', 
            fontWeight: FontWeight.bold
          )
        ),
        content: Text(
          'Congratulations! You guessed the animal correctly!\n'
          'Attempts: ${_guessHistory.length}\n'
          'Points: $_points',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Game Over', 
          style: TextStyle(
            fontFamily: 'Montserrat', 
            fontWeight: FontWeight.bold
          )
        ),
        content: Text(
          'You ran out of guesses!\n'
          'The correct answer was: $_correctAnswer',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => silhouetteDifficulty()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Silhouette: Advanced',
          style: TextStyle(
            fontSize: 28, 
            fontWeight: FontWeight.bold, 
            color: Colors.orange,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => silhouetteDifficulty()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DefaultTextStyle(
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 16,
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 4),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(10),
                child: InteractiveViewer(
                  panEnabled: false,
                  boundaryMargin: EdgeInsets.all(20),
                  minScale: 1.0,
                  maxScale: _zoomLevel,
                  child: Transform.scale(
                    scale: _zoomLevel / 20.0,
                    child: Image.asset(
                      _imagePath,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text.rich(
                TextSpan(
                  text: 'Advanced Mode: ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.orange,
                    fontFamily: 'Montserrat',
                  ),
                  children: [
                    TextSpan(
                      text: 'The image will not zoom.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        color: Colors.orange,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Guesses Remaining: $_guessesRemaining',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Guess it!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (text) {
                        setState(() {
                          _userGuess = text;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _onGuessSubmitted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    child: Icon(Icons.check),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Animal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _guessHistory.length,
                  itemBuilder: (context, index) {
                    final guess = _guessHistory[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: guess['isCorrect']
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        guess['guess'],
                        style: TextStyle(
                          color: guess['isCorrect'] ? Colors.green : Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                        textAlign: TextAlign.center,
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
