function waitFor(testFx, onReady, timeOutMillis) {
	var maxtimeOutMillis = timeOutMillis ? timeOutMillis : 3000, //< Default Max Timout is 3s
		start = new Date().getTime(),
		condition = false,
		interval = setInterval(function() {
			if ((new Date().getTime() - start < maxtimeOutMillis) && !condition) {
				// If not time-out yet and condition not yet fulfilled
				condition = (typeof(testFx) === "string" ? eval(testFx) : testFx()); //< defensive code
			} else {
				if (!condition) {
					// If condition still not fulfilled (timeout but condition is 'false')
					console.log("'waitFor()' timeout");
					phantom.exit(1);
				} else {
					// Condition fulfilled (timeout and/or condition is 'true')
					console.log("'waitFor()' finished in " + (new Date().getTime() - start) + "ms.");
					typeof(onReady) === "string" ? eval(onReady): onReady(); //< Do what it's supposed to do once the condition is fulfilled
					clearInterval(interval); //< Stop this interval
				}
			}
		}, 250); //< repeat check every 250ms
};

console.log("Start load www.dayan.io");
var url = 'http://www.dayan.io';
var fs = require('fs');
var f = fs.open("a.html", 'r');
//var url = "http://d.weibo.com/100803?refer=index_hot_new"
var page = require('webpage').create();

/*************************
Test with localfile
*************************/
console.log(fs.absolute("a.html"));
page.open('file://' + fs.absolute("a.html"), function(status) {
	console.log(page.content)
	waitFor(function() {
		// Check in the page if a specific element is now visible
		return page.evaluate(function() {
			return $(".m_wrap clearfix").is(":visible");
		});
	}, function() {
		console.log("The sign-in dialog should be visible now.");
		phantom.exit();
	});
});


// page.open(url, function(status) {
// 	page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
// 		var titles = page.evaluate(function(){
// 			return $(".welcome-feed--name").text();
// 		})
// 		console.log(titles);
// 		// waitFor(function() {
// 		// 	return page.evaluate(function() {
// 		// 		return $("#Pl_Discover_Pt6Rank__5").is(":visiable");
// 		// 	}, function() {
// 		// 		console.log('1111111');
// 		// 		var foo = page.evaluate(function() {
// 		// 			return $("#Pl_Discover_Pt6Rank__5").text;
// 		// 		});
// 		// 		console.log('2222222');
// 		// 		phantom.exit();
// 		// 	})
// 		// });
// 	});
// });