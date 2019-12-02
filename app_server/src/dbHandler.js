const mongoose = require("mongoose");
const process = require("process");
const {MongoMemoryServer} = require('mongodb-memory-server');

const mongod = new MongoMemoryServer();
 
module.exports = {
  
  async connect() {
    const uri = await mongod.getConnectionString();
    const mongooseOpts = {
        useNewUrlParser: true,
        autoReconnect: true,
        reconnectTries: Number.MAX_VALUE,
        reconnectInterval: 1000,
        useUnifiedTopology: true
    };

    await mongoose.connect(uri, mongooseOpts);
},

  close() {
    try {
      mongoose.connection.close();
    } catch (err) {
      console.log(err);
    }
  }
};

