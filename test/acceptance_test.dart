import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/main.dart';

void main() {
  final fakeFirestore = FakeFirebaseFirestore();

  testWidgets('App Loads With All Features', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(
      firestore: fakeFirestore,
    ));

    await tester.pumpAndSettle();

    expect(find.text("Time Tracker"), findsOne);
    expect(find.text("Date (YYYY/MM/DD)"), findsOne);
    expect(find.text("From (H:mm AM/PM)"), findsOne);
    expect(find.text("To (H:mm AM/PM)"), findsOne);
    expect(find.text("Task"), findsOne);
    expect(find.text("Tag"), findsOne);
    expect(find.text("Save Entry"), findsOne);
    expect(find.text("Search"), findsAtLeast(1));
    expect(find.text("Time Usage Report"), findsOne);
    expect(find.text("Most Time Spent"), findsOne);

    await tapButton(tester, "Search");
    expect(find.text("Enter tag"), findsOne);
    expect(find.text("Cancel"), findsOne);
    await tapButton(tester, "Cancel");

    expect(tester.takeException(), isNull);
  });
}

Future<void> tapButton(WidgetTester tester, String label) async {
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}
