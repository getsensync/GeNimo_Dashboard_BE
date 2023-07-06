const express = require("express");
const router = express.Router();
const db = require("../../utils/database");

// ### DATA COUNT ###

// ### C-BALANCE ###
// Count all customers balance also total customers
router.get("/count/balance/all", (req, res) => {
  db.query(
    "SELECT CAST(COUNT(CustomerId) AS INTEGER) AS count, CAST(SUM(Balance) AS INTEGER) AS amount FROM customers",
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] counted all customers balance successfully");
        res.status(200).send(result.rows[0]);
      }
    }
  );
});

// ### C-PAYMENTS ###
const cPayments = require("./count/c-payments");
// ### C-DEPOSITS ###
const cDeposits = require("./count/c-deposits");

router.use(cPayments);
router.use(cDeposits);

module.exports = router;