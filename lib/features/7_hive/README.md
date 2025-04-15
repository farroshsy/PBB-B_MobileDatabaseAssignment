# Hive CRUD Example Feature (Layered Architecture with Riverpod)

This feature demonstrates basic Create, Read, Update, and Delete (CRUD) operations using the Hive database in Flutter, structured following a layered architecture (Domain, Data, Presentation) and utilizing Riverpod for dependency injection and state management.

## How it Works

1. **Initialization:**
    * Hive is initialized globally when the app starts in `lib/main.dart`.
    * A specific box named `'mybox'` is also opened during startup using `await Hive.openBox('mybox');`. This box is used by this example.

2. **Layered Structure:**
    * **Domain Layer (`1_domain`):** Defines the contract for data operations through the abstract `HiveRepository`.
    * **Data Layer (`2_data`):**
        * `datasources/hive_datasource.dart`: Defines the abstract `HiveDataSource` for direct Hive interactions.
        * `datasources/hive_datasource_impl.dart`: Implements `HiveDataSource` using the `Hive.box('mybox')`.
        * `repositories/hive_repository_impl.dart`: Implements the `HiveRepository` from the domain layer, using the `HiveDataSource`.
    * **Providers (`4_providers`):**
        * `hive_providers.dart`: Defines Riverpod providers (`hiveDataSourceProvider`, `hiveRepositoryProvider`) to make the data source and repository implementations available via DI.
        * `hive_screen_notifier.dart`: Defines a `StateNotifier` (`HiveScreenNotifier`) and its provider (`hiveScreenNotifierProvider`). This notifier handles the screen's logic and state, interacting with the `HiveRepository`.
    * **Presentation Layer (`5_presentation`):**
        * `screens/hive_example_screen.dart`: A `ConsumerWidget` that displays the UI. It watches the `hiveScreenNotifierProvider` to get the current data state and calls methods on the notifier (`writeData`, `readData`, `deleteData`) when buttons are pressed.

3. **CRUD Operations Flow:**
    * User interacts with buttons on `HiveExampleScreen`.
    * `onPressed` callbacks call methods on the `HiveScreenNotifier`.
    * The `HiveScreenNotifier` calls corresponding methods on the `HiveRepository` (obtained via Riverpod).
    * The `HiveRepositoryImpl` calls methods on the `HiveDataSource`.
    * The `HiveDataSourceImpl` performs the actual `put`, `get`, or `delete` operation on the Hive box.
    * The `HiveScreenNotifier` updates its state, causing the `HiveExampleScreen` to rebuild and display the latest data (or lack thereof).

## Note

This example directly stores a Dart `List` in the Hive box. For more complex data structures or custom objects (like the `User` model used in the Settings feature), you would typically:

* Define a Dart class (`@HiveType`) (potentially in the Domain layer as an Entity).
* Annotate fields (`@HiveField`).
* Generate a `TypeAdapter` using `build_runner`.
* Register the adapter in `main.dart` (`Hive.registerAdapter(...)`).
* Open a typed box (`Hive.openBox<YourModel>('boxName')`).
* Adjust the `DataSource`, `Repository`, and `Notifier` to work with your specific model type instead of `List<dynamic>`.
