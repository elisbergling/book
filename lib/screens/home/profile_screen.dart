import 'package:book/mock/mock_books.dart';
import 'package:book/screens/home/explore_screen_widgets/book_card.dart';
import 'package:book/screens/home/profile_screen_widgets/my_divider.dart';
import 'package:book/screens/home/profile_screen_widgets/my_sliver_persistent_header_delegate.dart';
import 'package:book/screens/home/profile_screen_widgets/profile_numbers.dart';
import 'package:book/screens/home/profile_screen_widgets/profile_wave_shape_border.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  static const double gapHeigth = 150;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final columnController = useScrollController();
    final backgroundBottomOffset = useState(0.0);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.offset < gapHeigth) {
          columnController.jumpTo(scrollController.offset / 2);
          backgroundBottomOffset.value = -scrollController.offset / 4;
        } else if (scrollController.offset < 380) {
          columnController.jumpTo(scrollController.offset - gapHeigth / 2);
        }
      });
      return () {};
    }, []);

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPersistentHeader(
              floating: false,
              delegate: MySliverPersistentHeaderDelegate(
                minHeight: 0,
                maxHeight: 380,
                gapHeigth: gapHeigth,
                shapeBorder: const ProfileWaveShapeBorder(
                  gapHeigth: gapHeigth,
                ),
                background: Positioned(
                  bottom: backgroundBottomOffset.value,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyColors.blue, MyColors.purple],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        ProfileNumbers(
                          title: 'My Books',
                          amount: 12,
                        ),
                        MyDivider(),
                        ProfileNumbers(
                          title: 'Liked',
                          amount: 16,
                        ),
                        MyDivider(),
                        ProfileNumbers(
                          title: 'Following',
                          amount: 3,
                        ),
                        MyDivider(),
                        ProfileNumbers(
                          title: 'Followers',
                          amount: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                foreground: SingleChildScrollView(
                  controller: columnController,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 380,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50.0),
                        const CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/9919?v=4'),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Github User',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'githubuser@example.com',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: mockBooks.length,
                (context, index) =>
                    BookCard(book: mockBooks[index], onTap: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
