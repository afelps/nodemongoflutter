const todoModel = require("../models/todo.model");
const BusinessError = require("../exceptions");

module.exports = {
  /*
   * Default Crud
   */

  async listAll() {
    return await todoModel.find();
  },

  async find(todoId) {
    const todo = await todoModel.findById(todoId);
    if (todo) {
      return todo;
    } else {
      throw new BusinessError(404, `Couldn't find Todo ${todoId}`);
    }
  },

  async create(todo) {
    try {
      todo.createdAt = new Date();
      return await todoModel.create(todo);
    } catch (err) {
      throw new BusinessError(400, `Malformed todo: ${err.message}`);
    }
  },

  async delete(todoId) {
    return await todoModel.deleteOne({ _id: todoId });
  },

  async update(todoId, todo) {
    await todoModel.updateOne({ _id: todoId }, todo);
    return await this.find(todoId);
  },

  /*
   * Specific actions
   */

  async complete(todoId) {
    const todo = await this.find(todoId);
    if (todo.completed) {
      throw new BusinessError(412, "Todo already completed");
    } else {
      todo.completed = true;
      todo.completedAt = new Date();
      return await this.update(todoId, todo);
    }
  },

  async uncomplete(todoId) {
    const todo = await this.find(todoId);
    if (!todo.completed) {
      throw new BusinessError(412, "Todo already not completed");
    } else {
      todo.completed = false;
      todo.completedAt = null;
      return await this.update(todoId, todo);
    }
  }
};
