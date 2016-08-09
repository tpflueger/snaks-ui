var path = require('path'),
	webpack = require('webpack'),
	CleanWebpackPlugin = require('clean-webpack-plugin');

require('es6-promise').polyfill();

const PATHS = {
	app: path.join(__dirname, 'src/main.js'),
	dest: path.join(__dirname, 'dest')
};

module.exports = {
	devServer: {
		contentBase: PATHS.dest,
		historyApiFallback: true,
		inline: true,
		progress: true
	},
	entry: {
		app: PATHS.app
	},
	output: {
		path: PATHS.dest,
		filename: '[name].js'
	},
	watchOptions: {
		poll: 1000,
		aggregateTimeout: 1000
	},
	plugins: [
		new CleanWebpackPlugin(['dest'], {
			root: __dirname,
			verbose: true,
			dry: false
		})
	],
	module: {
		loaders: [
			{
				test: /\.(css|scss)$/,
				loaders: [
					'style-loader',
					'css-loader',
				]
			},
			{
				test:    /\.html$/,
				exclude: /node_modules/,
				loader:  'file?name=[name].[ext]',
			},
			{
				test:    /\.elm$/,
				exclude: [/elm-stuff/, /node_modules/],
				loader:  'elm-webpack',
			},
			{
				test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
				loader: 'url-loader?limit=10000&minetype=application/font-woff',
			},
			{
				test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
				loader: 'file-loader',
			},
		],

		noParse: /\.elm$/,
	}
};