import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper(){
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cards_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Folders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT
        )
      '''
    );

    await db.execute('''
      CREATE TABLE Cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        suit TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        folderId INTEGER,
        FOREIGN KEY (folderId) REFERENCES Folders (id)
      )
    '''
    );

    await _prepopulateCards(db);
  }

  Future<void> _prepopulateCards(Database db) async {
    List<String> suits = ['Hearts','Spades','Diamonds','Clubs'];
    List<String> cardNames = ['Ace','2','3','4','5','6','7','8','9','10','Jack','Queen','King'];

    for (String suit in suits) {
      for (String cardName in cardNames) {
        String imageUrl = 'assets/images/${cardName}_of_${suit}.png';
        await db.insert('Cards', {
          'name': '$cardName of $suit',
          'suit': suit,
          'imageUrl': imageUrl,
          'folderId': null,
        });
      }
    }
  }
}
