const express = require("express");
const mongoose = require("mongoose");
const authRoutes = require("./routes/auth");
const app = express();
const PORT = 8000;
const DB =
  "mongodb+srv://pritesh:pritesh123@cluster0.ypkg5bi.mongodb.net/?retryWrites=true&w=majority";
app.use(express.json());
app.use("/auth", authRoutes);

// connections
mongoose
  .connect(DB)
  .then(() => console.log("connected to mongoDB"))
  .catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () =>
  console.log(`server connected at port ${PORT}`)
);
