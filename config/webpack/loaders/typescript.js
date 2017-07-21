module.exports = {
  test: /\.ts$/,
  exclude: /node_modules|vue\/src/,
  loader: 'ts-loader',
  options: {
    appendTsSuffixTo: [/\.vue$/],
  },
};
