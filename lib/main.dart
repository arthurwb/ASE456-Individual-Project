import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'util/handle_input.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  runApp(MyApp(firestore: firestore));
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore firestore;

  const MyApp({Key? key, required this.firestore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker App',
      home: TimeTrackerScreen(firestore: firestore),
    );
  }
}

class TimeTrackerScreen extends StatefulWidget {
  final FirebaseFirestore firestore;

  const TimeTrackerScreen({Key? key, required this.firestore}) : super(key: key);

  @override
  _TimeTrackerScreenState createState() => _TimeTrackerScreenState();
}

class _TimeTrackerScreenState extends State<TimeTrackerScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  List<Widget> matchingDocuments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date (YYYY/MM/DD)'),
              ),
              TextField(
                controller: fromController,
                decoration: InputDecoration(labelText: 'From (H:mm AM/PM)'),
              ),
              TextField(
                controller: toController,
                decoration: InputDecoration(labelText: 'To (H:mm AM/PM)'),
              ),
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: 'Task'),
              ),
              TextField(
                controller: tagController,
                decoration: InputDecoration(labelText: 'Tag'),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Column(children: [
                  ElevatedButton(
                    onPressed: () {
                      saveTimeEntry();
                    },
                    child: Text('Save Entry'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      showTagSearchDialog();
                    },
                    child: Text('Search'),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Column(
                    children: matchingDocuments,
                  ),
                ]),
              )
              // SizedBox(height: 16.0,),
              // StreamBuilder<QuerySnapshot>(
              //   stream: timeEntries.snapshots(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     }

              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return CircularProgressIndicator();
              //     }

              //     if (snapshot.data == null) {
              //       return Text('No data available');
              //     }

              //     // Display the list of time entries
              //     return Column(
              //       children:
              //           snapshot.data!.docs.map((DocumentSnapshot document) {
              //         Map<String, dynamic> data =
              //             document.data() as Map<String, dynamic>;
              //         return ListTile(
              //           title: Text(
              //               'Date: ${data['date']}, Task: ${data['task']}, Tag: ${data['tag']}'),
              //         );
              //       }).toList(),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void showTagSearchDialog() {
    String tagQuery = '';
    String selectedSearchCriteria = 'tag'; // Default search criteria

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Search'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedSearchCriteria,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSearchCriteria = newValue!;
                      });
                    },
                    items: <String>['date', 'task', 'tag']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: TextEditingController()..text = tagQuery,
                    onChanged: (value) {
                      tagQuery = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter $selectedSearchCriteria'),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancel Button
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Fetch and display documents based on the selected criteria and input
                    fetchDocuments(selectedSearchCriteria, tagQuery);
                    Navigator.of(context).pop();
                  },
                  child: Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    // Display all documents
                    fetchAllDocuments();
                    Navigator.of(context).pop();
                  },
                  child: Text('Display All'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void fetchDocuments(String searchCriteria, String query) {
    // Fetch and display documents based on the provided search criteria and query
    // You can customize this part based on your database structure
    // Here, we assume 'tag' is a field in the documents

    String fieldToQuery = searchCriteria;

    if (searchCriteria == 'date') {
      fieldToQuery = 'date';
      query = HandleInput().handleDate(query);
    } else if (searchCriteria == 'task') {
      fieldToQuery = 'task';
    } else {
      fieldToQuery = 'tag';
    }

    widget.firestore
        .collection('time_entries')
        .where(fieldToQuery, isEqualTo: query)
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        matchingDocuments.clear(); // Clear the previous results

        if (querySnapshot.docs.isEmpty) {
          // No matching documents found, show a Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No matching documents found'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // Matching documents found, create ListTile widgets
          querySnapshot.docs.forEach((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            // Create a ListTile widget for each matching document
            matchingDocuments.add(
              ListTile(
                title: Text(
                    'Date: ${data['date']}, ${data['from']} - ${data['to']}, Task: ${data['task']}, Tag: ${data['tag']}'),
              ),
            );
          });
        }
      });
    });
  }

  void fetchAllDocuments() {
    // Fetch and display all documents
    widget.firestore.collection('time_entries').get().then((QuerySnapshot querySnapshot) {
      setState(() {
        matchingDocuments.clear(); // Clear the previous results
        querySnapshot.docs.forEach((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          // Create a ListTile widget for each document
          matchingDocuments.add(
            ListTile(
              title: Text(
                  'Date: ${data['date']}, ${data['from']} - ${data['to']}, Task: ${data['task']}, Tag: ${data['tag']}'),
            ),
          );
        });
      });
    });
  }

  void saveTimeEntry() {
    String date = HandleInput().handleDate(dateController.text);
    String start = HandleInput().handleTime(fromController.text);
    String finish = HandleInput().handleTime(toController.text);

    if (date.isNotEmpty && start.isNotEmpty && finish.isNotEmpty) {
      widget.firestore.collection('time_entries').add({
        'date': date,
        'from': start,
        'to': finish,
        'task': taskController.text,
        'tag': tagController.text,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect Input Format!'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    // Clear input fields after saving
    dateController.clear();
    fromController.clear();
    toController.clear();
    taskController.clear();
    tagController.clear();
  }
}
