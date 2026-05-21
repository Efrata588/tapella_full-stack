const bcrypt = require('bcryptjs');
const { v4: uuidv4 } = require('uuid');
const db = require('./database');

async function seedIfEmpty() {
  const rows = db.all('SELECT id FROM users LIMIT 1');
  if (rows.length > 0) return;

  const now = new Date().toISOString();
  const providerId = uuidv4();
  const customerId = uuidv4();
  const hash = await bcrypt.hash('password123', 10);

  db.run(
    'INSERT INTO users (id, email, password_hash, role, display_name, phone, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)',
    [providerId, 'provider@tapella.com', hash, 'provider', 'Saron Kiflu', '0911000001', now],
  );
  db.run(
    'INSERT INTO users (id, email, password_hash, role, display_name, phone, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)',
    [customerId, 'customer@tapella.com', hash, 'customer', 'Naomi M', '0911000002', now],
  );

  const listings = [
    {
      title: 'Master Plumber',
      description: 'Master of pipes, pressure, and precision',
      category: 'Plumbing',
      price: 500,
      location: 'Megenagna',
    },
    {
      title: 'Premium Housekeeping',
      description: 'Reliable cleaning, laundry, and home organization',
      category: 'Cleaning',
      price: 350,
      location: 'Bole',
    },
    {
      title: 'Web Development',
      description: 'Website developer, maintainer, and tech specialist',
      category: 'Development',
      price: 1200,
      location: 'Mexico',
    },
  ];

  for (const l of listings) {
    const id = uuidv4();
    db.run(
      `INSERT INTO listings (id, provider_id, title, description, category, price_etb, location, phone, rating_avg, review_count, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, 4.8, 12, ?, ?)`,
      [id, providerId, l.title, l.description, l.category, l.price, l.location, '0911000001', now, now],
    );
  }

  console.log('Seeded demo users: provider@tapella.com / customer@tapella.com (password123)');
}

module.exports = { seedIfEmpty };
