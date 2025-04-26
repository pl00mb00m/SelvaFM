const express = require('express');
const app = express();
const port = process.env.PORT || 10000;

// Простая проверка сервера
app.get('/api/health', (req, res) => {
  res.send('OK');
});

app.listen(port, () => {
  console.log(`SelvaFM Web server running on port ${port}`);
});
