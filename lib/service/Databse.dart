import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void uploadString(String message, String ip) {
    try {
      _firestore.collection("$ip").add({
        'string': message,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<String>> getMyStrings(String ip) {
    try {
      return _firestore
          .collection(ip)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((msg) {
        var retVal = <String>[];
        msg.docs.forEach((element) {
          retVal.add(element.data()['string']);
        });
        return retVal;
      });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // void deleteCollection(String ip){
  //   try{
  //     _firestore.collection(ip).snapshots().map((data){
  //       data.docs.forEach((element) async{
  //         await element.reference.delete();
  //       });
  //     });
  //   }catch(e){
  //     print(e);
  //   }
  // }
}
