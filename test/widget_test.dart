import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:project/main.dart'; // Replace with the actual path to your main.dart file

void main() {
  testWidgets('Screen Loads Test', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    await tester.pumpWidget(MyApp(firestore: fakeFirestore));

    expect(find.text('Time Tracker'), findsOneWidget);


    expect(find.widgetWithText(ElevatedButton, 'Save Entry'), findsOneWidget);

    expect(find.widgetWithText(ElevatedButton, 'Search'), findsOneWidget);
  });
}
