const { Router } = require("express");
const {
  validateSignUpDetails,
  handleUserAuthorization,
} = require("../middlewares/auth");
const {
  handleUserSignUpController,
  handleUserSignInController,

  handleGetUserDataController,
} = require("../controllers/auth");
const authRoutes = Router();

authRoutes.post("/signup", validateSignUpDetails, handleUserSignUpController);
authRoutes.post("/signin", handleUserSignInController);
authRoutes.get(
  "/getUserData",
  handleUserAuthorization,
  handleGetUserDataController
);
module.exports = authRoutes;
