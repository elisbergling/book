import 'package:book/providers/auth_provider.dart';
import 'package:book/providers/message_provider.dart';
import 'package:book/providers/user_provider.dart';
import 'package:book/style/colors.dart';
import 'package:book/widgets/cached_image.dart';
import 'package:book/widgets/error_widget.dart';
import 'package:book/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessagesScreen extends HookConsumerWidget {
  const MessagesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(conversationStreamProvider);
    final uid = ref.watch(firebaseAuthProvider).currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.black,
        title: const Text(
          'Messages',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
      ),
      body: conversations.when(
        error: (e, s) => MyErrorWidget(e: e, s: s),
        loading: () => const LoadingWidget(),
        data: (users) => users.isNotEmpty
            ? ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ref.watch(fetchLastMessageProvider(user.uid)).when(
                        loading: () => const LoadingWidget(),
                        error: (e, s) => MyErrorWidget(e: e, s: s),
                        data: (message) => ListTile(
                          tileColor: MyColors.black,
                          leading: CachedImage(
                            dimension: 40,
                            imageUrl: user.profileImageUrl,
                            name: user.name,
                          ),
                          title: Text(
                            user.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(message?.text ?? 'Picture'),
                          trailing: Container(
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(
                              color: message != null &&
                                      !message.isRead &&
                                      !message.isMe(uid)
                                  ? MyColors.purple
                                  : MyColors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message != null
                                  ? timeago.format(message.time.toDate())
                                  : '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                },
              )
            : const Center(
                child: Text(
                  'You have no ongoing conversations',
                  style: TextStyle(
                    color: MyColors.ligthGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
