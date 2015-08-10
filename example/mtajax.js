var activeRequests = {}
var requestCounter = 0;
mtajax = {}
mtajax.makeRequest = function ()
{
	var args  = Array.prototype.slice.call(arguments);
	var arglist = [ "onClientAJAXRequest", requestCounter ];
	
	arglist.push.apply(arglist, args);
	mta.triggerEvent.apply(null, arglist)
	
	var def = $.Deferred();
	activeRequests[requestCounter] = def;
	requestCounter++;
	
	
	return def.promise();
}

mtajax.triggerCallback = function (callid, good, args)
{
	if(good)
		activeRequests[callid].resolve.apply(null, jQuery.parseJSON(args));
	else 
		activeRequests[callid].reject();
}