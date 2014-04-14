console.log("Hello World!");


Game.init = function() {
	console.log("INIT");

	/** TEST 1: Blue rectangle with red border, full window size */
	var Red = CreateColor(255, 0, 0, 255);
	var Blue = CreateColor(0, 0, 255, 255);

	//Rectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Red);
	//Rectangle(20, 20, GetScreenWidth()-40, GetScreenHeight()-40, Blue);

	FlipScreen();

	console.log("MX: "+Input.Mouse.x);
	console.log("MY: "+GetMouseY());
	console.log("NGP: "+Input.gamepads.length);

	console.log("GK: "+Input.Keyboard.getKey());
	console.log("GKS: "+Input.Keyboard.getKeyString(Input.Keyboard.getKey()));

	console.log("AXIS_Y: "+Input.Gamepad.AXIS_Y);

	console.log("BUTTON_RIGHT: "+Input.Mouse.BUTTON_RIGHT);
	console.log("KEY_A: "+Input.Keyboard.KEY_A);
	console.log("WHEEL_LEFT: "+Input.Mouse.Wheel.LEFT);
	console.log("ISB: "+Input.Mouse.isButtonPressed(Input.Mouse.BUTTON_LEFT));

}

Game.exit = function() {
	console.log("EXIT");
}

Game.loop = function() {
	//console.log("[MS] "+Input.Mouse.x+","+Input.Mouse.y);
}


/** TEST 1: OO code */
/*
var red = new Color(255, 0, 0);
var blue = new Color(0, 0, 255);

Screen.drawRect(0, 0, Screen.width, Screen.height, red);
Screen.drawRect(20, 20, Screen.width-40, Screen.height-40, blue);

Screen.flip();
*/


/*
var bonj1 = new Network.Bonjour();
bonj1.publish(12345,"Some Peer",function(status) {
    console.log("Publish status: "+status);
});

var bonj2 = new Network.Bonjour();
//bonj2.publish(12345);

bonj2.discover(function(error, peer) {
   if(error)
	  console.log("Error with discover: "+error);
   else
	console.log("Found peer: "+peer.name);
});
*/
//var s = new __Socket("www.google.com",80);
//console.log(String(s));
//console.log(s.connected);

//s.close();

//Network.listen(100);
//console.log(Network.localName);
//console.log(Network.localAddress);

//console.log(Network.bonjour.test());


//var bonj = new __Bonjour("My Game","_game._tcp","local");
//bonj.publish("My Game","_tcp",12345,"local.");
// bonj.discover(


// File System and File
//http://nodejs.org/api/fs.html
// fs.readFile(filename, [Options{flag,encoding}], cb(err, data))

// Modules
/*
var link = require("./link.js");
link.create("foo");

// in link.js:
exports.create = function(foo) { return "bar"; }

// or:
var JSON = require("./json.js");
var js = new JSON("{x:1}");

module.exports = function(string) { // the constructor
}
*/

// Folders as modules

// Create a folder, add a package.json with:
//{ "name":"Link","main":"./lib/link.js","version":"1.6"}
// Now require('./link') (if ./link is the lib folder) will load ./link/lib/link.js
// If no package.json found, load main.js

// require(x) always returns same object: no multi-eval! Allows transitive dependencies to be loaded
// because partially done can be returned

/*
Module {
	var id;
	var filename;
	var Promise<Boolean> loaded;
	var exports;
	// parent, children
	function require(id);
}

require(x)
require.resolve(x)
require.main set to the module when executing single module


// Net

createServer([options], [listener])
connect(options, [listener])
connect(port, [host], [listener])

net.Server {
	listen(port, cb)
	close(cb)
	unref()
	ref()
	maxConnections
	connections
	getConnections(cb)

	Events: listening, connection, close, error
}

net.Socket {
	new Socket([options])
	connect(port, [host], [listener])
	bufferSize
	write(data, [encoding], [cb])

	destroy()
	end([data],[encoding])
	pause()
	resume()

	setTimeout()
	setNoDelay()
	setKeepAlive()

	address()

	unref()
	ref()

	remoteAddress
	remotePort
	localAddress
	localPort
	bytesRead
	bytesWritten

	Events: connect, data, end, timeout, drain, error, close
}

net.Bonjour {
	// domain defaults to "", which results in .local
	// type defaults to "_game._tcp"
	function Bonjour([type, [domain]])

	var type; // String
	var domain; // String

	var state; // 'publishing', 'published', 'discovering'
	function isPublished(); // Boolean

	// publish a new service with known type and domain
	// name defaults to "" which causes the system to use the computer name
	// if no callback is supplied, no notification made about the status
	// cb = function(error, status)
	function publish([name],port,[cb])
 
	// discover services with known type and domain
	// cb is function(error, Bonjour.Peer);
	function discover(cb)
 
	// resolve a name to a host and port
	// cb = function(error, host, port)
	function resolve(name, cb) // to host+port
 
	// Stop publishing, resolving or discovering
	function stop();
}

net.Bonjour.Peer {
	var name;

	// resolve the peer to a host and port
	// cb = function(error, host, port)
	function resolve(cb)
 
	// returns net.Socket, not connected but intialized
	// only connect() will then be needed.
	function getSocket();
}

Game that will host:
 
 // Create a server
 var server = new Server();
 server.listen(12345, function(error, status, peerSocket) {
	if(error)
		throw error;
	if(peerSocket) {
		console.log("New Peer with address "+peerSocket.remoteAddress);
	} else
		console.log("Listening!");
 });

 // Publish the service
 var service = new Bonjour();
 service.publish("My Awesome Name",12345,function(error,status){
	if(error)
		throw error;
	console.log("Published service!");
});
 
 
 Game that wants to play:
 var service = new Bonjour();
 service.discover(function(error, peer) {
	if(error)
		throw error;
	console.log("Server found: "+peer.name);
 
	// Assume we want the first hit, to omit a UI now
	// stop the service
	service.stop();
 
	// connect to the peer
	var socket = peer.getSocket();
	socket.connect();
 
	// ... do whatever
 });
 

// net.Stream {}

net.Datagram {
	connect()
	bind()
	close()
}

os.hostname()
os.networkInterfaces()
*/

//GLOBAL
// In modules, the global scope is module-scope. Use some trick?
// console object // global
// function require() // global
// function require.resolve() // global
// var require.cache (KVS) // global
// __filename // filename of current module, local to each module
// __dirname // dirname of current module, local to each module
// module // , local to each module
// t = setTimeout(cb,ms)
// clearTimeout(t)
// t = setInterval(cb, ms)
// clearInterval(t)

// module.exports.Console = Console;
// module.exports.createServer = function() {}
// module.exports.<classname> = <classname>