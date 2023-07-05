const express = require("express");
const router = express.Router();
const db = require("../../utils/database");

// ### READER ###
// A reader is used to read the card of a customer

//    -->>    USE   "/management/customers/certain/:id"   INSTEAD   <<--    
// // Check Customer Validity : Return All Customer Data of A Certain Customer
// router.get("/reader/customers/validate/:id", (req, res) => {
//   const id = req.params.id;
//   db.query(
//     "SELECT * FROM customers WHERE CustomerId = $1",
//     [id],
//     (err, result) => {
//       if (err) {
//         console.log(err);
//       } else {
//         console.log("[API] customer validated successfully");
//         res.status(200).send(result.rows);
//       }
//     }
//   );
// });

// Check Customer Active Status : Return IsActive of A Certain Customer
router.get("/reader/customers/active/:id", (req, res) => {
  const id = req.params.id;
  db.query(
    "SELECT IsActive FROM customers WHERE CustomerId = $1",
    [id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] customer active status checked successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Check Customer Balance : Return Balance of A Certain Customer
router.get("/reader/customers/balance/:id", (req, res) => {
  const id = req.params.id;
  db.query(
    "SELECT Balance FROM customers WHERE CustomerId = $1",
    [id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] customer balance checked successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Customer Payment : Add A Payment of A Customer in A Spot including updating the balance of the customer
router.post("/reader/payments/add", (req, res) => {
  const { customer_id, spot_id } = req.body;
  // Perform makePayment function then return new balance
  db.query(
    "INSERT INTO payments (CustomerId, SpotId) VALUES ($1, $2)",
    [customer_id, spot_id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        // update balance in customers table
        db.query(
          "UPDATE customers SET Balance = Balance - (SELECT Price FROM spots WHERE SpotId = $1) WHERE CustomerId = $2",
          [spot_id, customer_id],
          (err, result) => {
            if (err) {
              console.log(err);
              // if error occurs, delete the last payment was made
              let lastPaymentDeleted = false;
              do {
                db.query(
                  "DELETE FROM payments WHERE PaymentId = (SELECT MAX(PaymentId) FROM payments)",
                  (err, result) => {
                    if (err) {
                      console.log(err);
                    } else {
                      lastPaymentDeleted = true;
                    }
                  }
                );
              } while (!lastPaymentDeleted);
            } else {
              console.log("[API] customer payment added successfully");
              // return new balance
              db.query(
                "SELECT Balance FROM customers WHERE CustomerId = $1",
                [customer_id],
                (err, result) => {
                  if (err) {
                    console.log(err);
                  } else {
                    console.log("     and writing new balance to the card");
                    res.status(200).send(result.rows);
                  }
                }
              );
            }
          }
        );
      }
    }
  );
});

module.exports = router;