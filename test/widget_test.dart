import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:project/main.dart';

void main() {
  testWidgets('Screen Loads Test', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(firestore: fakeFirestore),
      ),
    );

    expect(find.text('Time Tracker'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Save Entry'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Search'), findsOneWidget);
  });

  testWidgets('Save Entry Test', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(firestore: fakeFirestore),
      ),
    );

    await tester.enterText(
        find.widgetWithText(TextField, 'Date (YYYY/MM/DD)'), '2023/12/12');
    await tester.enterText(
        find.widgetWithText(TextField, 'From (H:mm AM/PM)'), '6:00 PM');
    await tester.enterText(
        find.widgetWithText(TextField, 'To (H:mm AM/PM)'), '9:00 AM');
    await tester.enterText(
        find.widgetWithText(TextField, 'Task'), 'running a test');
    await tester.enterText(find.widgetWithText(TextField, 'Tag'), 'TEST');
    await tapButton(tester, 'Save Entry');

    final querySnapshot = await fakeFirestore.collection('time_entries').get();
    expect(querySnapshot.docs.length, 1);
  });

  testWidgets('Search Query Test', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    await fakeFirestore.collection('time_entries').add({
      'date': '2023/12/12',
      'from': '6:00 PM',
      'to': '9:00 AM',
      'task': 'running a test',
      'tag': 'TEST',
    });

    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(firestore: fakeFirestore),
      ),
    );

    await tapButton(tester, 'Search');

    expect(find.text('Search'), findsAtLeast(2));

    await tester.enterText(find.widgetWithText(TextField, 'Enter tag'), 'TEST');
    await tapButton(tester, 'Submit');

    expect(
        find.text(
            'Date: 2023/12/12, 6:00 PM - 9:00 AM, Task: running a test, Tag: TEST'),
        findsOneWidget);
  });

  testWidgets('Load All Data Test', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    await fakeFirestore.collection('time_entries').add({
      'date': '2023/12/12',
      'from': '6:00 PM',
      'to': '9:00 AM',
      'task': 'running a test',
      'tag': 'TEST',
    });

    await fakeFirestore.collection('time_entries').add({
      'date': '2023/12/13',
      'from': '10:00 AM',
      'to': '1:00 PM',
      'task': 'another test',
      'tag': 'ANOTHER',
    });

    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(firestore: fakeFirestore),
      ),
    );

    await tapButton(tester, "Search");

    await tapButton(tester, 'Display All');

    expect(
        find.text(
            'Date: 2023/12/12, 6:00 PM - 9:00 AM, Task: running a test, Tag: TEST'),
        findsOneWidget);
    expect(
        find.text(
            'Date: 2023/12/13, 10:00 AM - 1:00 PM, Task: another test, Tag: ANOTHER'),
        findsOneWidget);
  });
}

Future<void> tapButton(WidgetTester tester, String label) async {
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}
