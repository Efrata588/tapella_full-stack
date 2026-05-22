import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/data/cache_result.dart';
import '../../../../core/models/listing_model.dart';
import '../../data/listings_repository.dart';

part 'listings_provider.g.dart';

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

@riverpod
class ListingsNotifier extends _$ListingsNotifier {
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

@riverpod
Future<CacheResult<ListingModel>> listingDetail(Ref ref, String id) {
  return ref.read(listingsRepositoryProvider).getById(id);
}

@riverpod
Future<List<ListingModel>> myListings(Ref ref) {
  return ref.read(listingsRepositoryProvider).getMyListings();
}

@riverpod
class CreateListingNotifier extends _$CreateListingNotifier {
  @override
  Future<void> build() async {}

  Future<ListingModel> createListing(Map<String, dynamic> body) async {
    state = const AsyncLoading();
    try {
      final item = await ref.read(listingsRepositoryProvider).create(body);
      ref.invalidate(listingsNotifierProvider);
      state = const AsyncData(null);
      return item;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
