# AppServer

This is the node REST API with a builtin in-memory mongodb

## Getting Started

Pretty standard for Node projects. On root, just run

> npm install

I developed this with only the in-memory mongodb in mind so whichever of the `npm run` options ran will instantiate a mongodb instance in memory.
The difference however is that the `dev` command will use `nodemon`.

> npm run dev

> npm run start

Additionaly there's a couple (literally) tests that can be ran using

> npm run tests

## Database

This project uses mongodb and there's only one schema defined for it, the `TODO`, which has some properties:

- **title** - The title of the `TODO`, the main descriptor of the activity.
- **description** - More details of said acitivity.
- **completed** - Whether or not the `TODO` was completed whenever set updates the *completedAt* property.
- **completedAt** - A timestamp indicating when the `TODO` was completed.
- **createdAt** - A timestamp indicating when the `TODO` was created.

## API

A REST api operating over the `TODO` object. There's a handful of operations:
I'm not gonna give the full path for each operation since the app itself should handle this. Just be sure to leave it running before trying out the flutter app.

- **listAll** - Just returns a list with all the `TODO` documents in the database.
- **find** - similar to `listAll` but it takes a `_id` and returns just *that* `TODO`.
- **create** - As the name states, creates a `TODO` document in the database.
- **update** - Takes a `_id` and updates `TODO` with its body properties.
- **delete** - Takes a `_id` and deletes `TODO`.
- **complete** - A more Bussiness-Oriented alternative for `update` which purpose is to only set the `TODO` as completed while also updating *when* it was completed.
- **uncomplete** - Similarly Bussiness-Oriented as `complete` but does the oposite, it erases *when* the `TODO` was complete.

The API has a error handling middleware that should give you a customized *statusCode* and *message* indicating what went wrong.
I wouldn't keep my hopes high tough, there was not that much thought given to any other than the "happy" path.

## Problems

I ran into some problems when developing the unit tests with async functions. I designed two identical tests and the latter one always failed.
I tried some combinations of *async/await* and *then/catch* but ultimately nothing came of it.

I tried to build a simple errorHandling middleware for the API, but didn't really give it too much thought and the result is that it works but I don't really know if I'd encourage anyone to do it the way I did, there might be some implications that don't really show in such a small project.