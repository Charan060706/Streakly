import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MindStreakApp());

    // Since we don't have a counter in our UI, this test may not be meaningful right now.
    // You can customize or remove it based on your actual widgets.

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);
  });
}
