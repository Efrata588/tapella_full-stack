class ReviewModel {
  final String id;
  final String bookingId;
  final String listingId;
  final String customerId;
  final String customerName;
  final int rating;
  final String comment;

  const ReviewModel({
    required this.id,
    required this.bookingId,
    required this.listingId,
    required this.customerId,
    required this.customerName,
    required this.rating,
    this.comment = '',
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String,
      listingId: json['listingId'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String? ?? 'Customer',
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String? ?? '',
    );
  }

  Map<String, dynamic> toDbMap() => {
        'id': id,
        'booking_id': bookingId,
        'listing_id': listingId,
        'customer_id': customerId,
        'customer_name': customerName,
        'rating': rating,
        'comment': comment,
        'cached_at': DateTime.now().toIso8601String(),
      };

  factory ReviewModel.fromDb(Map<String, dynamic> row) {
    return ReviewModel(
      id: row['id'] as String,
      bookingId: row['booking_id'] as String,
      listingId: row['listing_id'] as String,
      customerId: row['customer_id'] as String,
      customerName: row['customer_name'] as String,
      rating: (row['rating'] as num).toInt(),
      comment: row['comment'] as String? ?? '',
    );
  }
}
