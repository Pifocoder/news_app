
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/src/ui/app/app.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Проверка добавления и удаления из избранного", (tester) async {
    await tester.pumpWidget(App());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final iconButton = find.byIcon(Icons.favorite_border).first;
    await tester.tap(iconButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final appBar = find.byType(AppBar);

    expect(appBar, findsOneWidget);

    final favorites = find.descendant(
      of: appBar,
      matching:
          find.byIcon(Icons.favorite), // Replace with the icon you want to find
    );
    await tester.tap(favorites);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.pumpWidget(App());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final iconButton1 = find.byIcon(Icons.favorite_border).first;
    await tester.tap(iconButton1);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(appBar, findsOneWidget);
    final _ = find.descendant(
      of: appBar,
      matching:
          find.byIcon(Icons.favorite),
    );
    await tester.tap(favorites);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final iconButton3 = find.byIcon(Icons.favorite).first;
    await tester.tap(iconButton3);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final iconButton4 = find.byIcon(Icons.favorite);
    await tester.tap(iconButton4);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byIcon(Icons.favorite), findsNothing);
  });
}
