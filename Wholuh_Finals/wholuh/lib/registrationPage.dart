import 'package:flutter/material.dart';
import 'login.dart';
import 'database.dart';

/*
  Authored by: Matt Despuig
  Company: Quadr.io
  Project: Who?/Luh!
  Feature: [WL-006]: Sign-in/Sign-up Page
  Description: A user interface for the registration page
*/

void main() {
  runApp(RegistrationApp());
}

class RegistrationApp extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationApp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();

  void register() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match', style: TextStyle(fontFamily: 'Montserrat'))),
      );
      return;
    }

    final result = await DatabaseHelper.instance.registerUser(
      usernameController.text,
      passwordController.text,
      emailController.text,
    );

    if (result == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username already exists!', style: TextStyle(fontFamily: 'Montserrat'))),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!', style: TextStyle(fontFamily: 'Montserrat'))),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: DefaultTextStyle(
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Who?/Luh!",
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.orange,
                        fontFamily: 'TitanOne',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
