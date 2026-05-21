const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');
const db = require('../db/database');
const env = require('../config/env');
const { AppError } = require('../middleware/errorHandler');

function sanitizeUser(row) {
  if (!row) return null;
  return {
    id: row.id,
    email: row.email,
    role: row.role,
    displayName: row.display_name,
    phone: row.phone,
    location: row.location,
    bio: row.bio,
    profileImage: row.profile_image,
    profession: row.profession,
    createdAt: row.created_at,
  };
}

function signTokens(user) {
  const payload = { sub: user.id, role: user.role, email: user.email };
  const accessToken = jwt.sign(payload, env.jwtSecret, { expiresIn: env.accessExpiresIn });
  const refreshToken = jwt.sign(payload, env.jwtRefreshSecret, { expiresIn: env.refreshExpiresIn });
  return { accessToken, refreshToken };
}

async function register({ email, password, displayName, role, phone, location, profession }) {
  const existing = db.get('SELECT id FROM users WHERE email = ?', [email.toLowerCase()]);
  if (existing) {
    throw new AppError('Email already registered', 409, 'EMAIL_EXISTS');
  }
  const id = uuidv4();
  const passwordHash = await bcrypt.hash(password, 10);
  const now = new Date().toISOString();
  db.run(
    `INSERT INTO users (id, email, password_hash, role, display_name, phone, location, profession, created_at)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    [id, email.toLowerCase(), passwordHash, role, displayName, phone || null, location || null, profession || null, now],
  );
  const user = db.get('SELECT * FROM users WHERE id = ?', [id]);
  const tokens = signTokens(user);
  return { ...tokens, user: sanitizeUser(user) };
}

async function login({ email, password, expectedRole }) {
  const user = db.get('SELECT * FROM users WHERE email = ?', [email.toLowerCase()]);
  if (!user) {
    throw new AppError('Invalid credentials', 401, 'INVALID_CREDENTIALS');
  }
  const valid = await bcrypt.compare(password, user.password_hash);
  if (!valid) {
    throw new AppError('Invalid credentials', 401, 'INVALID_CREDENTIALS');
  }
  if (expectedRole && user.role !== expectedRole) {
    throw new AppError(`Please use ${user.role} login`, 403, 'WRONG_ROLE');
  }
  const tokens = signTokens(user);
  return { ...tokens, user: sanitizeUser(user) };
}

function refresh(refreshToken) {
  try {
    const payload = jwt.verify(refreshToken, env.jwtRefreshSecret);
    const user = db.get('SELECT * FROM users WHERE id = ?', [payload.sub]);
    if (!user) throw new AppError('User not found', 404, 'NOT_FOUND');
    return signTokens(user);
  } catch {
    throw new AppError('Invalid refresh token', 401, 'INVALID_TOKEN');
  }
}

function getMe(userId) {
  const user = db.get('SELECT * FROM users WHERE id = ?', [userId]);
  if (!user) throw new AppError('User not found', 404, 'NOT_FOUND');
  return sanitizeUser(user);
}

function updateProfile(userId, body) {
  const user = db.get('SELECT * FROM users WHERE id = ?', [userId]);
  if (!user) throw new AppError('User not found', 404, 'NOT_FOUND');

  if (body.email && body.email.toLowerCase() !== user.email) {
    const taken = db.get('SELECT id FROM users WHERE email = ? AND id != ?', [
      body.email.toLowerCase(),
      userId,
    ]);
    if (taken) throw new AppError('Email already in use', 409, 'EMAIL_EXISTS');
  }

  db.run(
    `UPDATE users SET
      display_name = ?,
      email = ?,
      phone = ?,
      location = ?,
      bio = ?,
      profile_image = ?,
      profession = ?
     WHERE id = ?`,
    [
      body.displayName ?? user.display_name,
      (body.email ?? user.email).toLowerCase(),
      body.phone ?? user.phone,
      body.location ?? user.location,
      body.bio ?? user.bio,
      body.profileImage !== undefined ? body.profileImage : user.profile_image,
      body.profession !== undefined ? body.profession : user.profession,
      userId,
    ],
  );
  return getMe(userId);
}

function deleteAccount(userId) {
  const user = db.get('SELECT * FROM users WHERE id = ?', [userId]);
  if (!user) throw new AppError('User not found', 404, 'NOT_FOUND');

  db.run('DELETE FROM reviews WHERE customer_id = ? OR provider_id = ?', [userId, userId]);
  db.run('DELETE FROM bookings WHERE customer_id = ? OR provider_id = ?', [userId, userId]);
  db.run('UPDATE listings SET deleted_at = ? WHERE provider_id = ?', [
    new Date().toISOString(),
    userId,
  ]);
  db.run('DELETE FROM users WHERE id = ?', [userId]);
  return { deleted: true };
}

module.exports = { register, login, refresh, getMe, updateProfile, deleteAccount, sanitizeUser };
