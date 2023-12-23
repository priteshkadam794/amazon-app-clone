const userModel = require("../models/user");
const bcrypt = require("bcryptjs");
const { generateTokenForUser, validateUserToken } = require("../services/auth");

async function handleUserSignUpController(req, res) {
  const { username, email, password } = req.body;
  try {
    const findUser = await userModel.findOne({ email });
    if (findUser != null)
      return res
        .status(400)
        .json({ msg: "email already exits.! SignIn instead." });

    const user = await userModel.create({
      username,
      email,
      password,
    });
    res.body = user;
    return res
      .status(200)
      .json({ msg: "Registration successfull. Login with same credentials!" });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
}

async function handleUserSignInController(req, res) {
  const { email, password } = req.body;
  try {
    const getUser = await userModel.findOne({ email });
    if (!getUser) return res.status(400).json({ msg: "user does not exist." });

    const isMatch = await bcrypt.compare(password, getUser.password);
    if (isMatch == false)
      return res.status(400).json({ msg: "Invalid Password" });

    const token = generateTokenForUser(getUser._id, getUser.email);

    return res.status(200).json({ token: token, ...getUser._doc });
  } catch (e) {
    return res
      .status(500)
      .json({ error: "Cannot Validate User. Please try again later!" });
  }
}

async function handleGetUserDataController(req, res) {
  const user = req.user;
  const token = req.token;
  return res.status(200).json({ ...user._doc, token });
}

module.exports = {
  handleUserSignUpController,
  handleUserSignInController,
  handleGetUserDataController,
};
