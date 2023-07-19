import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class CartData {
  String? id;
   String? name;
   String? title;
   int? amount;
   int? totalAmount;
   int? quantity;

   CartData({
    required this.name,
    required this.id,
    required this.amount,
    required this.quantity,
    required this.title,
    required this.totalAmount,

  });
   // Convert a Dog into a Map. The keys must correspond to the names of the
   // columns in the database.
   Map<String, dynamic> toMap() {
     return {
       'name': name,
       'id': id,
       'amount': amount,
       'totalAmount': totalAmount,
       'title': title,
       'quantity': quantity,
     };
   }

   // Implement toString to make it easier to see information about
   // each dog when using the print statement.
   @override
   String toString() {
     return 'CartData{ name: $name, '
         'amount: $amount,totalAmount:$totalAmount,quantity:$quantity,title:$title}';
   }


}






class SQL {

  // A method that retrieves all the dogs from the dogs table.
  Future<List<CartData>> getCart() async {
    // Get a reference to the database.
    final database = openDatabase(
      join(await getDatabasesPath(), 'pashewCart.db'),
      version: 1,);
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('CART');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return CartData(
        name: maps[i]['name'],
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        totalAmount: maps[i]['totalAmount'],
        quantity: maps[i]['quantity'],
        title: maps[i]['title'],
      );
    });
  }

  Future<void> insertCartData(CartData cartData) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'pashewCart.db'),
      version: 1,);
    final db = await database;
    await db.transaction((txn) async {
    // await  txn.execute("CREATE UNIQUE INDEX idx_positions_title ON CARTDATA (name);"
    //       );
      int id1 = await txn.rawInsert(
          'REPLACE INTO CARTTABLE (name, amount, title,quantity,totalAmount, id) VALUES("${cartData
              .name}", "${cartData.amount}", "${cartData.title}","${cartData
              .quantity}", "${cartData.totalAmount}", "${cartData.id}")');
      // await txn.rawUpdate('UPDATE CARTS SET AMOUNT = 100 WHERE id="${cartData.name}"');
      print('inserted1: $id1');
    });
  }
Future<void> updateSQL(CartData cartData)async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'pashewCart.db'),
    version: 1,);
  final db = await database;
  int update=  await db.rawUpdate(
        'UPDATE CARTTABLE  SET totalAmount="${cartData.totalAmount}", quantity="${cartData.quantity}" WHERE name="${cartData.name}"');
  print("Updated:$update");
  }
  Future<void> deleteSQL(CartData cartData)async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'pashewCart.db'),
      version: 1,);
    final db = await database;
    int delete=  await db.rawUpdate(
        'DELETE FROM CARTTABLE   WHERE name="${cartData.name}"');
    print("Deleted:$delete");
  }
}
