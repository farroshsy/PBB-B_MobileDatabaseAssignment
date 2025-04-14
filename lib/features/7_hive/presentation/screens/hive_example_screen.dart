import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveExampleScreen extends StatefulWidget {
  const HiveExampleScreen({super.key});

  @override
  State<HiveExampleScreen> createState() => _HiveExampleScreenState();
}

class _HiveExampleScreenState extends State<HiveExampleScreen> {
  // Reference the already opened box
  final _myBox = Hive.box('mybox');
  final _userKey = 'user_5025201012'; // Use a descriptive key

  // Write data
  void writeData() {
    // Write user details using the specific key
    _myBox.put(_userKey, ['Farros', '5025201012', 'ITS']);
    print('Wrote data: ${_myBox.get(_userKey)}'); 
    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data written for key $_userKey')),
    );
  }

  // Read data
  void readData() {
    // Read data using the specific key
    var data = _myBox.get(_userKey);
    print('Read data: $data');
    // Show feedback
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data read for key $_userKey: $data')),
    );
  }

  // Delete data
  void deleteData() {
    // Delete data using the specific key
    _myBox.delete(_userKey);
    print('Deleted data with key $_userKey');
     // Show feedback
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data deleted for key $_userKey')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive CRUD Example'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Using ElevatedButton instead of deprecated MaterialButton
            ElevatedButton(
              onPressed: writeData,
              child: const Text('Write'),
            ),
            ElevatedButton(
              onPressed: readData,
              child: const Text('Read'),
            ),
            ElevatedButton(
              onPressed: deleteData,
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
} 