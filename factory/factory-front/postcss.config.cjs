const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');
const nestedpostcss = require('postcss-nesting')

const config = {
	plugins: [
		//Some plugins, like tailwindcss/nesting, need to run before Tailwind,
		nestedpostcss(),
		tailwindcss(),
		//But others, like autoprefixer, need to run after,
		autoprefixer()
	]
};

module.exports = config;
