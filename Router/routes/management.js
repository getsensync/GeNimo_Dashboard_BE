const express = require("express");
const router = express.Router();

// ### DATA MANAGEMENT ###

// # M-CUSTOMERS
const mCustomers = require("./management/m-customers");
// # M-SPOTS
const mSpots = require("./management/m-spots");

router.use(mCustomers);
router.use(mSpots);

module.exports = router;