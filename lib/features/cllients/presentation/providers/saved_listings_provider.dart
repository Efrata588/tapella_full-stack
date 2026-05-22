import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_listings_provider.g.dart';

@riverpod
class SavedListings extends _$SavedListings {
  @override
  Set<String> build() => {};

  void toggleSave(String listingId) {
    if (state.contains(listingId)) {
      state = {...state}..remove(listingId);
    } else {
      state = {...state, listingId};
    }
  }

  bool isSaved(String listingId) => state.contains(listingId);
}
