import 'package:mongo_dart/mongo_dart.dart';
// import 'package:online_food/user.dart';
// import 'package:online_food/userProvider.dart';

const url =
    "mongodb+srv://jerrito0240:streak0240845898@cluster0.5dpfja6.mongodb.net/pashewFood?retryWrites=true&w=majority";
const collection = "pashewFoodAccount";

class Mongo {
  static var db, doctorCollection, appointmentCollection;

  static con() async {
    db = await Db.create(url);
    await db.open();
    // Db.inspect(db);
    doctorCollection = db.collection(collection);
    //appointmentCollection = db.collection(collectionAppointment);
  }
}
