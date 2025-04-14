# Hive CRUD Example Feature

This feature demonstrates basic Create, Read, Update, and Delete (CRUD) operations using the Hive database in Flutter.

## How it Works

1. **Initialization:**
    * Hive is initialized globally when the app starts in `lib/main.dart`.
    * A specific box named `'mybox'` is also opened during startup using `await Hive.openBox('mybox');`. This box is used by this example screen and stores data without requiring a specific data model or `TypeAdapter`.

2. **Screen (`hive_example_screen.dart`):**
    * This screen provides a simple UI with three buttons: "Write", "Read", and "Delete".
    * It accesses the pre-opened box using `final _myBox = Hive.box('mybox');`.

3. **CRUD Operations:**
    * **Write (Create/Update):**
        * The `writeData` function uses `_myBox.put(key, value);`.
        * In this example, the `key` is `'user_5025201012'` and the `value` is a `List`: `['Farros', '5025201012', 'ITS']`.
        * `put` inserts the data if the key doesn't exist, or overwrites (updates) the data if the key already exists.
    * **Read:**
        * The `readData` function uses `_myBox.get(key);` to retrieve the data associated with the key `'user_5025201012'`.
    * **Delete:**
        * The `deleteData` function uses `_myBox.delete(key);` to remove the data associated with the key `'user_5025201012'`.

## Note

This example directly stores a Dart `List` in the Hive box. For more complex data structures or custom objects (like the `User` model used in the Settings feature), you would typically:

* Define a Dart class (`@HiveType`).
* Annotate fields (`@HiveField`).
* Generate a `TypeAdapter` using `build_runner`.
* Register the adapter in `main.dart` (`Hive.registerAdapter(...)`).
* Open a typed box (`Hive.openBox<YourModel>('boxName')`).
