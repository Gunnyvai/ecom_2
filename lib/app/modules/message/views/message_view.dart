import 'package:ecom_2/app/model/message.dart';
import 'package:ecom_2/app/modules/message/controllers/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final MessageController _messageController = Get.find<MessageController>();
  late int userId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    userId = args?['userId'] as int ??
        0; // Provide a default value if userId is null
    _messageController.fetchMessages(userId); // Initiate fetching messages
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages for User $userId'),
      ),
      body: Obx(() {
        if (_messageController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (_messageController.errorMessage.isNotEmpty) {
          return Center(
              child: Text('Error: ${_messageController.errorMessage}'));
        } else {
          List<Message>? messages = _messageController.messages.toList();
          return messages != null && messages.isNotEmpty
              ? ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Message message = messages[index];
                    return ListTile(
                      title: Text(message.content),
                      subtitle: Text(message.timestamp),
                    );
                  },
                )
              : Center(child: Text('No messages found'));
        }
      }),
    );
  }
}
