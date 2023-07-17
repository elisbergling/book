import 'package:book/models/book.dart';
import 'package:book/screens/auth/signup_screen_widgets/or_divider.dart';
import 'package:book/screens/home/book_screen_widgets/expandeble_text.dart';
import 'package:book/screens/home/book_screen_widgets/location_widget.dart';
import 'package:book/screens/home/book_screen_widgets/retail_type_circle.dart';
import 'package:book/screens/home/book_screen_widgets/seller_info_card.dart';
import 'package:book/screens/home/explore_screen_widgets/my_text_button.dart';
import 'package:book/style/colors.dart';
import 'package:book/widgets/heart_button.dart';
import 'package:book/widgets/my_back_button.dart';
import 'package:book/widgets/white_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BookScreen extends HookWidget {
  const BookScreen({
    super.key,
    required this.book,
    this.isPreview = false,
  });

  final Book book;
  final bool isPreview;

  void updateColumnHight(GlobalKey key, ValueNotifier<double?> hight) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    hight.value = renderBox.size.height;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey columnKey = GlobalKey();
    final scrollController = useScrollController();
    final pageController = usePageController(initialPage: 0);
    final pictureIndexNotifier = useValueNotifier<int>(0);
    final backgroundTopOffset = useState(0.0);
    final showAllBookDescription = useState(false);
    final showAllInfoDescription = useState(false);
    final hightState = useState<double>(0);

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
          height: MediaQuery.of(context).size.width + hightState.value + 10,
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
                    itemCount: book.images.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        book.images[index],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: backgroundTopOffset.value +
                    MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const MyBackButton(dark: true),
                    if (book.images.length != 1)
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
                              for (int i = 0; i < book.images.length; i++)
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
                  child: LayoutBuilder(builder: (context, constraints) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      updateColumnHight(columnKey, hightState);
                    });
                    return Column(
                      key: columnKey,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: const TextStyle(
                                      color: MyColors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    book.author,
                                    style: const TextStyle(
                                      color: MyColors.ligthGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Row(
                              children: [
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
                        LocationWidget(text: book.location.country),
                        const WhiteTextTitle(text: 'Book Description'),
                        ExpandebleText(
                          text: book.bookDescription,
                          showAllText: showAllBookDescription,
                        ),
                        const WhiteTextTitle(text: 'Seller Info'),
                        SellerInfoCard(isPreview: isPreview),
                        const WhiteTextTitle(text: 'Book Info'),
                        ExpandebleText(
                          text: book.bookInfo,
                          showAllText: showAllInfoDescription,
                        ),
                        const WhiteTextTitle(text: 'Sell Type'),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RetailTypeCircle(
                              icon: Icons.sell_outlined,
                              isSelected: book.isSell,
                            ),
                            RetailTypeCircle(
                              icon: Icons.timer_outlined,
                              isSelected: book.isRent,
                            ),
                            RetailTypeCircle(
                              icon: Icons.swap_horiz_rounded,
                              isSelected: book.isSwap,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (book.isSell)
                          Row(
                            children: [
                              MyTextButton(
                                onPressed: () {},
                                text: 'Buy for ${book.sellPrice!.round()} kr',
                                isFilled: true,
                              ),
                            ],
                          ),
                        if ((book.isSell && book.isRent) ||
                            (book.isSell && book.isSwap))
                          const OrDivider(),
                        if (book.isRent)
                          Row(
                            children: [
                              MyTextButton(
                                onPressed: () {},
                                text:
                                    'Rent for ${book.leasePrice!.round()} kr ${book.leaseTime}',
                                isFilled: true,
                              ),
                            ],
                          ),
                        if (book.isSwap && book.isRent) const OrDivider(),
                        if (book.isSwap)
                          Row(
                            children: [
                              MyTextButton(
                                onPressed: () {},
                                text: 'Swap',
                                isFilled: true,
                              ),
                            ],
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
