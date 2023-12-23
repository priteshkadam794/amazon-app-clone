const jwt = require("jsonwebtoken");
const secretKey = "$P#@@#*7^7$$";

function generateTokenForUser(id, email) {
  const token = jwt.sign({ id: id, email: email }, secretKey);
  return token;
}

function validateUserToken(token) {
  try {
    return jwt.verify(token, secretKey);
  } catch (e) {
    return false;
  }
}
module.exports = { generateTokenForUser, validateUserToken };
