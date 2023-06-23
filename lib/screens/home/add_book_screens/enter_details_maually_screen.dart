import 'package:book/screens/home/add_book_screens/enter_dattails_manually_screen_widgets/row_submit_button.dart';
import 'package:book/screens/home/book_screen.dart';
import 'package:book/style/colors.dart';
import 'package:book/utils/chips.dart';
import 'package:book/utils/enums.dart';
import 'package:book/utils/routes.dart';
import 'package:book/widgets/my_text_field.dart';
import 'package:book/widgets/my_back_button_app_bar.dart';
import 'package:book/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EnterDetailsManuallyScreen extends HookWidget {
  const EnterDetailsManuallyScreen({super.key});

  String formatDateTime(DateTimeRange time) {
    String start = time.start.toString().split(' ')[0];
    String end = time.end.toString().split(' ')[0];
    return '$start to $end';
  }

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final authorController = useTextEditingController();
    final bookDecriptionController = useTextEditingController();
    final yourDecriptionController = useTextEditingController();
    final sellingPriceController = useTextEditingController();
    final leasingPriceController = useTextEditingController();
    final durationController = useTextEditingController();
    final sellState = useState(false);
    final leaseState = useState(false);
    final swapState = useState(false);
    final isDuration = useState<bool?>(null);
    final timeRangeState = useState<DateTimeRange?>(null);
    return Scaffold(
      appBar: const MyBackButtonAppBar(),
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyTextField(
              controller: titleController,
              labelText: 'Title',
            ),
            MyTextField(
              controller: authorController,
              labelText: 'Author',
            ),
            MyTextField(
              controller: bookDecriptionController,
              labelText: 'Book Decription',
              isMultiLine: true,
            ),
            MyTextField(
              controller: yourDecriptionController,
              labelText: 'Your Decription',
              isMultiLine: true,
            ),
            const SizedBox(height: 10),
            const Text(
              'Genres:',
              style: TextStyle(color: MyColors.white),
            ),
            const SizedBox(height: 10),
            Chips.wrapChips(true, ChipType.genre),
            const SizedBox(height: 10),
            const Text(
              'Language:',
              style: TextStyle(color: MyColors.white),
            ),
            const SizedBox(height: 10),
            Chips.wrapChips(true, ChipType.language),
            const SizedBox(height: 20),
            const Text(
              'Take up too 5 photos',
              style: TextStyle(color: MyColors.white),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            const Text(
              'Select Type:',
              style: TextStyle(color: MyColors.white),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                RowSubmitButton(
                  onPressed: () => sellState.value = !sellState.value,
                  icon: Icons.sell_outlined,
                  text: 'Sell',
                  isFilled: sellState.value,
                ),
                RowSubmitButton(
                  onPressed: () => leaseState.value = !leaseState.value,
                  icon: Icons.timer_outlined,
                  text: 'Lease',
                  isFilled: leaseState.value,
                ),
                RowSubmitButton(
                  onPressed: () => swapState.value = !swapState.value,
                  icon: Icons.swap_horiz_rounded,
                  text: 'Swap',
                  isFilled: swapState.value,
                ),
              ],
            ),
            if (sellState.value)
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
            if (leaseState.value)
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
            if (leaseState.value)
              Row(
                children: [
                  const SizedBox(width: 20),
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
                                  primary: MyColors
                                      .purple, // header background color
                                  onPrimary:
                                      MyColors.white, // header text color
                                  surface: MyColors.black, // body text color
                                  onSurface: MyColors.white, // body text color
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
                  const SizedBox(width: 20),
                ],
              ),
            if (isDuration.value != null && leaseState.value)
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
                    : Text(
                        timeRangeState.value != null
                            ? formatDateTime(timeRangeState.value!)
                            : 'Pick a Valid Time',
                        style: const TextStyle(color: MyColors.white),
                      ),
              ),
            SubmitButton(
              onPressed: () => Navigator.of(context)
                  .push(MyRoutes.fromRigth(const BookScreen())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Preview',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      color: MyColors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
