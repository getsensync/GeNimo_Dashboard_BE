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

// Check active status of a customer, by ID
router.get("/activation/customer/:id", (req, res) => {
  const id = req.params.id;
  db.query(
    "SELECT IsActive FROM customers WHERE CustomerId = $1",
    [id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] customer activation checked successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Check active status of a customer, by UUID
router.get("/activation/customer/uuid/:uuid", (req, res) => {
  const uuid = req.params.uuid;
  db.query(
    "SELECT IsActive FROM customers WHERE CustomerUuid = $1",
    [uuid],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] customer activation checked successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

module.exports = router;