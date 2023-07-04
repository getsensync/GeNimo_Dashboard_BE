const express = require("express");
const router = express.Router();
const db = require("../../database");

// ### ACTIVATION ###

// Activate/Deactivate a Customer
router.patch("/activation/customer/:id", (req, res) => {
  const id = req.params.id;
  const { new_status } = req.body;
  db.query(
    "UPDATE customers SET IsActive = $1 WHERE CustomerId = $2",
    [new_status, id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        res.status(200).send("customer activation updated successfully");
      }
    }
  );
});

// Activate/Deactivate a Spot
router.patch("/activation/spot/:id", (req, res) => {
  const id = req.params.id;
  const { new_status } = req.body;
  db.query(
    "UPDATE spots SET IsActive = $1 WHERE SpotId = $2",
    [new_status, id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        res.status(200).send("spot activation updated successfully");
      }
    }
  );
});

// Check Activation of A Customer
router.get("/activation/customer/:id", (req, res) => {
  const id = req.params.id;
  db.query(
    "SELECT IsActive FROM customers WHERE CustomerId = $1",
    [id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        res.status(200).send(result.rows);
      }
    }
  );
});

module.exports = router;