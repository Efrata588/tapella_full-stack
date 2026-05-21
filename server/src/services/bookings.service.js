const { v4: uuidv4 } = require('uuid');
const db = require('../db/database');
const { AppError } = require('../middleware/errorHandler');
const VALID_TRANSITIONS = {
  pending: ['accepted', 'rejected', 'cancelled'],
  accepted: ['completed', 'rejected'],
};

function mapBooking(row) {
  if (!row) return null;
  const l = db.get('SELECT title FROM listings WHERE id = ?', [row.listing_id]);
  const listingTitle = l?.title || 'Service';
  const customer = db.get('SELECT display_name FROM users WHERE id = ?', [row.customer_id]);
  const provider = db.get('SELECT display_name FROM users WHERE id = ?', [row.provider_id]);
  return {
    id: row.id,
    listingId: row.listing_id,
    listingTitle,
    customerId: row.customer_id,
    customerName: customer?.display_name || 'Customer',
    providerId: row.provider_id,
    providerName: provider?.display_name || 'Provider',
    status: row.status,
    scheduledDate: row.scheduled_date,
    notes: row.notes,
    amountEtb: row.amount_etb,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

function create(customerId, { listingId, scheduledDate, notes }) {
  const listing = db.get('SELECT * FROM listings WHERE id = ? AND deleted_at IS NULL', [listingId]);
  if (!listing) throw new AppError('Listing not found', 404, 'NOT_FOUND');
  const id = uuidv4();
  const now = new Date().toISOString();
  db.run(
    `INSERT INTO bookings (id, listing_id, customer_id, provider_id, status, scheduled_date, notes, amount_etb, created_at, updated_at)
     VALUES (?, ?, ?, ?, 'pending', ?, ?, ?, ?, ?)`,
    [
      id,
      listingId,
      customerId,
      listing.provider_id,
      scheduledDate || null,
      notes || '',
      listing.price_etb || 0,
      now,
      now,
    ],
  );
  return mapBooking(db.get('SELECT * FROM bookings WHERE id = ?', [id]));
}

function listCustomer(customerId) {
  return db
    .all('SELECT * FROM bookings WHERE customer_id = ? ORDER BY created_at DESC', [customerId])
    .map(mapBooking);
}

function listIncoming(providerId) {
  return db
    .all(
      "SELECT * FROM bookings WHERE provider_id = ? AND status = 'pending' ORDER BY created_at DESC",
      [providerId],
    )
    .map(mapBooking);
}

function listHistory(providerId) {
  return db
    .all(
      "SELECT * FROM bookings WHERE provider_id = ? AND status IN ('accepted', 'completed', 'rejected', 'cancelled') ORDER BY updated_at DESC",
      [providerId],
    )
    .map(mapBooking);
}

function updateStatus(bookingId, providerId, newStatus) {
  const booking = db.get('SELECT * FROM bookings WHERE id = ?', [bookingId]);
  if (!booking) throw new AppError('Booking not found', 404, 'NOT_FOUND');
  if (booking.provider_id !== providerId) {
    throw new AppError('Forbidden', 403, 'FORBIDDEN');
  }
  const allowed = VALID_TRANSITIONS[booking.status] || [];
  if (!allowed.includes(newStatus)) {
    throw new AppError(`Cannot transition from ${booking.status} to ${newStatus}`, 409, 'INVALID_TRANSITION');
  }
  const now = new Date().toISOString();
  db.run('UPDATE bookings SET status = ?, updated_at = ? WHERE id = ?', [newStatus, now, bookingId]);
  return mapBooking(db.get('SELECT * FROM bookings WHERE id = ?', [bookingId]));
}

function complete(bookingId, providerId) {
  return updateStatus(bookingId, providerId, 'completed');
}

function cancelByCustomer(bookingId, customerId) {
  const booking = db.get('SELECT * FROM bookings WHERE id = ?', [bookingId]);
  if (!booking) throw new AppError('Booking not found', 404, 'NOT_FOUND');
  if (booking.customer_id !== customerId) {
    throw new AppError('Forbidden', 403, 'FORBIDDEN');
  }
  if (booking.status !== 'pending') {
    throw new AppError('Only pending requests can be cancelled', 409, 'INVALID_TRANSITION');
  }
  const now = new Date().toISOString();
  db.run('UPDATE bookings SET status = ?, updated_at = ? WHERE id = ?', [
    'cancelled',
    now,
    bookingId,
  ]);
  return mapBooking(db.get('SELECT * FROM bookings WHERE id = ?', [bookingId]));
}

module.exports = {
  create,
  listCustomer,
  listIncoming,
  listHistory,
  updateStatus,
  complete,
  cancelByCustomer,
  mapBooking,
};
