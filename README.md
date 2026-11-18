# Roomies

Web Technologies

**Members:** Juan Pablo Saavedra · Julian Rodriguez

## Setup

Requires Ruby 4.0.4, PostgreSQL, Node.js, Yarn and libvips (for image variants):

```bash
sudo apt-get install -y libvips
```

```bash
bundle install
yarn install
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

## Run

```bash
bin/dev
```

Then open http://localhost:3000. In development the emails (password reset and new applications) are not sent: they are saved in `tmp/mails/`.

## Accounts and roles

Every seed user has the password `roomies123`.

| Email | Role | In the seeds |
|---|---|---|
| smella1@example.com | Moderator | Owns nothing |
| dortuzar1@example.com | Member | Host of two properties that have applications |
| cperez1@example.com | Member | Host in Ñuñoa and applicant |
| mcervantes1@example.com | Member | Host with a draft room, and applicant |
| trivas1@example.com | Member | Applicant with a completed visit and a review |

- **Visitor** (not signed in): sees the landing page, the search, the rooms, the properties and their reviews.
- **Member** (default role for every new account): publishes properties and rooms and edits or deletes only their own; applies to other people's rooms and sees only their own applications and the ones on their rooms; answers the applications on their rooms; proposes or cancels visits as host or applicant; reviews a property after their own completed visit; reports rooms.
- **Moderator**: what a member can do, plus seeing drafts and every application, editing or deleting any property, room or review, resolving reports and managing neighborhoods and amenities.

## JSON API

Public and read-only. It only returns published rooms and no personal data (no host, address or applications).

`GET /api/v1/listings` — optional filters: `neighborhood_id`, `max_rent` and `available_from` (YYYY-MM-DD: rooms available by that date).

```json
{
  "data": [
    {
      "id": 1, "monthly_rent": 450000, "deposit": 450000, "available_from": "2026-12-09",
      "minimum_stay_months": 6, "furnished": true, "private_bathroom": true, "property_type": "apartment",
      "neighborhood": { "id": 1, "name": "Providencia" },
      "photo_url": "http://localhost:3000/rails/active_storage/...", "url": "http://localhost:3000/listings/1"
    }
  ],
  "meta": { "count": 1 }
}
```

`GET /api/v1/listings/:id` — one room: the same fields plus `description`, `house_rules`, `bedrooms`, `bathrooms` and `amenities`.

| Status | When |
|---|---|
| 200 | OK |
| 400 | A filter is not valid, e.g. `max_rent=abc`. Body: `{ "error": "..." }` |
| 404 | The room does not exist or is not published. Body: `{ "error": "Listing not found" }` |

## Uploads

Listing photos accept JPEG, PNG or WebP, up to 5 MB each.

## Domain model

Diagram: `docs/domain-model.png` ([dbdiagram.io](https://dbdiagram.io/d/6aa8004c36f99825648c9d10)).

Changes since Assignment 1:

- `users.email` is now `email_address`, the name the Rails 8 authentication generator uses.
- The `status` columns and `users.role` are integers, because they are implemented as enums.
- Every table has `created_at` and `updated_at`, which Rails maintains.
- Required columns are `NOT NULL`, and unique indexes enforce the domain rules: one application per seeker and listing, and one review per visit.
- `listing_photos` was replaced by Active Storage, and `listings.description` and `house_rules` by Action Text.
- `users` has `password_digest`, `phone` and `bio`, and a `sessions` table stores the signed-in sessions.