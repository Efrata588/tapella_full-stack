const { v4: uuidv4 } = require('uuid');
const db = require('../db/database');
const { AppError } = require('../middleware/errorHandler');
function mapListing(row) {
  if (!row) return null;
  const provider = db.get('SELECT display_name FROM users WHERE id = ?', [row.provider_id]);
  return {
    id: row.id,
    providerId: row.provider_id,
    providerName: provider?.display_name || 'Provider',
    title: row.title,
    description: row.description,
    category: row.category,
    priceEtb: row.price_etb,
    location: row.location,
    phone: row.phone,
    ratingAvg: row.rating_avg,
    reviewCount: row.review_count,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

function listPublic({ search, category }) {
  let sql = 'SELECT * FROM listings WHERE deleted_at IS NULL';
  const params = [];
  if (category) {
    sql += ' AND category = ?';
    params.push(category);
  }
  if (search) {
    sql += ' AND (title LIKE ? OR description LIKE ? OR location LIKE ?)';
    const q = `%${search}%`;
    params.push(q, q, q);
  }
  sql += ' ORDER BY rating_avg DESC, created_at DESC';
  return db.all(sql, params).map(mapListing);
}

function getById(id) {
  const row = db.get('SELECT * FROM listings WHERE id = ? AND deleted_at IS NULL', [id]);
  if (!row) throw new AppError('Listing not found', 404, 'NOT_FOUND');
  return mapListing(row);
}

function listMine(providerId) {
  return db
    .all('SELECT * FROM listings WHERE provider_id = ? AND deleted_at IS NULL ORDER BY created_at DESC', [
      providerId,
    ])
    .map(mapListing);
}

function create(providerId, body) {
  const id = uuidv4();
  const now = new Date().toISOString();
  db.run(
    `INSERT INTO listings (id, provider_id, title, description, category, price_etb, location, phone, created_at, updated_at)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    [
      id,
      providerId,
      body.title,
      body.description || '',
      body.category,
      body.priceEtb || 0,
      body.location || '',
      body.phone || '',
      now,
      now,
    ],
  );
  return getById(id);
}

function update(id, body) {
  const existing = db.get('SELECT * FROM listings WHERE id = ?', [id]);
  if (!existing || existing.deleted_at) throw new AppError('Listing not found', 404, 'NOT_FOUND');
  const now = new Date().toISOString();
  db.run(
    `UPDATE listings SET title = ?, description = ?, category = ?, price_etb = ?, location = ?, phone = ?, updated_at = ?
     WHERE id = ?`,
    [
      body.title ?? existing.title,
      body.description ?? existing.description,
      body.category ?? existing.category,
      body.priceEtb ?? existing.price_etb,
      body.location ?? existing.location,
      body.phone ?? existing.phone,
      now,
      id,
    ],
  );
  return getById(id);
}

function remove(id) {
  const now = new Date().toISOString();
  db.run('UPDATE listings SET deleted_at = ?, updated_at = ? WHERE id = ?', [now, now, id]);
  return { deleted: true };
}

function recalculateRating(listingId) {
  const stats = db.get(
    'SELECT AVG(rating) as avg_rating, COUNT(*) as cnt FROM reviews WHERE listing_id = ?',
    [listingId],
  );
  db.run('UPDATE listings SET rating_avg = ?, review_count = ? WHERE id = ?', [
    stats?.avg_rating || 0,
    stats?.cnt || 0,
    listingId,
  ]);
}

module.exports = {
  listPublic,
  getById,
  listMine,
  create,
  update,
  remove,
  recalculateRating,
  mapListing,
};
