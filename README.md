# PBB-B Mobile Database Assignment

## Student Information

- **Name:** Farros Hilmi Syafei
- **NRP:** 5025201012
- **Class:** PBB B

## Assignment Overview

This Flutter application demonstrates the implementation of local database storage using **Hive**. The primary goal was to implement basic Create, Read, Update, and Delete (CRUD) operations based on the assignment requirements.

## Hive Implementation (NRP % 4 == 0)

Based on the calculation `5025201012 % 4 = 0`, the **Hive** database was chosen for this assignment.

### Simple CRUD Example Screen

A dedicated screen (`lib/features/7_hive/presentation/screens/hive_example_screen.dart`) was created to showcase basic Hive operations using a generic box (`Hive.box('mybox')`) without a specific data model.

**Functionality:**

- **Write:** Creates or updates data `['Farros', '5025201012', 'ITS']` associated with the key `user_5025201012`.
- **Read:** Retrieves the data associated with the key `user_5025201012`.
- **Delete:** Removes the data associated with the key `user_5025201012`.

**Screenshot:**

![Hive Example Screen](assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20Plus.png)

**Console Output Example:**

```log
flutter: Wrote data: [Farros, 5025201012, ITS]
flutter: Read data: [Farros, 5025201012, ITS]
flutter: Deleted data with key user_5025201012
```

**Implementation Details:**

For a more detailed explanation of how this Hive example is implemented, see the [Hive Feature README](./lib/features/7_hive/README.md).

### Model-Based CRUD Example (Settings Screen)

Additionally, CRUD operations using a Hive model (`User` class with `TypeAdapter`) were integrated into the Settings screen (`lib/features/5_setting/5_presentation/screens/settings_screen.dart`). This demonstrates storing structured data.

