import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class JsonResultShow extends StatelessWidget {
  final String json;

  const JsonResultShow({Key? key, this.json = ''}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('返回结果json展示'),
        actions: [
          IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: json));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Text(json)],
        ),
      ),
    );
  }
}

void toJsonView(dynamic result) {
  Get.to(() => JsonResultShow(
        json: jsonEncode(result),
      ));
}
