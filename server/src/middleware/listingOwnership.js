const db = require('../db/database');
const { AppError } = require('./errorHandler');

function listingOwnership(req, _res, next) {
  const listing = db.get(
    'SELECT provider_id FROM listings WHERE id = ? AND deleted_at IS NULL',
    [req.params.id],
  );
  if (!listing) {
    return next(new AppError('Listing not found', 404, 'NOT_FOUND'));
  }
  if (listing.provider_id !== req.user.id) {
    return next(new AppError('You do not own this listing', 403, 'FORBIDDEN'));
  }
  req.listing = listing;
  next();
}

module.exports = { listingOwnership };
