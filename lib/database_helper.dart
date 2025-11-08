import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import hive_flutter
import 'item.dart';

class DatabaseHelper {
  static const String boxName = 'itemsBox';
  Future<void> initDatabase() async {
    await Hive.initFlutter(); // Initialize Hive for Flutter
    if (!Hive.isAdapterRegistered(ItemAdapter().typeId)) {
      Hive.registerAdapter(ItemAdapter());
    }
    await Hive.openBox<Item>(boxName); // Open the box
  }

  Future<void> insertItem(String name) async {
    final box = Hive.box<Item>(boxName);
    await box.add(Item(name));
  }

  List<Item> getItems() {
    final box = Hive.box<Item>(boxName);
    return box.values.toList();
  }

  Future<void> updateItem(Item item, String newName) async {
    item.name = newName;
    await item.save();
  }

  Future<void> deleteItem(Item item) async {
    await item.delete();
  }
}
