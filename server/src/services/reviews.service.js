const { v4: uuidv4 } = require('uuid');
const db = require('../db/database');
const { AppError } = require('../middleware/errorHandler');
const listingsService = require('./listings.service');

function mapReview(row) {
  if (!row) return null;
  const customer = db.get('SELECT display_name FROM users WHERE id = ?', [row.customer_id]);
  return {
    id: row.id,
    bookingId: row.booking_id,
    listingId: row.listing_id,
    customerId: row.customer_id,
    customerName: customer?.display_name || 'Customer',
    rating: row.rating,
    comment: row.comment,
    createdAt: row.created_at,
  };
}

function create(customerId, bookingId, { rating, comment }) {
  const booking = db.get('SELECT * FROM bookings WHERE id = ?', [bookingId]);
  if (!booking) throw new AppError('Booking not found', 404, 'NOT_FOUND');
  if (booking.customer_id !== customerId) {
    throw new AppError('Forbidden', 403, 'FORBIDDEN');
  }
  if (booking.status !== 'completed') {
    throw new AppError('Can only review completed bookings', 409, 'BOOKING_NOT_COMPLETED');
  }
  const existing = db.get('SELECT id FROM reviews WHERE booking_id = ?', [bookingId]);
  if (existing) throw new AppError('Review already exists', 409, 'REVIEW_EXISTS');

  const id = uuidv4();
  const now = new Date().toISOString();
  db.run(
    `INSERT INTO reviews (id, booking_id, listing_id, customer_id, provider_id, rating, comment, created_at)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
    [id, bookingId, booking.listing_id, customerId, booking.provider_id, rating, comment || '', now],
  );
  listingsService.recalculateRating(booking.listing_id);
  return mapReview(db.get('SELECT * FROM reviews WHERE id = ?', [id]));
}

function listByListing(listingId) {
  return db
    .all('SELECT * FROM reviews WHERE listing_id = ? ORDER BY created_at DESC', [listingId])
    .map(mapReview);
}

function listByProvider(providerId) {
  return db
    .all('SELECT * FROM reviews WHERE provider_id = ? ORDER BY created_at DESC', [providerId])
    .map(mapReview);
}

module.exports = { create, listByListing, listByProvider, mapReview };
