const db = require('../db/database');
const { AppError } = require('./errorHandler');

function bookingAccess(req, _res, next) {
  const booking = db.get('SELECT * FROM bookings WHERE id = ?', [req.params.id]);
  if (!booking) {
    return next(new AppError('Booking not found', 404, 'NOT_FOUND'));
  }
  const isCustomer = req.user.role === 'customer' && booking.customer_id === req.user.id;
  const isProvider = req.user.role === 'provider' && booking.provider_id === req.user.id;
  if (!isCustomer && !isProvider) {
    return next(new AppError('Forbidden', 403, 'FORBIDDEN'));
  }
  req.booking = booking;
  next();
}

module.exports = { bookingAccess };
