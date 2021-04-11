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

  Stream<List<String>> getMyIds(String ip) {
    try {
      return _firestore
          .collection(ip)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((msg) {
        var retVal = <String>[];
        msg.docs.forEach((element) {
          retVal.add(element.reference.id);
        });
        return retVal;
      });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  void deleteString(String ip, String docRef){
    try{
      _firestore.collection(ip).doc(docRef).delete();
    }catch(e){

    }
  }

  void deleteCollection(String ip, List<String> ids){
    try{
      ids.forEach((element) {
        _firestore.collection(ip).doc(element).delete();
      });
    }catch(e){
      print(e);
    }
  }
}
