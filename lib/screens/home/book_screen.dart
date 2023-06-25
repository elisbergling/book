import 'dart:math';

import 'package:book/screens/auth/signup_screen_widgets/or_divider.dart';
import 'package:book/screens/home/book_screen_widgets/expandeble_text.dart';
import 'package:book/screens/home/book_screen_widgets/location_widget.dart';
import 'package:book/screens/home/book_screen_widgets/retail_type_circle.dart';
import 'package:book/style/colors.dart';
import 'package:book/widgets/action_button.dart';
import 'package:book/widgets/circular_button.dart';
import 'package:book/widgets/heart_button.dart';
import 'package:book/widgets/my_back_button.dart';
import 'package:book/widgets/white_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BookScreen extends HookWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final pageController = usePageController(initialPage: 0);
    final pictureIndexNotifier = useValueNotifier<int>(0);
    final backgroundTopOffset = useState(0.0);
    final showAllBookDescription = useState(false);
    final showAllInfoDescription = useState(false);
    final expandebleTextHigth = useState(0.0);

    useEffect(() {
      listener() {
        pictureIndexNotifier.value = pageController.page!.round();
      }

      pageController.addListener(listener);
      scrollController.addListener(
        () {
          backgroundTopOffset.value = scrollController.offset / 2;
        },
      );
      return () {
        pageController.removeListener(listener);
      };
    }, [pageController]);

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          height: MediaQuery.of(context).size.width +
              880 +
              expandebleTextHigth.value,
          child: Stack(
            children: [
              Positioned(
                top: backgroundTopOffset.value,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: 5,
                    itemBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'lib/assets/images/3D_hipster.jpg',
                        key: GlobalKey(debugLabel: 'HipsterImage$index'),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: backgroundTopOffset.value,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const MyBackButton(dark: true),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.darkGrey.withOpacity(0.7),
                      ),
                      child: ValueListenableBuilder<int>(
                        valueListenable: pictureIndexNotifier,
                        builder: (context, value, child) => Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                height: value == i ? 10 : 8,
                                width: value == i ? 10 : 8,
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: value == i
                                      ? MyColors.purple
                                      : MyColors.white.withOpacity(0.9),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const HeartButton(),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.width - 30,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    color: MyColors.black,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: MyColors.darkGrey,
                        offset: Offset(0, 20),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Title',
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'author',
                                style: TextStyle(
                                  color: MyColors.ligthGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                '4,4',
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: Colors.yellowAccent,
                              )
                            ],
                          ),
                        ],
                      ),
                      const WhiteTextTitle(text: 'Location'),
                      const LocationWidget(),
                      const WhiteTextTitle(text: 'Book Description'),
                      ExpandebleText(
                          showAllText: showAllBookDescription,
                          textHigth: expandebleTextHigth),
                      const WhiteTextTitle(text: 'Seller Info'),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: MyColors.darkGrey,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'lib/assets/images/3D_hipster.jpg',
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                          color: MyColors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      LocationWidget(isBig: false),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  CircularButton(
                                    icon: Icons.message_outlined,
                                    onPressed: () {},
                                    dark: false,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const WhiteTextTitle(text: 'Book Info'),
                      ExpandebleText(
                          showAllText: showAllInfoDescription,
                          textHigth: expandebleTextHigth),
                      const WhiteTextTitle(text: 'Sell Type'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          RetailTypeCircle(
                            icon: Icons.sell_outlined,
                            isSelected: true,
                          ),
                          RetailTypeCircle(
                            icon: Icons.timer_outlined,
                            isSelected: true,
                          ),
                          RetailTypeCircle(
                            icon: Icons.swap_horiz_rounded,
                            isSelected: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ActionButton(
                        text: 'Buy for 34kr',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      const OrDivider(),
                      const SizedBox(height: 10),
                      ActionButton(
                        text: 'Rent for 12kr',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      const OrDivider(),
                      const SizedBox(height: 10),
                      ActionButton(
                        text: 'Swap books',
                        onPressed: () {},
                      ),
                      //const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
