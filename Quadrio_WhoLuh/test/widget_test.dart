import 'package:flutter_test/flutter_test.dart';
import 'package:wholuh/registrationPage.dart';
import 'package:wholuh/login.dart';
import 'package:wholuh/homepage.dart';
import 'package:wholuh/gamemodeSelection.dart';
import 'package:wholuh/vanillaDifficulty.dart';
import 'package:wholuh/silhouetteDifficulty.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(RegistrationApp());
    await tester.pumpWidget(Login());
    await tester.pumpWidget(home_page());
    await tester.pumpWidget(vanillaDifficulty());
    await tester.pumpWidget(silhouetteDifficulty());
    await tester.pumpWidget(gamemodePage());
  });
}
