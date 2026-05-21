import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/review_model.dart';
import '../../data/reviews_repository.dart';

final listingReviewsProvider =
    FutureProvider.family<List<ReviewModel>, String>((ref, listingId) {
  return ref.read(reviewsRepositoryProvider).getByListing(listingId);
});

final submitReviewProvider =
    Provider<SubmitReviewActions>((ref) => SubmitReviewActions(ref));

class SubmitReviewActions {
  final Ref ref;
  SubmitReviewActions(this.ref);

  Future<void> submit({
    required String bookingId,
    required int rating,
    String? comment,
  }) async {
    await ref.read(reviewsRepositoryProvider).submit(
          bookingId: bookingId,
          rating: rating,
          comment: comment,
        );
  }
}
