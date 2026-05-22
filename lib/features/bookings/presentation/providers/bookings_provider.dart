import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/models/booking_model.dart';
import '../../data/bookings_repository.dart';

part 'bookings_provider.g.dart';

@riverpod
Future<List<BookingModel>> customerBookings(Ref ref) async {
  final result = await ref.read(bookingsRepositoryProvider).customerBookings();
  return result.data;
}

@riverpod
Future<bool> customerBookingsStale(Ref ref) async {
  final result = await ref.read(bookingsRepositoryProvider).customerBookings();
  return result.isStale;
}

@riverpod
Future<List<BookingModel>> incomingBookings(Ref ref) async {
  final result = await ref.read(bookingsRepositoryProvider).incomingBookings();
  return result.data;
}

@riverpod
Future<List<BookingModel>> historyBookings(Ref ref) async {
  final result = await ref.read(bookingsRepositoryProvider).historyBookings();
  return result.data;
}

@riverpod
BookingActions bookingActions(Ref ref) => BookingActions(ref);

class BookingActions {
  final Ref ref;
  BookingActions(this.ref);

  Future<void> accept(String id) async {
    await ref.read(bookingsRepositoryProvider).updateStatus(id, 'accepted');
    ref.invalidate(incomingBookingsProvider);
    ref.invalidate(historyBookingsProvider);
  }

  Future<void> reject(String id) async {
    await ref.read(bookingsRepositoryProvider).updateStatus(id, 'rejected');
    ref.invalidate(incomingBookingsProvider);
    ref.invalidate(historyBookingsProvider);
  }

  Future<void> complete(String id) async {
    await ref.read(bookingsRepositoryProvider).complete(id);
    ref.invalidate(incomingBookingsProvider);
    ref.invalidate(historyBookingsProvider);
  }

  Future<void> cancel(String id) async {
    await ref.read(bookingsRepositoryProvider).cancel(id);
    ref.invalidate(customerBookingsProvider);
  }

  Future<BookingModel> book({
    required String listingId,
    String? scheduledDate,
    String? notes,
  }) async {
    final booking = await ref.read(bookingsRepositoryProvider).create(
          listingId: listingId,
          scheduledDate: scheduledDate,
          notes: notes,
        );
    ref.invalidate(customerBookingsProvider);
    return booking;
  }
}
