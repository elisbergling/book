import 'package:book/models/book.dart';
import 'package:book/style/colors.dart';
import 'package:book/widgets/heart_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({
    required this.book,
    Key? key,
    required Null Function() onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.darkGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CachedNetworkImage(
                      imageUrl: book.imageUrl,
                      fit: BoxFit.fitHeight,
                      errorWidget: (_, __, ___) => Container(
                        height: (MediaQuery.of(context).size.width - 60),
                        width: 1000,
                        color: MyColors.blue,
                        child: const Icon(
                          Icons.error,
                          color: MyColors.ligthGrey,
                        ),
                      ),
                    ),
                    const Positioned(top: 10, right: 10, child: HeartButton()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              book.author,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: MyColors.ligthGrey,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.attach_money,
                  color: MyColors.ligthGrey,
                  size: 18,
                ),
                Text(
                  book.price.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: MyColors.ligthGrey,
                  ),
                ),
                Expanded(child: Container()),
                const Icon(
                  Icons.social_distance_outlined,
                  color: MyColors.ligthGrey,
                  size: 18,
                ),
                const SizedBox(width: 4),
                const Text(
                  "5km",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.ligthGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
