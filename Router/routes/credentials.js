const express = require("express");
const router = express.Router();
const db = require("../../utils/database");

// Get All account from credentials table
router.get("/credentials/all", (req, res) => {
  db.query("SELECT * FROM credentials ORDER BY id ASC", (err, result) => {
    if (err) {
      console.log(err);
    } else {
      console.log("[API] all credentials data fetched successfully");
      res.status(200).send(result.rows);
    }
  });
});

// Get account from credentials table by username or email
router.get("/credentials/certain/:term", (req, res) => {
  const { term } = req.params;
  db.query(
    "SELECT * FROM credentials WHERE username = $1 OR email = $1",
    [term],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] certain credentials data fetched successfully");
        res.status(200).send(result.rows);
      }
    }
  );
});

module.exports = router;