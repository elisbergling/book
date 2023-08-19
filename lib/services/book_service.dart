import 'package:book/models/book.dart';
import 'package:book/providers/auth_provider.dart';
import 'package:book/providers/change_notifier_provider.dart';
import 'package:book/providers/location_providers.dart';
import 'package:book/providers/providers.dart';
import 'package:book/providers/state_provider.dart';
import 'package:book/services/service_notifier.dart';
import 'package:book/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookService extends ServiceNotifier {
  late final String? uid = ref.watch(firebaseAuthProvider).currentUser?.uid;

  late final CollectionReference bookCollection =
      ref.watch(firebaseFirestoreProvider).collection('books');

  final GeoFlutterFire geo = GeoFlutterFire();

  Future<void> addBook({required Book book}) async {
    try {
      toggleLoading();
      return await bookCollection.doc(book.id).set(book.toMap());
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Future<void> remvoeBook({required String id}) async {
    try {
      toggleLoading();
      return await bookCollection.doc(id).delete();
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Future<void> updateBook({required Book book}) async {
    try {
      toggleLoading();
      return await bookCollection.doc(book.id).update(book.toMap());
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Stream<List<Book>> myBooksStream() {
    try {
      return bookCollection
          .where('ownerUid', isEqualTo: uid)
          .snapshots()
          .map((event) => event.docs.map((e) => Book.fromMap(e)).toList());
    } catch (e) {
      setError(e);
      return Stream.value([]);
    }
  }

  Stream<List<Book>> myLikedBooksStream() {
    try {
      return bookCollection
          .where('likedUids', arrayContains: uid)
          .snapshots()
          .map((event) => event.docs.map((e) => Book.fromMap(e)).toList());
    } catch (e) {
      setError(e);
      return Stream.value([]);
    }
  }

  Stream<List<Book>> booksStream() {
    try {
      return bookCollection
          .snapshots()
          .map((event) => event.docs.map((e) => Book.fromMap(e)).toList());
    } catch (e) {
      setError(e);
      return Stream.value([]);
    }
  }

  Stream<List<Book>> queryBooksStream() {
    try {
      toggleLoading();

      final chipState = ref.read(chipChnageNotifierProvider.notifier);
      final sliderState = ref.read(sliderChnageNotifierProvider.notifier);
      final query = ref.read(queryTextProvider.notifier).state;
      final isBuy = ref.read(isBuyProvider.notifier).state;
      final isRent = ref.read(isRentProvider.notifier).state;
      final isSwap = ref.read(isSwapProvider.notifier).state;

      final searchQuery = query.isNotEmpty
          ? bookCollection
              .where(
                'author',
                isGreaterThanOrEqualTo: _greaterThan(),
                isLessThan: _lessThan(),
              )
              .where(
                'title',
                isGreaterThanOrEqualTo: _greaterThan(),
                isLessThan: _lessThan(),
              )
          : bookCollection;

      final buyQuery =
          isBuy ? searchQuery.where('isSell', isEqualTo: true) : searchQuery;
      final rentQuery =
          isRent ? buyQuery.where('isRent', isEqualTo: true) : buyQuery;
      final swapQuery =
          isSwap ? rentQuery.where('isSwap', isEqualTo: true) : rentQuery;
      final languageQuery = chipState.realState[ChipType.language]!.isNotEmpty
          ? swapQuery.where('languageCode',
              whereIn: chipState.realState[ChipType.language])
          : swapQuery;
      final genresQuery = chipState.realState[ChipType.genre]!.isNotEmpty
          ? languageQuery.where('genres',
              arrayContainsAny: chipState.realState[ChipType.genre])
          : languageQuery;

      final ratingQuery =
          genresQuery.where('rating', isGreaterThan: sliderState.rating);

      final orderQuery =
          ratingQuery.orderBy(_orderByType(), descending: _isDecreasing());

      final stream = geo
          .collection(collectionRef: orderQuery)
          .within(
            center: _center(),
            radius: sliderState.distance,
            field: 'position',
          )
          .map((value) => value.map((e) => Book.fromMap(e)).toList());

      return stream;
    } catch (e) {
      setError(e);
      return Stream.value([]);
    }
  }

  GeoFirePoint _center() {
    Position? pos = ref.read(myCurrentPosition);
    if (pos == null) {
      ref.read(currentPosition).when(
            data: (data) => pos = data,
            error: (e, s) => throw Exception(e),
            loading: () {},
          );
    }

    GeoFirePoint center;
    if (pos != null) {
      center = geo.point(latitude: pos!.latitude, longitude: pos!.longitude);
    } else {
      center = geo.point(latitude: 0, longitude: 0);
    }

    return center;
  }

  Object? _greaterThan() {
    final query = ref.read(queryTextProvider.notifier).state;
    return query.isEmpty ? 0 : query;
  }

  Object? _lessThan() {
    final query = ref.read(queryTextProvider.notifier).state;
    return query.isEmpty
        ? null
        : query.substring(0, query.length - 1) +
            String.fromCharCode(
              query.codeUnitAt(query.length - 1) + 1,
            );
  }

  String? _orderBy({required int index}) {
    final chipState = ref.read(chipChnageNotifierProvider.notifier);
    final orderBy = chipState.realState[ChipType.sortBy]!
        .map((e) => e.label)
        .single
        .split(' ');
    return orderBy[index];
  }

  String _orderByType() {
    String orderByString = 'createdAt';
    switch (_orderBy(index: 0)) {
      case 'Price':
      case 'Distance':
        orderByString = 'location.';
        break;
      case 'Rating':
        orderByString = 'rating';
        break;
      case 'Popularity':
        orderByString = 'popularity';
        break;
      case 'Date':
        orderByString = 'createdAt';
        break;
    }
    return orderByString;
  }

  bool _isDecreasing() {
    return _orderBy(index: 1) == 'Decreasing';
  }
}
