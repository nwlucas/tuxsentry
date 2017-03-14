const webpack = require('webpack');
const path = require('path');
const assetsRoot = path.resolve('../priv/static');
const StylExtract = require('extract-text-webpack-plugin');

function assetsPath(_dir) {
  return path.posix.join( assetsRoot, _dir)
}

module.exports = ( env = {}) => {

  const isProduction = env.production === true;
  const platform = env.platform;

  return {
    entry: {
      app: './js/main.js',
    },
    output: {
      path: assetsRoot,
      publicPath: '/',
      filename: 'js/app.js',
    },
    resolve: {
      extensions: [ '.js', '.json', '.vue' ],
      alias: {
        'vue$': 'vue/dist/vue.esm.js',
        '@': path.resolve( __dirname, 'js'),
        'jeet': 'jeet/styl/index.styl'
      },
    },
    module: {
      rules: [
        {
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          enforce: 'pre',
          include: [ path.resolve(__dirname, 'js'), path.resolve(__dirname, 'test') ],
          options: {
            formatter: require('eslint-friendly-formatter'),
          },
        },
        {
          test: /\.styl$/,
          loader: StylExtract.extract({
            use: ['css-loader','stylus-loader'],
          })
        },
        {
          test: /\.vue$/,
          loader: 'vue-loader',
          options: {

          },
        },
        {
          test: /\.js$/,
          loader: 'babel-loader',
          include: [ path.resolve(__dirname, 'js'), path.resolve(__dirname, 'test') ],
        },
        {
          test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
          loader: 'url-loader',
          options: {
            limit: 10000,
            name: assetsPath('images/[name].[hash:7].[ext]'),
          },
        },
        {
          test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
          loader: 'url-loader',
          options: {
            limit: 10000,
            name: assetsPath('fonts/[name].[hash:7].[ext]')
          },
        },
      ],
    },
    plugins: [
      new webpack.DefinePlugin({
        PRODUCTION: JSON.stringify(isProduction),
        PLATFORM: JSON.stringify(platform)
      }),
      new StylExtract({
        filename: 'css/app.css',
      })
    ],
    devtool: (() => {
      if (isProduction) return '#hidden-source-map'
      else return '#cheap-module-eval-source-map'
    }) ()
  }
};
