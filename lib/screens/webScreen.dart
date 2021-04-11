import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_network_db/controllers/ipController.dart';
import 'package:local_network_db/service/Databse.dart';

class WebScreen extends StatelessWidget {
  final ipController = Get.find<IpController>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              'Your local database',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(onPressed: (){
                Database().deleteCollection(ipController.myIp.value, ipController.listOfIds.value);
              }, icon: Icon(Icons.delete), label: Text('Delete all')),
              SizedBox(width: 50,),
              Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "Your copied text",
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    if (controller.text != '') {
                      Database().uploadString(
                          controller.text, ipController.myIp.value);
                      controller.clear();
                    } else {
                      print('Cannot be empty');
                    }
                  },
                  child: Text('Save to database'))
            ],
          ),
          Expanded(
            child: GetX<IpController>(builder: (controller) {
              return Container(
                margin: EdgeInsets.all(25),
                width: MediaQuery.of(context).size.width * 0.50,
                child: ListView.builder(
                    itemCount: controller.listOfStrings.length,
                    itemBuilder: (_, index) {
                      if (controller.listOfStrings.isNotEmpty) {
                        return ListTile(
                          leading: Text('${index + 1}'),
                          title: Text('${controller.listOfStrings[index]}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              Database().deleteString(ipController.myIp.value, ipController.listOfIds.value[index]);
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(""),
                        );
                      }
                    }),
              );
            }),
          )
        ],
      ),
    ));
  }
}
