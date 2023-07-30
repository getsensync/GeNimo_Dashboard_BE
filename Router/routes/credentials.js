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

// Patch to change first_name, last_name, and phone from credentials table by username
router.patch("/credentials/changeProfile", (req, res) => {
  const { username } = req.body;
  const { first_name } = req.body;
  const { last_name } = req.body;
  const { phone } = req.body;
  db.query(
    "UPDATE credentials SET first_name = $1, last_name = $2, phone = $3 WHERE username = $4",
    [first_name, last_name, phone, username],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] profile credentials changed successfully");
        res.status(200).send("success");
      }
    }
  );
});

// Patch to change password from credentials table by username
router.patch("/credentials/changePassword", (req, res) => {
  const { username } = req.body;
  const { old_password } = req.body;
  const { new_password } = req.body;
  // check if old password is correct
  db.query(
    "SELECT password FROM credentials WHERE username = $1",
    [username],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        if (result.rows[0].password === old_password) {
          // if old password is correct, change password
          db.query(
            "UPDATE credentials SET password = $1 WHERE username = $2",
            [new_password, username],
            (err, result) => {
              if (err) {
                console.log(err);
              } else {
                console.log("[API] password credentials changed successfully");
                res.status(200).send("Password updated successfully");
              }
            }
          );
        } else {
          console.log("[API] Old password is incorrect. Failed to change password");
          res.status(422).send("Old password is incorrect. Failed to change password");
        }
      }
    }
  );
});


// Patch last_login column from credentials table by username
router.patch("/credentials/last_login/:username", (req, res) => {
  const { username } = req.params;
  db.query(
    "UPDATE credentials SET last_login = NOW() WHERE username = $1",
    [username],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log("[API] last_login credentials data updated successfully");
        res.status(200).send("last_login updated successfully");
      }
    }
  );
});


// Add new account to credentials table (register purpose)
router.post("/credentials/add", (req, res) => {
  const { username, email, password, role, first_name, last_name, gender } = req.body;
  // username and email must be unique from others account
  db.query(
    "SELECT * FROM credentials WHERE username = $1 OR email = $2",
    [username, email],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        const isExist = result.rows.length > 0;
        if (isExist) {
          console.log("[API] Account already exist. Failed to add new account");
          res.status(200).send("Username/email already exist. Failed to add new account");
        } else {
          db.query(
            "INSERT INTO credentials (username, email, password, role, first_name, last_name, gender) VALUES ($1, $2, $3, $4, $5, $6, $7)",
            [username, email, password, role, first_name, last_name, gender],
            (err, result) => {
              if (err) {
                console.log(err);
              } else {
                console.log("[API] account added successfully");
                res.status(200).send("Account added successfully");
              }
            }
          );
        }
      }
    }
  );
});


module.exports = router;