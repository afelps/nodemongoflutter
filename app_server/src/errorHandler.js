module.exports = {
  async errorHandler(err, req, res, next) {
    if (err) {
      console.error(err.stack);
      const status = err.status || 500;
      const message = err.message || "Unknown Error";
      res.status(status).json({ message: message });
    } else {
      next();
    }
  }
};
