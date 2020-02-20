import 'package:bytebank/models/Contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'accountNumber INTEGER)');
    },
    version: 1,
//      onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future<int> save(Contact contact) async {
  final Database db = await createDatabase();

  final Map<String, dynamic> contactMap = Map();
  contactMap['name'] = contact.name;
  contactMap['accountNumber'] = contact.accountNumber;

  return db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  final Database db = await createDatabase();
  final List<Map<String, dynamic>> results = await db.query('contacts');

  final List<Contact> contacts = List();
  for (Map<String, dynamic> result in results) {
    final Contact contact =
        Contact(result['id'], result['name'], result['accountNumber']);
    contacts.add(contact);
  }
  return contacts;
}
