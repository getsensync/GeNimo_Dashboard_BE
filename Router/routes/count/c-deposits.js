const express = require("express");
const router = express.Router();
const db = require("../../../utils/database");


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