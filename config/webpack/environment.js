const { environment } = require('@rails/webpacker')

environment.loaders.delete("node_modules")

module.exports = environment
