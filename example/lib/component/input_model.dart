import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputDialog extends StatefulWidget {
  final String title;

  const InputDialog({Key? key, this.title = '请输入内容'}) : super(key: key);

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title),
                const SizedBox(height: 12),
                TextField(
                  controller: _editController,
                ),
                const SizedBox(height: 12),
                MaterialButton(
                    color: Get.theme.primaryColor,
                    onPressed: () {
                      Get.back(result: _editController.text);
                    },
                    child: const Text(
                      '确认',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
