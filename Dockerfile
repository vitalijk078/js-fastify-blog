# syntax=docker/dockerfile:1

FROM node:20-bookworm-slim AS base
WORKDIR /app

FROM base AS deps
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 make g++ \
    && rm -rf /var/lib/apt/lists/*
COPY package*.json ./
RUN npm ci

FROM deps AS build
COPY . .
RUN npm run build

FROM deps AS test
COPY . .
ENV NODE_ENV=test
CMD ["npm", "test"]

FROM base AS production-deps
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 make g++ \
    && rm -rf /var/lib/apt/lists/*
COPY package*.json ./
RUN npm ci --omit=dev

FROM base AS production
ENV NODE_ENV=production

COPY --from=production-deps /app/node_modules /app/node_modules
COPY --from=build /app /app

RUN useradd -m app \
    && chown -R app:app /app

USER app
EXPOSE 8080

CMD ["npm", "start"]