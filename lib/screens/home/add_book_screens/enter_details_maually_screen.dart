import 'dart:io';

import 'package:book/models/book.dart';
import 'package:book/models/location.dart';
import 'package:book/providers/change_notifier_provider.dart';
import 'package:book/providers/image_provider.dart';
import 'package:book/providers/location_providers.dart';
import 'package:book/providers/map_provider.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EnterDetailsManuallyScreen extends HookConsumerWidget {
  const EnterDetailsManuallyScreen({super.key});

  Future<void> addImage({
    required WidgetRef ref,
    required ImageSource imageSource,
    required ValueNotifier<List<XFile>> imagesState,
  }) async {
    XFile? image = await ref
        .read(imageProvider.notifier)
        .takePhoto(imageSource: ImageSource.camera);
    if (image != null) {
      imagesState.value = [...imagesState.value, image];
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final chipState = ref.watch(addBookChipChnageNotifierProvider);
    final location = ref.watch(myCurrentPosition);
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
    final imagesState = useState<List<XFile>>([]);
    final isDuration = useState<bool?>(null);
    final timeRangeState = useState<DateTimeRange?>(null);
    return Scaffold(
      appBar: const MyBackButtonAppBar(),
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                validator: (String? value) =>
                    value!.isEmpty ? 'Title can\'t be empty' : null,
              ),
              MyTextField(
                controller: authorController,
                labelText: 'Author',
                validator: (String? value) =>
                    value!.isEmpty ? 'Author can\'t be empty' : null,
              ),
              MyTextField(
                controller: bookDecriptionController,
                labelText: 'Book Decription',
                isMultiLine: true,
                validator: (String? value) =>
                    value!.isEmpty ? 'Book decription can\'t be empty' : null,
              ),
              MyTextField(
                controller: yourDecriptionController,
                labelText: 'Your Decription',
                isMultiLine: true,
                validator: (String? value) =>
                    value!.isEmpty ? 'Your decription can\'t be empty' : null,
              ),
              const WhiteTextTitle(text: 'Genres', isAddBook: true),
              Chips.wrapChips(true, ChipType.genre),
              const WhiteTextTitle(text: 'Language', isAddBook: true),
              Chips.wrapChips(true, ChipType.language),
              const WhiteTextTitle(text: 'Location', isAddBook: true),
              Container(
                height: 300,
                width: 100,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GoogleMap(
                  onMapCreated: (controller) async => await ref
                      .read(mapProvider.notifier)
                      .onMapCreated(controller: controller),
                  initialCameraPosition: CameraPosition(
                    target: location != null
                        ? LatLng(location.latitude, location.latitude)
                        : const LatLng(0, 0),
                  ),
                ),
              ),
              const WhiteTextTitle(
                text: 'Take up too 5 photos',
                isAddBook: true,
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  RowSubmitButton(
                    icon: Icons.camera_alt_outlined,
                    text: 'Camera',
                    onPressed: () async => await addImage(
                      imageSource: ImageSource.camera,
                      ref: ref,
                      imagesState: imagesState,
                    ),
                  ),
                  RowSubmitButton(
                    icon: Icons.photo_outlined,
                    text: 'Gallary',
                    onPressed: () async => await addImage(
                      imageSource: ImageSource.gallery,
                      ref: ref,
                      imagesState: imagesState,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              if (imagesState.value.isNotEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imagesState.value.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.file(File(imagesState.value[index].path)),
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
                                      onTap: () {
                                        imagesState.value.removeAt(index); //FIX
                                      },
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
                            validator: (String? value) =>
                                value!.isEmpty && sellState.value
                                    ? 'Price can\'t be empty'
                                    : null,
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
                      text: 'Leaseing Info',
                      isAddBook: true,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: MyTextField(
                            controller: leasingPriceController,
                            labelText: 'Lease Price',
                            keyBoardType: TextInputType.number,
                            validator: (String? value) =>
                                value!.isEmpty && rentState.value
                                    ? 'Price can\'t be empty'
                                    : null,
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
                                  builder:
                                      (BuildContext context, Widget? child) =>
                                          Theme(
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
                                validator: (String? value) => value!.isEmpty &&
                                        rentState.value &&
                                        isDuration.value!
                                    ? 'Duration can\'t be empty'
                                    : null,
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
                                ? Formats.formatTimeRange(
                                    Timestamp.fromDate(
                                      timeRangeState.value!.start,
                                    ),
                                    Timestamp.fromDate(
                                      timeRangeState.value!.end,
                                    ))
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
                onPressed: () async {
                  List<String> errors = [];
                  if (!(sellState.value ||
                      rentState.value ||
                      swapState.value)) {
                    errors.add('Either sell, rent or swap is required');
                  } else if (isDuration.value == null && rentState.value) {
                    errors
                        .add('Either lease duration or time range is required');
                  } else if (rentState.value &&
                      !isDuration.value! &&
                      timeRangeState.value == null) {
                    errors.add('Time range need to have a valid range');
                  }

                  if (chipState.tempState[ChipType.genre]!.isEmpty) {
                    errors.add('At least one genre is required');
                  }

                  if (chipState.tempState[ChipType.language]!.isEmpty) {
                    errors.add('One language is required');
                  }

                  if (!formKey.currentState!.validate()) {
                    errors.add('Form is not valid');
                  }

                  final location = MyLocation(
                    postalCode: '45',
                    country: 'Norway',
                    address: 'Norway',
                    city: 'Oslo',
                    latitude: 345,
                    longitude: 45,
                  );

                  if (errors.isEmpty) {
                    await Navigator.of(context).push(
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
                            location: location, //CAHANGE
                            position: location, //CAHANGE
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
                            rentPrice: rentState.value
                                ? double.tryParse(leasingPriceController.text)
                                : null,
                            rentDuration: isDuration.value!
                                ? int.tryParse(durationController.text)
                                : null,
                            rentStartDate: !isDuration.value!
                                ? Timestamp.fromDate(
                                    timeRangeState.value!.start,
                                  )
                                : null,
                            rentEndDate: !isDuration.value!
                                ? Timestamp.fromDate(
                                    timeRangeState.value!.end,
                                  )
                                : null,
                            createdAt: Timestamp.now(),
                            rating: null, //Implement correct rating
                            goodReadsLink: null,
                            languageCode: '', //Implement correct rating
                            genres: chipState.tempState[ChipType.genre]!
                                .map((e) => e.label)
                                .toList(),
                          ),
                          isPreview: true,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
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
