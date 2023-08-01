// ### DATA MANAGEMENT ###
const management = require("./routes/management");

// ### ACTIVATION ###
const activation = require("./routes/activation");

// ### DEPOSITS ###
const deposits = require("./routes/deposits");

// ### PAYMENTS ###
const payments = require("./routes/payments");

// ### DATA COUNT ###
const counts = require("./routes/count");

// ### READER ###
const reader = require("./routes/reader");

// ### CREDENTIALS ###
const credentials = require("./routes/credentials");

// ### LOGS ###
const logs = require("./routes/logs");

// ### REQUESTS ###
const requests = require("./routes/requests");

function router(app) {
  app.use(process.env.API_URI_PATH, management);
  app.use(process.env.API_URI_PATH, activation);
  app.use(process.env.API_URI_PATH, deposits);
  app.use(process.env.API_URI_PATH, payments);
  app.use(process.env.API_URI_PATH, counts);
  app.use(process.env.API_URI_PATH, reader);
  app.use(process.env.API_URI_PATH, credentials);
  app.use(process.env.API_URI_PATH, logs);
  app.use(process.env.API_URI_PATH, requests);
}

module.exports = router;