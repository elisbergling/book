import 'package:book/models/message.dart';
import 'package:book/models/user.dart';
import 'package:book/screens/home/messageing_screen_widgets.dart/messaging_bubble.dart';
import 'package:book/style/colors.dart';
import 'package:book/widgets/my_back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MessagingScreen extends HookWidget {
  const MessagingScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final MyUser user;

  static final List<Message> _messages = [
    Message(
      text: 'Hey, how are you?',
      time: Timestamp.now(),
      isLiked: false,
      id: '',
      isRead: false,
      photoUrl: null,
      uidFrom: '5',
      uidTo: '4',
    ),
    Message(
      text: 'Hi Tom, I\'m good, thanks. How about you?',
      time: Timestamp.now(),
      isLiked: false,
      id: '',
      isRead: false,
      photoUrl: null,
      uidFrom: '5',
      uidTo: '4',
    ),
    Message(
      text: 'Hi Tom, I\'m good, thanks. How about you?',
      time: Timestamp.now(),
      isLiked: false,
      id: '',
      isRead: false,
      photoUrl: null,
      uidFrom: '5',
      uidTo: '4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();
    final messages = useState(_messages);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const MyBackButton(),
        title: Row(
          children: [
            const CircleAvatar(backgroundColor: MyColors.green, radius: 15),
            const SizedBox(width: 10),
            Text(
              user.name,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 60,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.photo_camera,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Send a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    controller.clear();
                    messages.value.insert(
                      0,
                      Message(
                        text: controller.text,
                        time: Timestamp.now(),
                        isLiked: false,
                        id: '',
                        isRead: false,
                        photoUrl: null,
                        uidFrom: '5',
                        uidTo: '4',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
