import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_network_db/controllers/ipController.dart';
import 'package:local_network_db/screens/mobileScreen.dart';
import 'package:local_network_db/screens/webScreen.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ipController = Get.put(IpController());
    return LayoutBuilder(builder: (context, constraints){
      if(constraints.maxWidth > 1200){
        // web
        return WebScreen();
      }else{
        // mobile
        return MobileScreen();
      }
    });
  }
}
