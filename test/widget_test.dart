import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_list_interview/main.dart';

void main() {
  testWidgets(
    'Initial books, category filtering, and search work individually',
    (tester) async {
      await tester.pumpWidget(const BookshelfApp());
      expect(find.text('4 books'), findsOneWidget);
      expect(find.text('Practical Flutter'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilterChip, 'Technology'));
      await tester.pumpAndSettle();
      expect(find.text('1 book'), findsOneWidget);
      expect(find.text('The Long Journey'), findsNothing);
      await tester.tap(find.text('All categories'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('search')), 'rome');
      await tester.pumpAndSettle();
      expect(find.text('A Weekend in Rome'), findsOneWidget);
      expect(find.text('Practical Flutter'), findsNothing);
    },
  );
}
