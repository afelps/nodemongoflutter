const express = require("express");
const morgan = require("morgan");
const db = require("./src/dbHandler");
const { errorHandler } = require("./src/errorHandler");

const app = express();
const PORT = process.env.PORT || 3000;

db.connect();

app.use(express.json());
app.use(morgan("combined"));
app.use("/api/todo", require("./src/routers/todo.router"));
app.use(errorHandler);

app.listen(PORT, () => console.log(`Server running on port ${PORT}!`));
