// Basic smoke test: the app boots on the splash screen and, once the splash
// timer fires, lands on the onboarding screen's "Get Started" CTA.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:infio/main.dart';

void main() {
  testWidgets('App boots to splash then onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(const InfioApp());

    // Splash screen shows first.
    expect(find.byType(MaterialApp), findsOneWidget);

    // Let the splash screen's navigation timer fire and settle on onboarding.
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Get Started'), findsOneWidget);
  });
}
