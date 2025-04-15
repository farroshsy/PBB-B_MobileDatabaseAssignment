# 230325 Assignment Feature

## Overview

This feature implements a simple Create, Read, Update, Delete (CRUD) application screen to fulfill the requirements of the 230325 assignment.

## Requirements Fulfillment

The implementation satisfies the core assignment requirements:

1. **Uses at least 5 different widgets:** The screen utilizes `Scaffold`, `AppBar`, `ListView`, `FloatingActionButton`, `AlertDialog`, `Text`, `TextField`, `ElevatedButton`, `TextButton`, `ListTile`, `IconButton`, and `Icon` (well over 5).
2. **Custom class & custom stateless widget:**
    * A custom class `AssignmentItem` (`lib/features/230325_assignment/presentation/screens/assignment_screen.dart`) is used to model the data items.
    * A custom stateless widget `AssignmentListItem` (`lib/features/230325_assignment/presentation/screens/assignment_screen.dart`) is used to display each item in the list.
3. **Apply create, read, update, delete:**
    * **Create:** New items are added using the `FloatingActionButton` which opens an `AlertDialog`.
    * **Read:** Items are displayed in a `ListView`.
    * **Update:** Tapping an existing item in the `ListView` opens the same `AlertDialog` pre-filled for editing.
    * **Delete:** Each item has a delete `IconButton`.
4. **Web API/Local DB (Optional Requirement Met):** This implementation now uses **Hive** as a local database for data persistence. The `AssignmentItem` class is a Hive object (`HiveObject`), and data is stored in a dedicated Hive box (`assignmentBox`). Changes persist across app restarts.

## Implementation Details

* **Location:** The main UI and logic reside in `lib/features/230325_assignment/presentation/screens/assignment_screen.dart`.
* **Data Model:** The `AssignmentItem` class (`assignment_screen.dart`) is annotated for Hive (`@HiveType`, `@HiveField`) and requires a generated adapter (`assignment_screen.g.dart`). If this class is modified, run `flutter packages pub run build_runner build --delete-conflicting-outputs`.
* **Data Storage:** Data is managed using the `hive` and `hive_flutter` packages. The `assignmentBox` is opened in `main.dart` and accessed within the `AssignmentScreen`.
* **State Management & UI Updates:** A `ValueListenableBuilder` listens directly to the `assignmentBox` for changes, automatically rebuilding the `ListView` when items are added, updated, or deleted.
* **Navigation:** The screen is registered in the GoRouter configuration (`lib/core/navigation/app_router.dart`) under the path `/assignment`. It can be accessed via the "230325 Assignment" button added to the `HomeScreen` (`lib/features/2_home/5_presentation/screens/home_screen.dart`).

## How it Works

1. The user navigates to the screen via the button on the Home screen.
2. The `AssignmentScreen` builds, using a `ValueListenableBuilder` to display the current contents of the `assignmentBox`.
3. The user taps the `FloatingActionButton` (+) to add an item.
4. An `AlertDialog` appears with fields for "Title" and "Description".
5. After filling the fields and pressing "Add", the `_addItem` method adds the new `AssignmentItem` to the Hive box. The `ValueListenableBuilder` detects the change and rebuilds the `ListView`.
6. To edit an item, the user taps the `ListTile` representing the item.
7. The same `AlertDialog` appears, pre-filled with the item's data. The user modifies the data and presses "Update". The `_updateItem` method retrieves the item from the Hive box using its key, updates its fields, and calls `item.save()`. The `ValueListenableBuilder` detects the change and rebuilds the `ListView`.
8. To delete an item, the user taps the delete `IconButton` on the `ListTile`. The `_deleteItem` method deletes the item from the Hive box using its key. The `ValueListenableBuilder` detects the change and rebuilds the `ListView`. 