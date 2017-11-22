_= require "underscore"
path= require "path"
webpack= require "webpack"
env= process.env
host  = env.npm_config_host ? "localhost"
port  = env.npm_config_port ? "8080"
env   = env.NODE_ENV        ? "development"

module.exports=
  entry: index: ["./index.coffee"]
  output: path: path.resolve("__bundled__") , filename: "[name].js", publicPath: "http://#{host}:#{port}/"
  devtool: "inline-source-map"
  devServer: {host, port}
  resolve:
    alias:
      vue: path.resolve("node_modules/vue/dist/vue.esm.js")
      vuex: path.resolve("node_modules/vuex/dist/vuex.esm.js")
  module:
    rules: _.values do ->
      Js    : test: /\.js$/, loader: "babel-loader", exclude: /node_modules/, options: presets:["env"]
      Coffee: test: /\.coffee$/, loader: "coffee-loader"
      Pug   : test: /\.pug$/, loader: "pug-loader"
      Vue   : test: /\.vue$/, loader: "vue-loader"
 
  plugins: _.compact _.flatten _.values
    Define  : new webpack.DefinePlugin
      "process.env": NODE_ENV:  JSON.stringify if env is "development" then "development" else "production"
    Provide : new webpack.ProvidePlugin
      _: "underscore"
    Html    : do ->
      Plugin= require "html-webpack-plugin"
      _.values
        Development: new Plugin
          template : "template.pug"
          filename : "index.html"
          inject: off, env: env
