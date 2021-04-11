import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_network_db/controllers/ipController.dart';
class WebScreen extends StatelessWidget {

  final ipController = Get.find<IpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(()=> Text("${ipController.myIp.value}")),
      ),
    );
  }
}
