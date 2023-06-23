import 'package:flutter/material.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  MessagingScreenState createState() => MessagingScreenState();
}

class MessagingScreenState extends State<MessagingScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Message> _messages = [
    Message(
      sender: 'Tom',
      text: 'Hey, how are you?',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: 'John',
      text: 'Hi Tom, I\'m good, thanks. How about you?',
      time: DateTime.now().subtract(const Duration(minutes: 2)),
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: 'Tom',
      text: 'I\'m good too, thanks for asking.',
      time: DateTime.now().subtract(const Duration(minutes: 1)),
      isLiked: false,
      unread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xffF8F8F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Tom',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
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
                    controller: _controller,
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
                    final text = _controller.text;
                    _controller.clear();
                    setState(() {
                      _messages.insert(
                        0,
                        Message(
                          sender: 'Me',
                          text: text,
                          time: DateTime.now(),
                          isLiked: false,
                          unread: true,
                        ),
                      );
                    });
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

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgGradient = message.isMe
        ? [Colors.blue[800]!, Colors.blue[600]!]
        : [Colors.grey[300]!, Colors.grey[300]!];

    final messageTextStyle = TextStyle(
      color: message.isMe ? Colors.white : Colors.black,
      fontSize: 16,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: bgGradient,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: message.isMe
              ? const Radius.circular(20)
              : const Radius.circular(0),
          bottomRight: message.isMe
              ? const Radius.circular(0)
              : const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.text,
            style: messageTextStyle,
          ),
          const SizedBox(height: 4),
          Text(
            message.time.toString(),
            style: TextStyle(
              color: message.isMe ? Colors.white54 : Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final DateTime time;
  final bool isLiked;
  final bool unread;
  bool get isMe => sender == 'Me';

  Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.isLiked,
    required this.unread,
  });
}
