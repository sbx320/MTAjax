--In order to render the browser on the full screen, we need to know the dimensions.
local screenWidth, screenHeight = guiGetScreenSize()
 
--Let's create a new browser in local mode. We will not be able to load an external URL.
local webBrowser = createBrowser(screenWidth, screenHeight, true, true)
 
--This is the function to render the browser.
function webBrowserRender()
	--Render the browser on the full size of the screen.
	dxDrawImage(0, 0, screenWidth, screenHeight, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
end
 outputChatBox"yo"
--The event onClientBrowserCreated will be triggered, after the browser has been initialized.
--After this event has been triggered, we will be able to load our URL and start drawing.
addEventHandler("onClientBrowserCreated", webBrowser, 
	function()
		--After the browser has been initialized, we can load our file.
		loadBrowserURL(webBrowser, "test.html")
		--Now we can start to render the browser.
		addEventHandler("onClientRender", root, webBrowserRender)
	end
)

addAjaxHandler("PlayerMoneyRequest",
	function(playername)
		local player = getPlayerFromName(playername)
		outputChatBox("Called" ..playername)
		if not player then return false end 
		
		return getPlayerMoney(player)
	end
)
addEventHandler("onClientBrowserDocumentReady", root,
	function(url)
		outputChatBox("Document ready: "..tostring(url))
	end
)

addEventHandler("onClientBrowserLoadingFailed", root,
	function(url, errorcode, desc)
		outputChatBox("onClientBrowserLoadingFailed("..tostring(url)..", "..tostring(errorcode)..", "..tostring(desc))
	end
)

addEventHandler("onClientBrowserNavigate", root,
	function(url, mainframe)
		outputChatBox(("Navigating to %s (mainframe: %s)"):format(url, tostring(mainframe)))
	end
)

addEventHandler("onClientBrowserPopup", root,
	function(targetURL, openerURL)
		outputChatBox(("TargetURL: %s OpenerURL: %s"):format(targetURL, openerURL))
	end
)