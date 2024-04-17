import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/send_message_controller.dart';

class SendMessageView extends GetView<SendMessageController> {
  const SendMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Message'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.messageController,
              decoration: const InputDecoration(labelText: 'Message'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Assuming the receiver ID is obtained elsewhere
                // Replace 'RECEIVER_USER_ID' with the actual receiver's ID
                controller.sendMessage('RECEIVER_USER_ID');
              },
              child: Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : const Text('Send')),
            ),
          ],
        ),
      ),
    );
  }
}
