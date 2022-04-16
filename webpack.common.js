const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require('path');
const commonPaths = require('./paths');

module.exports = {
  entry: {
    main: './index.tsx',
  },
  output: {
    path: commonPaths.outputPath,
    filename: '[name].[contenthash].bundle.js',
    publicPath: '/',
  },
  context: path.resolve(__dirname, 'src'),
  plugins: [
    new webpack.ProgressPlugin(),
    new HtmlWebpackPlugin({
      template: commonPaths.templatePath,
    }),
  ],
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.(glsl)$/,
        use: ['raw-loader'],
      },
    ],
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
};
