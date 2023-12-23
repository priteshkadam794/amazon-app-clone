const { validateUserToken } = require("../services/auth");
const userModel = require("../models/user");
var nameRegex = /^[a-zA-Z\-]+$/;
const emailRegex =
  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
function validateSignUpDetails(req, res, next) {
  const { username, email, password } = req.body;
  if (username.match(nameRegex) == null) {
    return res.status(406).json({
      msg: "Please enter a valid user-name. username can start with [A-Z] , [a-z] followed by numbers and special symbols ",
    });
  }

  if (email.match(emailRegex) == null) {
    return res.status(406).json({ msg: "Please enter a valid email address" });
  }

  if (password.length < 6) {
    return res.status(406).json({
      msg: "Password too weak, it should be atleast 6 characters long",
    });
  }
  next();
}

async function handleUserAuthorization(req, res, next) {
  try {
    const token = req.headers["x-auth-token"];
    if (!token)
      return res
        .status(401)
        .json({ msg: "token is empty. Authorization failed" });
    const isValid = validateUserToken(token);
    if (isValid == false)
      return res.status(401).json({ msg: "token is invalid. Access Denied" });
    const user = await userModel.findById(isValid.id);
    if (!user)
      return res
        .status(401)
        .json({ msg: "user with given token does not exist" });

    req.user = user;
    req.token = token;
    next();
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
}

module.exports = { validateSignUpDetails, handleUserAuthorization };
