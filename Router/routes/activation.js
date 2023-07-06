const express = require("express");
const router = express.Router();
const db = require("../../utils/database");

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
        console.log("[API] customer activation updated successfully");
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
        console.log("[API] spot activation updated successfully");
        res.status(200).send("spot activation updated successfully");
      }
    }
  );
});

module.exports = router;