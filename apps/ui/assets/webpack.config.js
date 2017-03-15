const webpack = require('webpack');
const path = require('path');
const assetsRoot = path.resolve('../priv/static');
const StylExtract = require('extract-text-webpack-plugin');

function assetsPath(_dir) {
  return path.join( assetsRoot, _dir)
}

module.exports = ( env = {}) => {

  const isProduction = env.production === true;
  const platform = env.platform;

  return {
    entry: {
      'js/app.js': './js/main.js',
      'css/app.css': './styles/style.scss',
    },
    output: {
      path: assetsRoot,
      publicPath: '/',
      filename: '[name]',
    },
    resolve: {
      extensions: [ '.js', '.json', '.vue' ],
      alias: {
        'vue$': 'vue/dist/vue.esm.js',
        '@': path.resolve( __dirname, 'js'),
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
          test: /\.scss$/,
          loader: StylExtract.extract({
            use: ['css-loader','sass-loader'],
          })
        },
        {
          test: /\.vue$/,
          loader: 'vue-loader',
          options: {
            loaders: {
              'scss': [ 'vue-style-loader', 'css-loader', 'sass-loader'],
              'sass': ['vue-style-loader', 'css-loader', 'sass-loader?indentedSyntax' ]
            }
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
            name: 'images/[name].[ext]?[hash:7]',
          },
        },
        {
          test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
          loader: 'url-loader',
          options: {
            limit: 10000,
            name: 'fonts/[name].[ext]'
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
      }),
    ],
    devtool: (() => {
      if (isProduction) return '#hidden-source-map'
      else return '#cheap-module-eval-source-map'
    }) ()
  }
};
