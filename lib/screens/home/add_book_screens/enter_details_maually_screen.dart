import 'package:book/mock/mock_locations.dart';
import 'package:book/models/book.dart';
import 'package:book/screens/home/add_book_screens/enter_dattails_manually_screen_widgets/row_submit_button.dart';
import 'package:book/screens/home/book_screen.dart';
import 'package:book/style/colors.dart';
import 'package:book/utils/chips.dart';
import 'package:book/utils/enums.dart';
import 'package:book/utils/formats.dart';
import 'package:book/utils/routes.dart';
import 'package:book/widgets/action_button.dart';
import 'package:book/widgets/my_text_field.dart';
import 'package:book/widgets/my_back_button_app_bar.dart';
import 'package:book/widgets/white_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EnterDetailsManuallyScreen extends HookWidget {
  const EnterDetailsManuallyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final titleController = useTextEditingController();
    final authorController = useTextEditingController();
    final bookDecriptionController = useTextEditingController();
    final yourDecriptionController = useTextEditingController();
    final sellingPriceController = useTextEditingController();
    final leasingPriceController = useTextEditingController();
    final durationController = useTextEditingController();
    final scrollController = useScrollController();
    final sellState = useState(false);
    final rentState = useState(false);
    final swapState = useState(false);
    final isDuration = useState<bool?>(null);
    final timeRangeState = useState<DateTimeRange?>(null);
    return Scaffold(
      appBar: const MyBackButtonAppBar(),
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WhiteTextTitle(text: 'Book Info', isAddBook: true),
              MyTextField(
                controller: titleController,
                labelText: 'Title',
                validator: (value) =>
                    value!.isEmpty ? 'Title can\'t be empty' : null,
              ),
              MyTextField(
                controller: authorController,
                labelText: 'Author',
                validator: (value) =>
                    value!.isEmpty ? 'Author can\'t be empty' : null,
              ),
              MyTextField(
                controller: bookDecriptionController,
                labelText: 'Book Decription',
                isMultiLine: true,
                validator: (value) =>
                    value!.isEmpty ? 'Book decription can\'t be empty' : null,
              ),
              MyTextField(
                controller: yourDecriptionController,
                labelText: 'Your Decription',
                isMultiLine: true,
                validator: (value) =>
                    value!.isEmpty ? 'Your decription can\'t be empty' : null,
              ),
              const WhiteTextTitle(text: 'Genres', isAddBook: true),
              Chips.wrapChips(true, ChipType.genre),
              const WhiteTextTitle(text: 'Language', isAddBook: true),
              Chips.wrapChips(true, ChipType.language),
              const WhiteTextTitle(
                  text: 'Take up too 5 photos', isAddBook: true),
              Row(
                children: [
                  const SizedBox(width: 20),
                  RowSubmitButton(
                    icon: Icons.camera_alt_outlined,
                    onPressed: () {},
                    text: 'Camera',
                  ),
                  RowSubmitButton(
                    icon: Icons.photo_outlined,
                    onPressed: () {},
                    text: 'Gallary',
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Image.asset('lib/assets/images/3D_hipster.jpg'),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Material(
                                  color: MyColors.darkGrey.withOpacity(0.5),
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.close_rounded,
                                      size: 15,
                                      color: MyColors.ligthGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const WhiteTextTitle(text: 'Select Type', isAddBook: true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    RowSubmitButton(
                      onPressed: () async {
                        sellState.value = !sellState.value;
                      },
                      icon: Icons.sell_outlined,
                      text: 'Sell',
                      isFilled: sellState.value,
                    ),
                    RowSubmitButton(
                      onPressed: () => rentState.value = !rentState.value,
                      icon: Icons.timer_outlined,
                      text: 'Lease',
                      isFilled: rentState.value,
                    ),
                    RowSubmitButton(
                      onPressed: () => swapState.value = !swapState.value,
                      icon: Icons.swap_horiz_rounded,
                      text: 'Swap',
                      isFilled: swapState.value,
                    ),
                  ],
                ),
              ),
              if (sellState.value)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WhiteTextTitle(text: 'Selling Info', isAddBook: true),
                    Row(
                      children: [
                        Flexible(
                          child: MyTextField(
                            controller: sellingPriceController,
                            labelText: 'Selling Price',
                            keyBoardType: TextInputType.number,
                          ),
                        ),
                        const Text(
                          'kr',
                          style: TextStyle(color: MyColors.white),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              if (rentState.value)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WhiteTextTitle(
                        text: 'Leaseing Info', isAddBook: true),
                    Row(
                      children: [
                        Flexible(
                          child: MyTextField(
                            controller: leasingPriceController,
                            labelText: 'Lease Price',
                            keyBoardType: TextInputType.number,
                          ),
                        ),
                        const Text(
                          'kr',
                          style: TextStyle(color: MyColors.white),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        RowSubmitButton(
                          onPressed: () => isDuration.value = true,
                          icon: Icons.timer_outlined,
                          text: 'Duration',
                          isFilled: isDuration.value == true,
                        ),
                        RowSubmitButton(
                          onPressed: () async {
                            DateTime now = DateTime.now();
                            timeRangeState.value = await showDateRangePicker(
                                  context: context,
                                  firstDate: now,
                                  lastDate: now.copyWith(year: now.year + 1),
                                  initialDateRange: timeRangeState.value,
                                  builder: (context, child) => Theme(
                                    data: ThemeData.dark().copyWith(
                                      colorScheme: const ColorScheme.dark(
                                        primary: MyColors.purple,
                                        onPrimary: MyColors.white,
                                        surface: MyColors.black,
                                        onSurface: MyColors.white,
                                      ),
                                    ),
                                    child: child!,
                                  ),
                                ) ??
                                timeRangeState.value;
                            isDuration.value = false;
                          },
                          icon: Icons.date_range,
                          text: 'Time Range',
                          isFilled: isDuration.value == false,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              if (isDuration.value != null && rentState.value)
                Container(
                  child: isDuration.value!
                      ? Row(
                          children: [
                            Flexible(
                              child: MyTextField(
                                controller: durationController,
                                labelText: 'Lease Duration',
                                keyBoardType: TextInputType.number,
                              ),
                            ),
                            const Text(
                              'days',
                              style: TextStyle(color: MyColors.white),
                            ),
                            const SizedBox(width: 20),
                          ],
                        )
                      : Center(
                          child: Text(
                            timeRangeState.value != null
                                ? Formats.formatTimeRange(timeRangeState.value!)
                                : 'Pick a Valid Time',
                            style: const TextStyle(
                              color: MyColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              const SizedBox(height: 20),
              ActionButton(
                text: 'Preview',
                onPressed: () {
                  List<String> errors = [];
                  if (!(sellState.value ||
                      rentState.value ||
                      swapState.value)) {
                    errors.add('Either sell, rent or swap is required');
                  }
                  if (isDuration.value == null && rentState.value) {
                    errors
                        .add('Either lease duration or time range is required');
                  }

                  if (!formKey.currentState!.validate()) {
                    errors.add('Form is not valid');
                  }

                  if (errors.isEmpty) {
                    Navigator.of(context).push(
                      MyRoutes.fromRigth(
                        BookScreen(
                          book: Book(
                            id: '0', //Implement correct ID
                            title: titleController.text,
                            author: authorController.text,
                            images: [
                              'lib/assets/images/3D_hipster.jpg',
                              'lib/assets/images/3D_hipster.jpg',
                              'lib/assets/images/3D_hipster.jpg',
                            ],
                            location: mockLocations[0],
                            bookDescription: bookDecriptionController.text,
                            ownerUid: 'MYUID', //Implement correct UID
                            bookInfo: yourDecriptionController.text,
                            isSell: sellState.value,
                            isRent: rentState.value,
                            isSwap: swapState.value,
                            likedUids: [],
                            sellPrice: sellState.value
                                ? double.tryParse(sellingPriceController.text)
                                : null,
                            leasePrice: rentState.value
                                ? double.tryParse(leasingPriceController.text)
                                : null,
                            leaseDuration: isDuration.value!
                                ? int.tryParse(durationController.text)
                                : null,
                            leaseTimeRange: !isDuration.value!
                                ? timeRangeState.value
                                : null,
                          ),
                          isPreview: true,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: MyColors.darkGrey,
                        content: Column(
                          children: [
                            for (String error in errors)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  error,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                    errors.clear();
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
