const express = require("express");
const router = express.Router();
const db = require("../../utils/database");

// ### LOGS ###

// Get Customer-log, Deposit-log, Payment-log data limit 200 total
router.get("/logs/all/:limit?", (req, res) => {
  const log_limit = req.params.limit || 200;
  let deposits = [];
  let payments = [];
  let customers = [];

  // Get Customers data
  const selectC = "c.CustomerUuid as uuid, c.CustomerName as name, c.createdAt as timestamp";
  const jointC = "FROM customers c";
  const orderC = "ORDER BY c.createdAt DESC";
  const limitC = "LIMIT 50"
  const customersQuery = `SELECT ${selectC} ${jointC} ${orderC} ${limitC}`;

  // Get Deposits data
  const selectD = "c.CustomerUuid as uuid, c.CustomerName as name, d.Amount, d.DepositTimestamp as timestamp";
  const jointD = "FROM deposits d LEFT JOIN customers c ON d.CustomerId = c.CustomerId";
  const orderD = "ORDER BY d.depositId DESC";
  const limitD = "LIMIT 50"
  const depositsQuery = `SELECT ${selectD} ${jointD} ${orderD} ${limitD}`;

  // Get Payments data
  const selectP = "c.CustomerUuid as uuid, c.CustomerName as name, s.SpotName as Spot, s.Price as Amount, p.PaymentTimestamp as timestamp";
  const jointP = "FROM payments p LEFT JOIN customers c ON p.CustomerId = c.CustomerId LEFT JOIN spots s ON p.SpotId = s.SpotId";
  const orderP = "ORDER BY p.PaymentId DESC";
  const limitP = "LIMIT 100"
  const paymentsQuery = `SELECT ${selectP} ${jointP} ${orderP} ${limitP}`;

  db.query(
    `${customersQuery}; ${depositsQuery}; ${paymentsQuery}`,
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        customers = result[0].rows;
        deposits = result[1].rows;
        payments = result[2].rows;
        customers.forEach(customer => {
          customer.spot = "-";
          customer.amount = 0;
          customer.type = "C";
        });
        deposits.forEach(deposit => {
          deposit.spot = "-";
          deposit.type = "D";
        });
        payments.forEach(payment => {
          payment.type = "K";
        });

        const logs = [...customers, ...deposits, ...payments];
        logs.sort((a, b) => {
          return b.timestamp - a.timestamp;
        });
        logs.splice(log_limit);
        console.log(`[API] get ${logs.length} logs successfully`);
        res.status(200).send(logs);
      }
    }
  );
});


//### UNIT TEST QUERY ### 

// // Get deposits data join with customers
// router.get("/logs/deposits/all", (req, res) => {
//   const customerQuery = "c.CustomerUuid as uuid, c.CustomerName as name";
//   const depositQuery = "d.Amount, d.DepositTimestamp as timestamp";
//   const jointQuery = "FROM deposits d LEFT JOIN customers c ON d.CustomerId = c.CustomerId";
//   const orderQuery = "ORDER BY d.depositId DESC";
//   const limitQuery = "LIMIT 50"
//   db.query(
//     `SELECT ${customerQuery}, ${depositQuery} ${jointQuery} ${orderQuery} ${limitQuery}`,
//     (err, result) => {
//       if (err) {
//         console.log(err);
//       } else {
//         console.log("[API] get all deposits successfully");
//         deposits = result.rows;
//         res.status(200).send(result.rows);
//       }
//     }
//   );
// });

// // Get payments data join with customers
// router.get("/logs/payments/all", (req, res) => {
//   const customerQuery = "c.CustomerUuid as uuid, c.CustomerName as name";
//   const paymentQuery = "s.SpotName as Spot, s.Price as Amount, p.PaymentTimestamp as timestamp";
//   const jointQuery = "FROM payments p LEFT JOIN customers c ON p.CustomerId = c.CustomerId LEFT JOIN spots s ON p.SpotId = s.SpotId";
//   const orderQuery = "ORDER BY p.PaymentId DESC";
//   const limitQuery = "LIMIT 100"
//   db.query(
//     `SELECT ${customerQuery}, ${paymentQuery} ${jointQuery} ${orderQuery} ${limitQuery}`,
//     (err, result) => {
//       if (err) {
//         console.log(err);
//       } else {
//         console.log("[API] get all payments successfully");
//         payments = result.rows;
//         res.status(200).send(result.rows);
//       }
//     }
//   );
// });

// // Get Customer data limit 50
// router.get("/logs/customers/all", (req, res) => {
//   const customerQuery = "CustomerUuid as uuid, CustomerName as name, createdAt as timestamp";
//   const jointQuery = "FROM customers";
//   const orderQuery = "ORDER BY createdAt DESC";
//   const limitQuery = "LIMIT 50"
//   db.query(
//     `SELECT ${customerQuery} ${jointQuery} ${orderQuery} ${limitQuery}`,
//     (err, result) => {
//       if (err) {
//         console.log(err);
//       } else {
//         console.log("[API] get all customers successfully");
//         res.status(200).send(result.rows);
//       }
//     }
//   );
// });


module.exports = router;