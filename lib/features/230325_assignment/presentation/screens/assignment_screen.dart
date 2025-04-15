import 'package:flutter/foundation.dart'; // For ValueListenableBuilder
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import Hive Flutter for builders

part 'assignment_screen.g.dart';

@HiveType(typeId: 1)
class AssignmentItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  AssignmentItem({required this.title, required this.description});
}

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  // Reference the Hive box (opened in main.dart)
  final Box<AssignmentItem> _assignmentBox = Hive.box<AssignmentItem>('assignmentBox');

  // --- CRUD Logic (Updated for Hive) ---

  // Create
  Future<void> _addItem(String title, String description) async {
    final newItem = AssignmentItem(title: title, description: description);
    await _assignmentBox.add(newItem); // Add to Hive box
    // No need for setState, ValueListenableBuilder handles UI updates
  }

  // Read (Handled by ValueListenableBuilder)

  // Update
  Future<void> _updateItem(dynamic key, String newTitle, String newDescription) async {
    final item = _assignmentBox.get(key); // Get item by key
    if (item != null) {
      item.title = newTitle;
      item.description = newDescription;
      await item.save(); // Save changes to Hive box
    }
    // No need for setState
  }

  // Delete
  Future<void> _deleteItem(dynamic key) async {
    await _assignmentBox.delete(key); // Delete from Hive box by key
    // No need for setState
  }

  // --- Dialogs for C/U (Updated) ---

  void _showItemDialog({AssignmentItem? item, dynamic itemKey}) { // Added itemKey
    final titleController = TextEditingController(text: item?.title ?? '');
    final descriptionController = TextEditingController(text: item?.description ?? '');
    final isEditing = item != null && itemKey != null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Item' : 'Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                textCapitalization: TextCapitalization.sentences,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                if (title.isNotEmpty) {
                  if (isEditing) {
                    _updateItem(itemKey, title, description); // Pass key
                  } else {
                    _addItem(title, description);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment CRUD (Hive)'), // Updated title
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Use ValueListenableBuilder to react to Hive box changes
      body: ValueListenableBuilder<Box<AssignmentItem>>(
        valueListenable: _assignmentBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No items yet. Add some!'));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index); // Get item by index
              final itemKey = box.keyAt(index); // Get key by index

              if (item == null) {
                // Should generally not happen if box is managed correctly
                return const ListTile(title: Text('Error loading item'));
              }

              return AssignmentListItem(
                item: item,
                itemKey: itemKey, // Pass the key
                onTap: () => _showItemDialog(item: item, itemKey: itemKey),
                onDelete: () => _deleteItem(itemKey), // Pass the key
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(), // Call without item/key for Add
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Optional: Close the box when the screen is disposed
  // @override
  // void dispose() {
  //   // Note: Box is opened globally in main.dart, so closing here might
  //   // affect other parts of the app if they use the same box.
  //   // Consider your app's structure if implementing dispose.
  //   // _assignmentBox.close(); 
  //   super.dispose();
  // }
}

// Custom Stateless Widget (Updated to accept key)
class AssignmentListItem extends StatelessWidget {
  final AssignmentItem item;
  final dynamic itemKey; // Accept the key
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const AssignmentListItem({
    super.key,
    required this.item,
    required this.itemKey, // Require the key
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.description),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
        tooltip: 'Delete Item',
      ),
      onTap: onTap,
    );
  }
} 