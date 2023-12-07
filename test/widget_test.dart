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

  // -------------------------------------------!!!!!!!!
  testWidgets('Time Usage Report Test', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    await fakeFirestore.collection('time_entries').add({
      'date': '2000/12/12',
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

    await tapButton(tester, 'Time Usage Report');

    // Ensure that the dialog is displayed
    expect(find.text('Search'), findsAtLeast(1));

    // Enter start and finish dates
    await tester.enterText(
        find.widgetWithText(TextField, 'Enter Start Date (YYYY/MM/DD)'),
        '2000/01/01');
    await tester.enterText(
        find.widgetWithText(TextField, 'Enter Finish Date (YYYY/MM/DD)'),
        '2000/01/31');

    // Submit the form
    await tapButton(tester, 'Submit');

    // Ensure that the result is displayed in the UI
    expect(find.text('Date: 2000/01/12'), findsOneWidget);
  });

  // --------------------------!!!
  testWidgets('Most Time Spent Test', (WidgetTester tester) async {
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

    await tapButton(tester, 'Most Time Spent');

    // Ensure that the result is displayed in the UI
    expect(find.text('Task: TEST, Total Time Spent:'), findsOneWidget);
  });

  testWidgets('Invalid Entry Test', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(firestore: fakeFirestore),
      ),
    );

    // Attempt to save an entry with invalid time format
    await tester.enterText(
        find.widgetWithText(TextField, 'Date (YYYY/MM/DD)'), '2023/12/12');
    await tester.enterText(
        find.widgetWithText(TextField, 'From (H:mm AM/PM)'), '6:00 PM');
    await tester.enterText(
        find.widgetWithText(TextField, 'To (H:mm AM/PM)'), 'invalid_time');
    await tester.enterText(
        find.widgetWithText(TextField, 'Task'), 'running a test');
    await tester.enterText(find.widgetWithText(TextField, 'Tag'), 'TEST');
    await tapButton(tester, 'Save Entry');

    // Ensure that a Snackbar with an error message is shown
    expect(find.text('Incorrect Input Format!'), findsOneWidget);
  });

  testWidgets('Empty Entry Test', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(firestore: fakeFirestore),
      ),
    );

    // Attempt to save an entry with empty fields
    await tapButton(tester, 'Save Entry');

    // Ensure that a Snackbar with an error message is shown
    expect(find.text('Incorrect Input Format!'), findsOneWidget);
  });

}

Future<void> tapButton(WidgetTester tester, String label) async {
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}
