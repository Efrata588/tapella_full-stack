# Tapella API

## Setup

```bash
cd server
npm install
npm run dev
```

API base: `http://localhost:3000/api/v1`

## Demo accounts (seeded)

| Role | Email | Password |
|------|-------|----------|
| Provider | provider@tapella.com | password123 |
| Customer | customer@tapella.com | password123 |

## Endpoints

- `GET /health`
- `POST /auth/register/customer` | `/auth/register/provider`
- `POST /auth/login/customer` | `/auth/login/provider`
- `GET /auth/me` (Bearer token)
- `GET /listings` | `GET /listings/:id` | `GET /listings/mine` (provider)
- `POST /listings` | `PATCH /listings/:id` | `DELETE /listings/:id`
- `POST /bookings` | `GET /bookings/mine` | `GET /bookings/incoming` | `GET /bookings/history`
- `PATCH /bookings/:id/status` | `PATCH /bookings/:id/complete`
- `POST /reviews/bookings/:bookingId` | `GET /reviews/listings/:listingId`
