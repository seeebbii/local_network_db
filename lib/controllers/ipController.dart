import 'package:get/get.dart';
import 'package:local_network_db/service/Databse.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class IpController extends GetxController {
  var myIp = ''.obs;
  var listOfStrings = <String>[].obs;
  var listOfIds = <String>[].obs;


  @override
  void onInit() {
    getMyIp();
    super.onInit();
  }

  void getMyIp() async {
    String url = 'api.ipify.org';
    http.Response response = await http.get(Uri.http(url, ''));
    if(response.statusCode == 200){
      print(response.body);
      listOfStrings.bindStream(Database().getMyStrings(response.body));
      listOfIds.bindStream(Database().getMyIds(response.body));
      myIp.value = response.body;
    }
  }

}