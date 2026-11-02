import app from './app';

const port = Number(process.env.PORT) || 3000;

const server = app.listen(port, () => {
  console.log(`Catalog service listening on port ${port}`);
});

process.on('SIGTERM', () => {
  console.log('Received SIGTERM, shutting down');
  server.close(() => process.exit(0));
});
