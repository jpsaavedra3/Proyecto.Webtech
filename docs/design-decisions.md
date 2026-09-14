# Design Decisions

Assignment 1 · Web Technologies (ICC4130) · Universidad de los Andes
Juan Pablo Saavedra

These are the decisions I took while turning the project description into the relational
diagram in `docs/domain-model.png`.

## Entities the project description does not name

The description talks about people and actions; five of the twelve tables came from reading
those actions as data.

**`users`.** The description speaks of hosts, seekers and moderators as if they were three
kinds of person, but a host on one listing is a seeker on another. So there is a single
`users` table with a `role` column, and what a member may do with a record depends on whether
it belongs to them, not on their role.

**`property_amenities`.** A property offers many amenities and an amenity is offered by many
properties. That relationship has nowhere to live except a table of its own.

**`listing_photos`.** The description mentions photographs as part of a listing, not as
records. Since a listing has several of them and each one is a separate file, they are a
table pointing back at the listing.

**`saved_listings`.** Saving a listing is named as an action, so it needs a row that says
which user saved which listing. It is the second many-to-many of the model.

**`reports`.** Reporting is also named only as an action. The report has to store who sent
it, what they objected to, and whether a moderator has dealt with it.

## The two lifecycles

Both are a `status` column: `listings.status` holds draft, published, reserved, rented and
withdrawn, and `applications.status` holds pending, shortlisted, accepted, rejected and
withdrawn. `visits.status` works the same way.

I did not make them tables. Each lifecycle is a closed set of states, and no state carries
information of its own, so a column says everything the diagram needs. In Assignment 2 these
columns become enums.

What is not in the diagram is that accepting an applicant changes three things at once: the
chosen application, every other application on the listing, and the state of the listing
itself. That is behaviour and not structure, so it belongs to the application code, not to
the schema.

## Assumptions the description does not settle

**A review belongs to a visit, not to a listing.** The description says a user may review a
property once per visit, so `reviews.visit_id` is unique and the relationship is one to one.
The consequence is the rule itself: without a completed visit there is no row to hang a
review on.

**A review points at the property, not at the room.** Reviews are read on the property page,
and a property outlives the listings inside it, so the room a person visited should not
determine where their opinion is stored.

**An application can have more than one visit.** The description says the host may cancel a
visit and propose another date. I read that as a new visit rather than a new date on the old
one, so every proposal stays on the record.

**`reviews` also carries `property_id` and `user_id`** even though both could be reached
through the visit. It is a deliberate shortcut: the property page and the name of the
author are the two things that page needs, and neither should cost three joins.

**A listing has no title.** The description lists what a listing describes — rent, deposit,
availability, minimum stay, furnished, private bathroom, description and house rules — and a
title is not among them. The neighborhood and the rent are what identify a room on a card.

**The visitor is not a role.** `users.role` has two values, member and moderator. Being a
visitor is not being signed in, so it is the absence of a row rather than a value in one.

**Rent and deposit are `decimal`.** They are money, and money is never stored as a float.
