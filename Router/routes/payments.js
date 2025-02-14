const express = require("express");
const router = express.Router();
const db = require("../../utils/database");

// ### PAYMENTS ###

// Get All Payments data
router.get("/payments/all", (req, res) => {
  db.query("SELECT * FROM payments ORDER BY PaymentId ASC", (err, result) => {
    if (err) {
      console.log(err);
    } else {
      console.log("[API] all payments data fetched successfully");
      res.status(200).send(result.rows);
    }
  });
});

// Get Payment data of A Certain Customer
router.get("/payments/certain/customers/:id", (req, res) => {
  const id = req.params.id;
  db.query(
    "SELECT * FROM payments WHERE CustomerId = $1 ORDER BY PaymentId ASC",
    [id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] certain customer payments data fetched successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Get Payment data of A Certain Spot
router.get("/payments/certain/spots/:id", (req, res) => {
  const id = req.params.id;
  db.query(
    "SELECT * FROM payments WHERE SpotId = $1 ORDER BY PaymentId ASC",
    [id],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] certain spot payments data fetched successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// Add payment of a customer in a spot, with user ID and spot ID
router.post('/payments/add/customerid/:customerid', (req, res) => {
  const customer_id = req.params.customerid;
  const spot_id = req.body.spot_id;

  // PaymentTimestamp is automatically generated by the database
  // insert data to payments table and update balance in customers table,
  // balance update is subtracting old balance with price of the spot
  db.query(
      'INSERT INTO payments (CustomerId, SpotId) VALUES ($1, $2)',
      [customer_id, spot_id], (err, result) => {
        if (err) {
          console.log(err);
        } else {
          // update balance in customers table
          db.query(
              'UPDATE customers SET Balance = Balance - (SELECT Price FROM spots WHERE SpotId = $1) WHERE CustomerId = $2',
              [spot_id, customer_id], (err, result) => {
                if (err) {
                  console.log(err);
                  // if error occurs, delete last made payment
                  let lastPaymentDeleted = false;
                  do {
                    db.query(
                        'DELETE FROM payments WHERE PaymentId = (SELECT MAX(PaymentId) FROM payments)',
                        (err, result) => {
                          if (err) {
                            console.log(err);
                          } else {
                            lastPaymentDeleted = true;
                          }
                        });
                  } while (!lastPaymentDeleted);
                } else {
                  console.log('[API] payment added successfully');
                  db.query(
                      'SELECT Balance FROM customers WHERE CustomerId = $1',
                      [customer_id], (err, result) => {
                        if (err) {
                          console.log(err);
                        } else {
                          console.log(
                              '     and writing new balance to the card');
                          res.status(200).send(result.rows);
                        }
                      });
                }
              });
        }
      });
});

// Add payment of a customer in a spot, with user UUID and spot ID
router.post('/payments/add/customeruuid/:customeruuid', (req, res) => {
  const customer_uuid = req.params.customeruuid;
  const spot_id = req.body.spot_id;

  // PaymentTimestamp is automatically generated by the database
  // insert data to payments table and update balance in customers table,
  // balance update is subtracting old balance with price of the spot
  db.query(
      // Get customer ID and balance from UUID, as deposits table will only store customer
      // ID
      'SELECT customerid, balance FROM customers WHERE customeruuid = $1',
      [customer_uuid], (err, result) => {
        if (err) {
          console.log(err);
        } else {
          console.log('[API] customer UUID is valid, continuing...');

          // Store customer ID, to be used for further querying
          const customer_id = result.rows[0].customerid;
          const balance = result.rows[0].balance;

          // Before Insert a payment, check if the customer has enough balance which is
          // more than the price of the spot
          db.query(
              'SELECT price FROM spots WHERE spotid = $1', [spot_id],
              (err, result) => {
                if (err) {
                  console.log(err);
                } else {
                  const price = result.rows[0].price;
                  console.log(`[API] spot price is ${price}, continuing...`);

                  if (balance < price) {
                    res.status(403).send(
                        '     Customer balance is not enough to pay for this spot');
                  } else {
                    db.query(
                        'INSERT INTO payments (CustomerId, SpotId) VALUES ($1, $2)',
                        [customer_id, spot_id], (err, result) => {
                          if (err) {
                            console.log(err);
                          } else {
                            // update balance in customers table
                            db.query(
                                'UPDATE customers SET Balance = Balance - (SELECT Price FROM spots WHERE SpotId = $1) WHERE CustomerId = $2',
                                [spot_id, customer_id], (err, result) => {
                                  if (err) {
                                    console.log(err);
                                    // if error occurs, delete last made payment
                                    let lastPaymentDeleted = false;
                                    do {
                                      db.query(
                                          'DELETE FROM payments WHERE PaymentId = (SELECT MAX(PaymentId) FROM payments)',
                                          (err, result) => {
                                            if (err) {
                                              console.log(err);
                                            } else {
                                              lastPaymentDeleted = true;
                                            }
                                          });
                                    } while (!lastPaymentDeleted);
                                  } else {
                                    console.log('[API] payment added successfully');
                                    db.query(
                                        'SELECT Balance FROM customers WHERE CustomerId = $1',
                                        [customer_id], (err, result) => {
                                          if (err) {
                                            console.log(err);
                                          } else {
                                            console.log(
                                                '     and writing new balance to the card');
                                            res.status(200).send(result.rows);
                                          }
                                        });
                                  }
                                });
                          }
                        });
                  }
                }
              });
        }
      });
});

module.exports = router;