import 'package:book/providers/book_providers.dart';
import 'package:book/providers/state_provider.dart';
import 'package:book/screens/home/explore_screen_widgets/book_card.dart';
import 'package:book/screens/home/explore_screen_widgets/chip_row_botton.dart';
import 'package:book/screens/home/explore_screen_widgets/filter_dialog.dart';
import 'package:book/style/colors.dart';
import 'package:book/widgets/error_widget.dart';
import 'package:book/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myBooks = ref.watch(allBooksProvider);
    return Scaffold(
      backgroundColor: MyColors.black,
      body: CustomScrollView(
        key: GlobalKey(debugLabel: 'Explore'),
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 20,
            backgroundColor: MyColors.black,
            expandedHeight: 210,
            collapsedHeight: 210,
            floating: true,
            bottom: const ChipRowBotton(),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MyColors.purple,
                    MyColors.blue,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Find your next favorite book',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 50,
                            constraints: BoxConstraints.expand(
                              width: MediaQuery.of(context).size.width - 100,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.darkGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onChanged: (value) => ref
                                  .read(queryTextProvider.notifier)
                                  .state = value,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: MyColors.darkGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () async => await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) =>
                                    const FilterDialog(),
                                elevation: 30,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor: MyColors.black,
                              ),
                              icon: const Icon(
                                Icons.filter_list_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          myBooks.when(
            error: (e, s) => SliverList(
              delegate: SliverChildListDelegate([
                MyErrorWidget(e: e, s: s),
              ]),
            ),
            loading: () => SliverList(
              delegate: SliverChildListDelegate([
                const LoadingWidget(),
              ]),
            ),
            data: (books) => SliverList.builder(
              itemCount: books.length,
              itemBuilder: (context, index) =>
                  BookCard(book: books[index], onTap: () {}), //FIX
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
