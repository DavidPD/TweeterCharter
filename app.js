// Registers the coffee compiler so we can treat coffeescript files like normal node modules.
require('coffee-script/register');
// Run the server written in coffeescript.
require('./server').run();