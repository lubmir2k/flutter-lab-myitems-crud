# flutter-lab-myitems-crud

A Flutter CRUD application demonstrating local database operations using Hive.

## Features

- **Create** - Add new items to the database
- **Read** - View all items in a scrollable list
- **Update** - Edit existing items via dialog
- **Delete** - Remove items from the database
- **Local Persistence** - Data persists across app restarts using Hive

## Technology Stack

- **Flutter** - Cross-platform UI framework
- **Hive** - Fast, lightweight NoSQL local database
- **Dart** - Programming language

## Project Structure

```
lib/
├── main.dart              # App entry point and UI
├── item.dart              # Item model with Hive annotations
├── item.g.dart            # Generated TypeAdapter (auto-generated)
└── database_helper.dart   # CRUD operations helper
```

## Installation

1. Clone and checkout this branch:
```bash
git clone https://github.com/lubmir2k/flutter-lab-myitems-crud.git
cd flutter-lab-myitems-crud
git checkout feature/hive-crud
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate Hive TypeAdapter:
```bash
dart run build_runner build
```

## Running the App

### Web (Chrome)
```bash
flutter run -d chrome
```

### macOS
```bash
flutter run -d macos
```

### iOS / Android
```bash
flutter run -d ios
flutter run -d android
```

## How It Works

### Data Model (item.dart)
```dart
@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final String name;

  Item(this.name);
}
```

### Database Helper (database_helper.dart)
Manages all CRUD operations:
- `initDatabase()` - Initialize Hive and register adapters
- `insertItem(String name)` - Add new item
- `getItems()` - Retrieve all items
- `updateItem(int index, String name)` - Update item at index
- `deleteItem(int index)` - Delete item at index

### UI (main.dart)
- TextField for item input
- Add button to create items
- ListView displaying all items
- Edit and Delete icons for each item

## Data Storage

| Platform | Storage Location |
|----------|-----------------|
| **macOS** | `~/Library/Containers/com.example.myitemsCrud/Data/` |
| **Web** | Browser IndexedDB |
| **iOS** | App sandbox `/Documents/` |
| **Android** | App data directory |

**Note:** Data is stored **locally** on each device. Items do not sync across platforms.

## Future Enhancements

Potential cloud sync options:
1. Firebase Firestore integration
2. Supabase backend
3. Custom REST API
4. Hybrid Hive + Cloud sync approach

## Learning Objectives

- ✅ Hive database setup and initialization
- ✅ Creating data models with annotations
- ✅ Code generation with build_runner
- ✅ CRUD operations in Flutter
- ✅ Local data persistence
- ✅ Cross-platform development
