import 'package:hive/hive.dart';
part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String name;
  Item(this.name);
}
