module.exports = (req, res) => {
  res.status(404).json({ message: '404 - Page Not Found' })
}