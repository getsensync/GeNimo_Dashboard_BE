const cors = require("cors");
const express = require("express");
require("dotenv").config();

// Connect to database
const db = require("./database");
db.connect((err) => {
  if (err) {
    console.log(err);
  } else {
    console.log("connected to database");
  }
});

// Create server
const app = express();
app.use(cors());
app.use(express.json());

// Set up RESTful API endpoint routes
const router = require("./Router/routes");
app.use(process.env.API_URI_PATH, router);

// API server listening
app.listen(process.env.API_PORT, () => {
  console.log(`Server is running on port ${process.env.API_PORT}`);
});