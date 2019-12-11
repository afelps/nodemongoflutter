const express = require("express");
const router = express.Router();
const todoService = require("../services/todo.service");

router.get("/", async (req, res, next) => {
  try {
    const todoList = await todoService.listAll();
    res.json(todoList);
  } catch (err) {
    next(err);
  }
});

router.get("/:todoId", async (req, res, next) => {
  try {
    const todoId = req.params.todoId;
    const todo = await todoService.find(todoId);
    res.json(todo);
  } catch (err) {
    next(err);
  }
});

router.post("/", async (req, res, next) => {
  try {
    const todo = req.body;
    const inserted = await todoService.create(todo);
    res.json(inserted);
  } catch (err) {
    next(err);
  }
});

router.delete("/:todoId", async (req, res, next) => {
  try {
    const todoId = req.params.todoId;
    await todoService.delete(todoId);
    res.sendStatus(200);
  } catch (err) {
    next(err);
  }
});

router.put("/:todoId", async (req, res, next) => {
  try {
    const todoId = req.params.todoId;
    const todo = req.body;
    const updatedTodo = await todoService.update(todoId, todo);
    res.json(updatedTodo);
  } catch (err) {
    next(err);
  }
});

router.put("/:todoId/complete", async (req, res, next) => {
  try {
    const todoId = req.params.todoId;
    completed = await todoService.complete(todoId);
    res.status(200).json(completed);
  } catch (err) {
    next(err);
  }
});

router.put("/:todoId/uncomplete", async (req, res, next) => {
  try {
    const todoId = req.params.todoId;
    uncompleted = await todoService.uncomplete(todoId);
    res.status(200).json(uncompleted);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
