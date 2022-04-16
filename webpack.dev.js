const path = require('path');

module.exports = {
  mode: 'development',
  devtool: false,
  watchOptions: {
    poll: 500,
    ignored: ['./node_modules'],
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'src'),
      publicPath: '/',
    },
    compress: true,
    port: 9000,
    allowedHosts: 'all',
    open: '/',
    historyApiFallback: true,
  },
};
