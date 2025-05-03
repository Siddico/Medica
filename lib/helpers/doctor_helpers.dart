import 'package:medical/Models/doctor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'doctor.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('medical.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE doctors (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fullName TEXT,
          email TEXT,
          specialization TEXT,
          experience TEXT,
          password TEXT
        )''');
  }

  // دالة للحصول على الطبيب من خلال البريد الإلكتروني وكلمة المرور
  Future<Doctor?> getDoctorByEmailAndPassword(
    String email,
    String password,
  ) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'doctors',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return Doctor.fromMap(maps.first);
    }
    return null;
  }

  // دالة لإدخال طبيب جديد في قاعدة البيانات (لتجربة التحقق من الدخول)
  Future<int> insertDoctor(Doctor doctor) async {
    final db = await instance.database;
    return await db.insert('doctors', doctor.toMap());
  }
}
