import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/data/cache_result.dart';
import '../../../../core/models/listing_model.dart';
import '../../data/listings_repository.dart';

class ListingsState {
  final List<ListingModel> listings;
  final bool isLoading;
  final bool isStale;
  final String? error;

  const ListingsState({
    this.listings = const [],
    this.isLoading = false,
    this.isStale = false,
    this.error,
  });
}

final listingsProvider =
    NotifierProvider<ListingsNotifier, ListingsState>(ListingsNotifier.new);

class ListingsNotifier extends Notifier<ListingsState> {
  @override
  ListingsState build() {
    load();
    return const ListingsState(isLoading: true);
  }

  Future<void> load({String? search, String? category}) async {
    state = const ListingsState(isLoading: true);
    try {
      final result = await ref
          .read(listingsRepositoryProvider)
          .getListings(search: search, category: category);
      state = ListingsState(
        listings: result.data,
        isStale: result.isStale,
      );
    } catch (e) {
      state = ListingsState(error: e.toString());
    }
  }
}

final listingDetailProvider =
    FutureProvider.family<CacheResult<ListingModel>, String>((ref, id) {
  return ref.read(listingsRepositoryProvider).getById(id);
});

final myListingsProvider = FutureProvider.autoDispose<List<ListingModel>>((ref) {
  return ref.read(listingsRepositoryProvider).getMyListings();
});

final createListingProvider =
    AsyncNotifierProvider<CreateListingNotifier, void>(CreateListingNotifier.new);

class CreateListingNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<ListingModel> createListing(Map<String, dynamic> body) async {
    state = const AsyncLoading();
    try {
      final item = await ref.read(listingsRepositoryProvider).create(body);
      ref.invalidate(listingsProvider);
      state = const AsyncData(null);
      return item;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
