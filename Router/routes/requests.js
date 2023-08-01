const express = require("express");
const router = express.Router();
const db = require("../../utils/database");

// get all requests
router.get("/requests/all", async (req, res) => {
  db.query(
    "SELECT * FROM requests r LEFT JOIN credentials c on r.userId = c.id ORDER BY RequestId ASC",
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] all requests data fetched successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// get requests with status = false
router.get("/requests/false", async (req, res) => {
  db.query(
    "SELECT * FROM requests r LEFT JOIN credentials c on r.userId = c.id WHERE r.status = false ORDER BY RequestId ASC",
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] false requests data fetched successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

// approve request (status = true), approve by adminId with approveBy = adminId
// also add approved_timestamp = current time
router.patch("/requests/approve", async (req, res) => {
  const { userId, adminId } = req.body;
  // set role = admin in credentials table where id = userId
  db.query(
    "UPDATE credentials SET role = 'admin' WHERE id = $1",
    [userId],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        db.query(
          "UPDATE requests SET status = true, approveBy = $1, approved_timestamp = CURRENT_TIMESTAMP WHERE userId = $2",
          [adminId, userId],
          (err, result) => {
            if (err) {
              console.log(err);
            } else {
              requestUpdated = true;
              console.log("[API] request approved successfully");
              res.status(200).send(result.rows);
            }
          }
        );
      }
    }
  );
});

// add/update request (timestamp = current time)
router.post("/requests/update", async (req, res) => {
  const { userId } = req.body;
  // first check if there is a request with userId
  // if there is, update timestamp where status = false, else add request
  db.query(
    "SELECT * FROM requests WHERE userId = $1",
    [userId],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        if (result.rows.length === 0) {
          db.query(
            "INSERT INTO requests (userId) VALUES ($1)",
            [userId],
            (err, result) => {
              if (err) {
                console.log(err);
              } else {
                console.log("[API] request added successfully");
                res.status(200).send(result.rows);
              }
            }
          );
        } else {
          db.query(
            "UPDATE requests SET timestamp = CURRENT_TIMESTAMP WHERE userId = $1 AND status = false",
            [userId],
            (err, result) => {
              if (err) {
                console.log(err);
              } else {
                console.log("[API] request updated successfully");
                res.status(200).send(result.rows);
              }
            }
          );
        }
      }
    }
  );
});

module.exports = router;