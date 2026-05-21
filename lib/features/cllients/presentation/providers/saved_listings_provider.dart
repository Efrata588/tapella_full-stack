import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedListingsNotifier extends StateNotifier<Set<String>> {
  SavedListingsNotifier() : super({});

  void toggleSave(String listingId) {
    if (state.contains(listingId)) {
      state = {...state}..remove(listingId);
    } else {
      state = {...state, listingId};
    }
  }

  bool isSaved(String listingId) {
    return state.contains(listingId);
  }
}

final savedListingsProvider = StateNotifierProvider<SavedListingsNotifier, Set<String>>((ref) {
  return SavedListingsNotifier();
});
