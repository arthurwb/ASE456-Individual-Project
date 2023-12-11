## Saving a Time Entry:

Input valid date, start time, end time, task, and tag.
Click the "Save Entry" button.
Verify that the time entry is saved in the Firestore database.

## Searching by Tag:

Input a valid tag.
Click the "Search" button.
Verify that the displayed entries match the search criteria.

## Searching by Date:

Input a valid date.
Select 'date' from the dropdown.
Click the "Submit" button.
Verify that the displayed entries match the search criteria.

## Searching by Task:

Input a valid task.
Select 'task' from the dropdown.
Click the "Submit" button.
Verify that the displayed entries match the search criteria.

## Displaying All Documents:

Click the "Display All" button.
Verify that all entries in the Firestore collection are displayed.

## Generating Time Usage Report:

Input a valid start date and finish date.
Click the "Time Usage Report" button.
Verify that the displayed entries match the specified date range.

## Finding Most Time Spent Activities:

Click the "Most Time Spent" button.
Verify that the displayed entries represent tasks with the highest total time spent.

## Handling Incorrect Input:

Input invalid data (e.g., incorrect date format, invalid time range).
Click the "Save Entry" button.
Verify that an error message is displayed, indicating incorrect input.

## Clearing Input Fields:

Input valid data.
Click the "Save Entry" button.
Verify that the input fields are cleared after saving.

## Dialog Interaction:

Open each dialog (Search, Time Usage Report, Most Time Spent).
Verify that the dialogs can be opened and closed successfully.

## Edge Case - No Matching Documents:

Search for a tag, task, or date that has no matching documents.
Verify that a message indicating no matching documents is displayed.

## Edge Case - Empty Database:

If possible, test the application behavior when the Firestore database is empty.
Verify that appropriate messages are displayed.