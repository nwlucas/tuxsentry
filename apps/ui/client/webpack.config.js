const webpack = require('webpack');
const path = require('path');
const assetsRoot = path.resolve('../priv/static');
const StylExtract = require('extract-text-webpack-plugin');
const projectRoot = path.resolve(__dirname, './');
const vueLoaderConfig = require('./build/vue-loader.conf');

function assetsPath(_dir) {
  return path.join( assetsRoot, _dir)
}

module.exports = ( env = {}) => {

  const isProduction = env.production === true;
  const platform = env.platform;

  return {
    entry: {
      'app.js': ['./js/main.js'],
      'vendor.js': [
        'vue',
        'vue-router',
        'vuex',
        'vuex-router-sync',
        'axios',
        'vue-axios',
        'phoenix-socket'
      ],
    },
    output: {
      path: assetsRoot,
      publicPath: '/',
      filename: 'js/[name]',
    },
    resolve: {
      extensions: ['.js', '.json', '.vue', '.css'],
      modules: [
        path.resolve('js'),
        path.resolve('node_modules')
      ],
      alias: {
        vue$: 'vue/dist/vue.common.js',
        components: path.resolve(__dirname, 'components/'),
        layout: path.resolve(__dirname, 'components/layout/'),
        views: path.resolve(__dirname, 'views/'),
        images: path.resolve(__dirname, 'images'),
        'vuex-store': path.resolve(__dirname,'js/store/'),
        '@': path.resolve(__dirname, 'js'),
       },
    },
    module: {
      rules: [
        {
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          enforce: 'pre',
          include: projectRoot,
          exclude: /node_modules/,
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
          options: vueLoaderConfig,
        },
        {
          test: /\.js$/,
          loader: 'babel-loader',
          include: [ path.resolve(__dirname, 'js'), path.resolve(__dirname, 'test') ],
          exclude: [new RegExp(`node_modules\\${path.sep}(?!vue-bulma-.*)`)],
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
            name: 'fonts/[name].[hash:7].[ext]'
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
      new webpack.optimize.CommonsChunkPlugin({
        name: 'vendor.js',
        filename: 'js/vendor.js',
      }),
    ],
    devtool: (() => {
      if (isProduction) return '#hidden-source-map'
      else return '#cheap-module-eval-source-map'
    }) ()
  }
};
