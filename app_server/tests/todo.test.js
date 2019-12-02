const db = require("../src/dbHandler");
const todoService = require("../src/services/todo.service");

beforeAll(() => {
  db.connect();
});

afterAll( () => {
  db.close();
});


test('create todo with title and description and return object with id 2', async () => {
  result = await todoService.create({
    title: "title",
    description: "description",
  });  
  expect(result).toHaveProperty("_id");
});

test('should throw with empty todo', () => {
  expect(todoService.create({})).rejects.toThrow();
});
