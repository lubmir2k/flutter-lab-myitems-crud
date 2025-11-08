import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database_helper.dart';
import 'item.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  await dbHelper.initDatabase(); // Initialize the database
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD IndexedDB',
      home: ItemListScreen(),
    );
  }
}
class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}
class _ItemListScreenState extends State<ItemListScreen> {
  List<Item> _items = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _controller = TextEditingController();
  void _fetchItems() {
    setState(() {
      _items = _databaseHelper.getItems();
    });
  }
  void _addItem() async {
    if (_controller.text.isNotEmpty) {
      await _databaseHelper.insertItem(_controller.text);
      _controller.clear();
      _fetchItems();
    }
  }
  void _updateItem(int index) async {
    // Create a text controller for the dialog
    TextEditingController updateController = TextEditingController(text: _items[index].name);
    // Show dialog for updating item
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Item'),
          content: TextField(
            controller: updateController,
            decoration: InputDecoration(labelText: 'New Item Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String newName = updateController.text;
                if (newName.isNotEmpty) {
                  _databaseHelper.updateItem(index, newName);
                  _fetchItems();
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
  void _deleteItem(int index) async {
    await _databaseHelper.deleteItem(index);
    _fetchItems();
  }
  @override
  void initState() {
    super.initState();
    _fetchItems();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
          ),
          ElevatedButton(onPressed: _addItem, child: Text('Add Item')),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _updateItem(index), // Call update function
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteItem(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
