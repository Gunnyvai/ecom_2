import 'dart:convert';
import 'package:ecom_2/app/model/message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MessageController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var messages = <Message>[].obs; // Observable list to store messages

  Future<void> fetchMessages(int receiverId) async {
    try {
      isLoading.value = true; // Set loading state
      errorMessage.value = ''; // Clear previous error messages

      final response = await http.post(
        Uri.http('ecom2_api', 'receiveMessage'),
        body: {'receiver_id': receiverId.toString()},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success']) {
          List<dynamic> messageData = data['data'];
          messages.assignAll(messageData
              .map((item) => Message.fromJson(item))); // Update messages list
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to fetch messages');
      }
    } catch (e) {
      errorMessage.value = 'Error: $e'; // Set error message
      throw Exception('Error: $e');
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }
}
