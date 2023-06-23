import 'package:book/style/colors.dart';
import 'package:book/widgets/heart_button.dart';
import 'package:book/widgets/my_back_button.dart';
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
          height: MediaQuery.of(context).size.height + 1000,
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
                    itemBuilder: (context, index) => Column(
                      children: [
                        Image.asset(
                          'lib/assets/images/3D_hipster.jpg',
                          key: GlobalKey(debugLabel: 'HipsterImage$index'),
                        ),
                      ],
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 1000,
                    color: MyColors.blue,
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
