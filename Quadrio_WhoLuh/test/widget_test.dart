import 'package:flutter_test/flutter_test.dart';
import 'package:wholuh/registrationPage.dart';
import 'package:wholuh/login.dart';
import 'package:wholuh/homepage.dart';
import 'package:wholuh/DifficultyPage.dart';
import 'package:wholuh/gamemodeSelection.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(RegistrationApp());
    await tester.pumpWidget(Login());
    await tester.pumpWidget(home_page());
    await tester.pumpWidget(Difficulty());
    await tester.pumpWidget(gamemodePage());
  });
}
