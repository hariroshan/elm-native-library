const webpack = require("@nativescript/webpack");

module.exports = (env) => {
  webpack.init(env);

  // Learn how to customize:
  // https://docs.nativescript.org/webpack
  const config = webpack.resolveConfig()
  config.module.rules.push(
    {
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      use: [
        // warps elm code
        { loader: path.resolve('./elm-code-wrap-loader') },
        { loader: 'elm-webpack-loader' },
      ]
    }
  )
  return config;
};
