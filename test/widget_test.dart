// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_awesome_namer/main.dart';

void main() {
  testWidgets('Like button test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    expect(find.text("Like"), findsOneWidget);
    expect(find.text("Next"), findsOneWidget);
    final likeButton = find.byKey(const Key('like_button'));
    // click前はfavorite_border icon
    expect(
        find.descendant(
            of: likeButton, matching: find.byIcon(Icons.favorite_border)),
        findsOneWidget);
    // clickできることを確認する
    await tester.tap(likeButton);
    await tester.pumpAndSettle();
    // click後はfavorite icon
    expect(
        find.descendant(of: likeButton, matching: find.byIcon(Icons.favorite)),
        findsOneWidget);
  });
  testWidgets("Next button test", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text("Next"), findsOneWidget);

    final cardTextFinder = find.byKey(const Key("big_card"));
    final clickBeforeText = tester
        .firstWidget<Text>(
            find.descendant(of: cardTextFinder, matching: find.byType(Text)))
        .data;

    final nextButton = find.byKey(const Key('next_button'));
    // clickできることを確認する
    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    final clickAfterText = tester
        .firstWidget<Text>(
            find.descendant(of: cardTextFinder, matching: find.byType(Text)))
        .data;
    // テキストが変更されることを確認する
    expect(clickBeforeText, isNot(clickAfterText));
  });
}
