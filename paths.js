const path = require('path');

module.exports = {
  root: path.resolve(__dirname, '/'),
  outputPath: path.resolve(__dirname, 'dist'),
  entryPath: path.resolve(__dirname, '/', './index.tsx'),
  templatePath: path.resolve(__dirname, '/', './index.html'),
  imagesFolder: 'images',
  fontsFolder: 'fonts',
  cssFolder: 'css',
  jsFolder: 'js',
};
