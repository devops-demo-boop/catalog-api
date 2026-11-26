-- Reporting seed: order history for the sales dashboard (teammate WIP)
CREATE TABLE customers (
  id          serial PRIMARY KEY,
  name        text NOT NULL,
  region      text NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE orders (
  id          bigserial PRIMARY KEY,
  customer_id int NOT NULL REFERENCES customers(id),
  status      text NOT NULL,
  amount      numeric(10,2) NOT NULL,
  created_at  timestamptz NOT NULL
);
CREATE INDEX orders_customer_idx ON orders (customer_id);
CREATE INDEX orders_created_idx  ON orders (created_at);
CREATE INDEX orders_status_idx   ON orders (status, created_at);

INSERT INTO customers (name, region)
SELECT 'Customer ' || g, (ARRAY['north','south','east','west'])[1 + g % 4]
FROM generate_series(1, 50000) g;

INSERT INTO orders (customer_id, status, amount, created_at)
SELECT 1 + (g % 50000),
       (ARRAY['new','paid','shipped','refunded'])[1 + g % 4],
       round((random() * 500)::numeric, 2),
       now() - (g % 730) * interval '1 day'
FROM generate_series(1, 16000000) g;
