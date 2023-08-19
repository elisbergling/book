import 'package:book/models/user.dart';
import 'package:book/providers/image_provider.dart';
import 'package:book/providers/message_provider.dart';
import 'package:book/screens/home/messageing_screen_widgets.dart/messaging_bubble.dart';
import 'package:book/style/colors.dart';
import 'package:book/widgets/error_widget.dart';
import 'package:book/widgets/loading_widget.dart';
import 'package:book/widgets/my_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MessagingScreen extends HookConsumerWidget {
  const MessagingScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final MyUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final messages = ref.watch(messagesStreamProvider(user.uid));
    final photo = useState<XFile?>(null);
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
            child: messages.when(
              error: (e, s) => MyErrorWidget(e: e, s: s),
              loading: () => const LoadingWidget(),
              data: (messages) => ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) =>
                    MessageBubble(message: messages[index]),
              ),
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
                  onPressed: () async => photo.value = await ref
                      .read(imageProvider.notifier)
                      .takePhoto(imageSource: ImageSource.camera),
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
                  onPressed: () async {
                    controller.clear();
                    await ref.read(messageProvider.notifier).createMessage(
                          text: controller.text,
                          photo: photo.value,
                          uidTo: user.uid,
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
