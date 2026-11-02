# catalog-api

Small product catalog API written in TypeScript and Express.

## Endpoints

- `GET /health` – health check
- `GET /products` – list products
- `GET /products/:id` – get one product

## Run with Docker

```bash
docker build -t catalog-api:latest .
docker run -p 3000:3000 catalog-api:latest
```

## CI

Every pull request to `main` builds the image and checks its size against a limit
(see `.github/workflows/image-size.yml`). The size is written to the job summary.
