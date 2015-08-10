local handlers = {}

function addAjaxHandler(call, handler)
	handlers[call] = handler
end 

function removeAjaxHandler(call)
	handlers[call] = nil
end 

addEvent("onClientAJAXRequest")
addEventHandler("onClientAJAXRequest", root, 
	function(callid, call, ...)
		if not handlers[call] then 
			executeBrowserJavascript(source, ("mtajax.triggerCallback(%d, false, {})"):format(callid))
		else
			local retval = handlers[call](...)
			executeBrowserJavascript(source, ("mtajax.triggerCallback(%d, true, '%s')"):format(callid, toJSON(retval)))
		end
	end
)