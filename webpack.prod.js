const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const path = require('path');

const commonPaths = require('./paths');

module.exports = {
  mode: 'production',
  plugins: [new CleanWebpackPlugin()],
  devtool: 'source-map',
};
