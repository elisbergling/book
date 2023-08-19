import 'package:book/models/message.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> bgGradient = !message.isMe('7')
        ? <Color>[MyColors.blue, MyColors.purple]
        : <Color>[MyColors.darkGrey, MyColors.darkGrey];

    final TextStyle messageTextStyle = TextStyle(
      color: message.isMe('8')
          ? Colors.white
          : const Color.fromARGB(210, 242, 242, 242),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: bgGradient,
          begin: const Alignment(-2, -2),
          end: const Alignment(2, 2),
        ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: message.isMe('4')
              ? const Radius.circular(20)
              : const Radius.circular(5),
          bottomRight: message.isMe('4')
              ? const Radius.circular(5)
              : const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: message.isMe('4')
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            message.text,
            style: messageTextStyle,
          ),
          const SizedBox(height: 4),
          Text(
            message.time.toString(),
            style: TextStyle(
              color: message.isMe('4')
                  ? const Color.fromARGB(160, 242, 242, 242)
                  : const Color.fromARGB(127, 242, 242, 242),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
