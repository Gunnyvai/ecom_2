import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class SendMessageController extends GetxController {
  TextEditingController messageController = TextEditingController();
  var isLoading = false.obs;

  void sendMessage(String receiverId) async {
    try {
      isLoading.value = true;
      String message = messageController.text;
      String url = 'ecom2_api/sendMessage';
      var body = jsonEncode({'receiverId': receiverId, 'message': message});
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Message sent successfully');
      } else {
        Get.snackbar('Error', 'Failed to send message. Please try again.');
      }
    } catch (e) {
      print('Error sending message: $e'); // Print out the error message
      Get.snackbar('Error', 'An unexpected error occurred.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
