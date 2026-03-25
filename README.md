# JS Fastify Blog

## Requirements

- Node.js v20.6.1
- Docker
- Docker Compose

## Local development without Docker

### Install dependencies

```bash
make install
````

### Run in development mode

```bash
make dev
```

## Environment variables

For working with PostgreSQL, create a `.env` file or specify environment variables manually.

You can prepare the file with:

```bash
make prepare-env
```

Then fill in the database connection settings:

```env
DATABASE_NAME=blog
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=postgres
DATABASE_PORT=5432
DATABASE_HOST=localhost
```

## Running with PostgreSQL without Docker

### Build assets

```bash
make build
```

### Start application

```bash
make start
```

Open in browser:

```text
http://localhost:8080
```

## Running with Docker Compose

The project is containerized with Docker. Docker Compose is used to run the application together with PostgreSQL.

### Start application

```bash
docker compose up --build app
```

Open in browser:

```text
http://localhost:8080
```

### Run tests

```bash
docker compose run --rm test
```

### Stop containers

```bash
docker compose down -v
```

## Docker image

Docker Hub repository: [https://hub.docker.com/repository/docker/paralyssiss/js-fastify-blog/general](https://hub.docker.com/repository/docker/paralyssiss/js-fastify-blog/general)

Image name:

```text
paralyssiss/js-fastify-blog:latest
```

Pull image:

```bash
docker pull paralyssiss/js-fastify-blog:latest
```

## Notes about tests with PostgreSQL

By default, the test environment uses SQLite.

If you need to run tests with PostgreSQL, edit `config/config.cjs` and under the `test` key comment out SQLite and uncomment PostgreSQL configuration:

```js
// test: {
//   dialect: 'sqlite',
//   storage: './database.test.sqlite',
// },
test: {
  dialect: 'postgres',
  database: process.env.DATABASE_NAME,
  username: process.env.DATABASE_USERNAME,
  password: process.env.DATABASE_PASSWORD,
  port: process.env.DATABASE_PORT,
  host: process.env.DATABASE_HOST,
},
```

## Project summary

`js-fastify-blog` is a Fastify-based blog application prepared for local development and containerized deployment. The project can be launched with Docker Compose, where the application and PostgreSQL run as separate services. On startup, the application performs database migrations automatically.

## About

This repository is created and maintained by the team and the community of Hexlet, an educational project.

````

После этого просто сохрани файл и запушь:

```cmd
git add README.md
git commit -m "Update README"
git push
````
