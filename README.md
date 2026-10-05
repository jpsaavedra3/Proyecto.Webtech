# Roomies

Web Technologies 

**Members:** Juan Pablo Saavedra · Julian Rodriguez

## Setup

Requires Ruby 4.0.4, PostgreSQL, Node.js and Yarn.

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

Then open http://localhost:3000.

## Domain model

Diagram: `docs/domain-model.png` ([dbdiagram.io](https://dbdiagram.io/d/6aa8004c36f99825648c9d10)).

Changes since Assignment 1:

- `users.email` is now `email_address`, the name the Rails 8 authentication generator uses in Assignment 4.
- The `status` columns and `users.role` are integers, because they are implemented as enums.
- Every table has `created_at` and `updated_at`, which Rails maintains.
- Required columns are `NOT NULL`, and unique indexes enforce the domain rules: one application per seeker and listing, and one review per visit.