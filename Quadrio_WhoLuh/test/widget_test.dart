import 'package:flutter_test/flutter_test.dart';

import 'package:wholuh/registration_page.dart';
import 'package:wholuh/login.dart';
import 'package:wholuh/Homepage.dart';
import 'package:wholuh/DifficultyPage.dart';
import 'package:wholuh/GamemodeSelectionPage.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(RegistrationApp());
    await tester.pumpWidget(Login());
    await tester.pumpWidget(Home_page());
    await tester.pumpWidget(Difficulty());
    await tester.pumpWidget(GamemodePage());
  });
}
