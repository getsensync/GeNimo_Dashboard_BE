const express = require("express");
const router = express.Router();
const db = require("../../utils/database");

// ### DATA COUNT ###

// ### C-PAYMENTS ###
// Count all ticket payments made group by spot
router.get("/count/payments/all", (req, res) => {
  db.query(
    "SELECT s.SpotId, s.SpotName, s.Price, CAST(COUNT(p.SpotId) AS INTEGER) FROM spots s LEFT JOIN payments p ON s.SpotId = p.SpotId GROUP BY s.SpotId ORDER BY s.SpotId ASC",
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted all payments successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Count today ticket payments made group by spot
router.get("/count/payments/today/spots", (req, res) => {
  const today = new Date();
  const dayQuery = "EXTRACT(DAY FROM PaymentTimestamp)";
  const monthQuery = "EXTRACT(MONTH FROM PaymentTimestamp)";
  const yearQuery = "EXTRACT(YEAR FROM PaymentTimestamp)";
  db.query(
    `SELECT s.SpotId, s.SpotName, s.Price, CAST(COUNT(p.SpotId) AS INTEGER) FROM spots s LEFT JOIN payments p ON s.SpotId = p.SpotId WHERE ${dayQuery} = $1 AND ${monthQuery} = $2 AND ${yearQuery} = $3 GROUP BY s.SpotId ORDER BY s.SpotId ASC`,
    [today.getDate(), today.getMonth() + 1, today.getFullYear()],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted today payments successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Count monthly ticket payments made group by day then GROUP BY Spot
router.get("/count/payments/monthly/:month/spots", (req, res) => {
  const month = req.params.month;
  const monthQuery = "EXTRACT(MONTH FROM PaymentTimestamp)";
  const dayQuery = "EXTRACT(DAY FROM PaymentTimestamp)";
  db.query(
    `SELECT ${dayQuery} AS day, s.SpotId, s.SpotName, s.Price, CAST(COUNT(p.SpotId) AS INTEGER) FROM spots s LEFT JOIN payments p ON s.SpotId = p.SpotId WHERE ${monthQuery} = $1 GROUP BY ${dayQuery}, s.SpotId ORDER BY ${dayQuery} ASC, s.SpotId ASC`,
    [month],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted monthly payments successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Count annual ticket payments made group by month then GROUP BY Spot
router.get("/count/payments/annual/:year/spots", (req, res) => {
  const year = req.params.year;
  const yearQuery = "EXTRACT(YEAR FROM PaymentTimestamp)";
  const monthQuery = "EXTRACT(MONTH FROM PaymentTimestamp)";
  db.query(
    `SELECT ${monthQuery} AS month, s.SpotId, s.SpotName, s.Price, CAST(COUNT(p.SpotId) AS INTEGER) FROM spots s LEFT JOIN payments p ON s.SpotId = p.SpotId WHERE ${yearQuery} = $1 GROUP BY ${monthQuery}, s.SpotId ORDER BY ${monthQuery} ASC, s.SpotId ASC`,
    [year],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted annual payments successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Count monthly ticket payments made in ALL SPOT group by day
router.get("/count/payments/monthly/:month", (req, res) => {
  const month = req.params.month;
  const monthQuery = "EXTRACT(MONTH FROM PaymentTimestamp)";
  const dayQuery = "EXTRACT(DAY FROM PaymentTimestamp)";
  db.query(
    `SELECT ${dayQuery} AS day, CAST(COUNT(PaymentId) AS INTEGER) FROM payments WHERE ${monthQuery} = $1 GROUP BY ${dayQuery} ORDER BY ${dayQuery} ASC`,
    [month],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted monthly payments successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Count annual ticket payments made in ALL SPOT group by month
router.get("/count/payments/annual/:year", (req, res) => {
  const year = req.params.year;
  const yearQuery = "EXTRACT(YEAR FROM PaymentTimestamp)";
  const monthQuery = "EXTRACT(MONTH FROM PaymentTimestamp)";
  db.query(
    `SELECT ${monthQuery} AS month, CAST(COUNT(PaymentId) AS INTEGER) FROM payments WHERE ${yearQuery} = $1 GROUP BY ${monthQuery} ORDER BY ${monthQuery} ASC`,
    [year],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted annual payments successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// ### C-DEPOSITS ###
// Count all deposits made and total amount
router.get("/count/deposits/all", (req, res) => {
  db.query(
    "SELECT CAST(COUNT(DepositId) AS INTEGER), CAST(SUM(Amount) AS INTEGER) AS amount FROM deposits",
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted all deposits successfully");
        res.status(200).send(result.rows[0]);
      }
    }
  );
});

// Count today deposits and total amount
router.get("/count/deposits/today", (req, res) => {
  const today = new Date();
  const dayQuery = "EXTRACT(DAY FROM DepositTimestamp)";
  const monthQuery = "EXTRACT(MONTH FROM DepositTimestamp)";
  const yearQuery = "EXTRACT(YEAR FROM DepositTimestamp)";
  db.query(
    `SELECT CAST(COUNT(DepositId) AS INTEGER), CAST(SUM(Amount) AS INTEGER) AS amount FROM deposits WHERE ${dayQuery} = $1 AND ${monthQuery} = $2 AND ${yearQuery} = $3`,
    [today.getDate(), today.getMonth() + 1, today.getFullYear()],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted today deposits successfully");
        res.status(200).send(result.rows[0]);
      }
    }
  );
});

// Count monthly deposits and total amount group by day
router.get("/count/deposits/monthly/:month", (req, res) => {
  const month = req.params.month;
  const monthQuery = "EXTRACT(MONTH FROM DepositTimestamp)";
  const dayQuery = "EXTRACT(DAY FROM DepositTimestamp)";
  db.query(
    `SELECT ${dayQuery} AS day, CAST(COUNT(DepositId) AS INTEGER), CAST(SUM(Amount) AS INTEGER) AS amount FROM deposits WHERE ${monthQuery} = $1 GROUP BY ${dayQuery} ORDER BY ${dayQuery} ASC`,
    [month],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted monthly deposits successfully");
        res.status(200).send(result.rows[0]);
      }
    }
  );
});

// Count annual deposits and total amount group by month
router.get("/count/deposits/annual/:year", (req, res) => {
  const year = req.params.year;
  const yearQuery = "EXTRACT(YEAR FROM DepositTimestamp)";
  const monthQuery = "EXTRACT(MONTH FROM DepositTimestamp)";
  db.query(
    `SELECT ${monthQuery} AS month, CAST(COUNT(DepositId) AS INTEGER), CAST(SUM(Amount) AS INTEGER) AS amount FROM deposits WHERE ${yearQuery} = $1 GROUP BY ${monthQuery} ORDER BY ${monthQuery} ASC`,
    [year],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted annual deposits successfully");
        res.status(200).send(result.rows[0]);
      }
    }
  );
});

module.exports = router;