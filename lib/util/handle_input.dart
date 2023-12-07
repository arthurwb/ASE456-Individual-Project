import 'package:intl/intl.dart';

class HandleInput {
  handleDate(String input) {
    String response;
    if (input.toLowerCase() == 'today') {
      response = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else if (!RegExp(r'^\d{4}/\d{2}/\d{2}$').hasMatch(input)) {
      response = '';
    } else {
      response = input;
    }
    return response;
  }

  handleTime(String input) {
    String response;

    input = input.toUpperCase();

    if (RegExp(r'^([1-9]|1[0-2]):[0-5][0-9] (AM|PM)$').hasMatch(input)) {
      response = input;
    } else {
      response = '';
    }
    return response;
  }
}
