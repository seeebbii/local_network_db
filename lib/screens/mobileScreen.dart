import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_network_db/controllers/ipController.dart';
import 'package:local_network_db/service/Databse.dart';

class MobileScreen extends StatefulWidget {
  @override
  _MobileScreenState createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    final ipController = Get.find<IpController>();
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Local Database'),
        actions: [
          IconButton(onPressed: (){
            Database().deleteCollection(ipController.myIp.value, ipController.listOfIds.value);
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: "Your copied text",

                      ),
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: Icon(Icons.save),
                  onPressed:  () {
                    if(controller.text != ''){
                      Database().uploadString(controller.text, ipController.myIp.value);
                      controller.clear();
                    }else{
                      print('Cannot be empty');
                    }
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: GetX<IpController>(
              builder: (controller) {
                return ListView.builder(itemCount: controller.listOfStrings.length ,itemBuilder: (_, index){
                  if(controller.listOfStrings.isNotEmpty){
                    return ListTile(
                      leading: Text('${index+1}'),
                      title: Text('${controller.listOfStrings[index]}'),
                      trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
                    Database().deleteString(ipController.myIp.value, ipController.listOfIds.value[index]);
                    },),
                    );
                  }else{
                    return Center(child: Text(""),);
                  }
                });
              }
            ),
          )
        ],
      ),
    );
  }

}
