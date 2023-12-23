const { Schema, model } = require("mongoose");
const bcrypt = require("bcryptjs");
const userSchema = new Schema(
  {
    username: {
      type: String,
      trim: true,
      required: true,
    },

    email: {
      type: String,
      trim: true,
      required: true,
    },

    password: {
      type: String,
      trim: true,
      required: true,
    },

    address: {
      type: String,
      default: "",
    },

    userType: {
      type: String,
      enum: ["user", "admin", "seller"],
      default: "user",
    },
  },
  { timestamps: true }
);

userSchema.pre("save", async function (next) {
  const password = this.password;
  const hashedPassword = await bcrypt.hash(password, 8);
  this.password = hashedPassword;
  next();
});

const userModel = model("users", userSchema);

module.exports = userModel;
