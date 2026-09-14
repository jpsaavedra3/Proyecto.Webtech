# Roomies

Semester project for Web Technologies (ICC4130), Universidad de los Andes, 202620.

Roomies is a platform where somebody with a free room in a shared house can publish it, and
somebody looking for a place to live can find it, apply, visit it and move in.

**Member:** Juan Pablo Saavedra (working alone, authorised by the professor)

## Assignment 1

This first assignment is analysis, design and static HTML — there is no Rails application yet.

| Deliverable | Where |
|---|---|
| Landing page | `index.html`, `css/style.css`, `img/` |
| User stories | `docs/user-stories.md` |
| Domain model | `docs/domain-model.png` — source in `docs/domain-model.dbml` |
| Design decisions | `docs/design-decisions.md` |

The domain model is also online at
[dbdiagram.io](https://dbdiagram.io/d/6aa8004c36f99825648c9d10).

## How to open the landing page

There is nothing to install. Clone the repository and open `index.html` in a browser:

```bash
git clone https://github.com/jpsaavedra3/Proyecto.Webtech.git
cd Proyecto.Webtech
```

Bootstrap 5.3 is loaded from a CDN, so the page needs a connection the first time it is
opened. The photographs are in `img/` and are part of the repository.

## Repository structure

```
index.html                  landing page
css/style.css               the two custom rules on top of Bootstrap
img/                        photographs used on the landing page
docs/user-stories.md        user stories for the three roles
docs/domain-model.png       relational diagram
docs/domain-model.dbml      source of the diagram
docs/design-decisions.md    decisions taken while modelling
```
