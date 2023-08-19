import 'package:book/models/book.dart';
import 'package:book/models/service_data.dart';
import 'package:book/services/book_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bookProvider = NotifierProvider<BookService, ServiceData>(() {
  return BookService();
});

final queryBooksProvider = StreamProvider<List<Book>>((ref) {
  return ref.watch(bookProvider.notifier).queryBooksStream();
});

final allBooksProvider = StreamProvider<List<Book>>((ref) {
  return ref.watch(bookProvider.notifier).booksStream();
});

final myBooksProvider = StreamProvider<List<Book>>((ref) {
  return ref.watch(bookProvider.notifier).myBooksStream();
});
