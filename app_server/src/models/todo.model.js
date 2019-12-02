const mongoose = require("mongoose");

const todoSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, default: ""},
  completed: { type: Boolean, default: false },
  completedAt: { type: Date , default: null},
  createdAt: { type: Date, required: true }
});

const Todo = mongoose.model("todo", todoSchema);

module.exports = Todo;
