import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import hive_flutter
import 'item.dart';
class DatabaseHelper {
  static const String boxName = 'itemsBox';
  Future<void> initDatabase() async {
    await Hive.initFlutter(); // Initialize Hive for Flutter
    if (!Hive.isAdapterRegistered(0)) {
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
  Future<void> updateItem(int index, String name) async {
    final box = Hive.box<Item>(boxName);
    final item = Item(name);
    await box.putAt(index, item);
  }
  Future<void> deleteItem(int index) async {
    final box = Hive.box<Item>(boxName);
    await box.deleteAt(index);
  }
}
