mouseSet = "CGUI-Images"
mouseName = "OUT"
showVioGUIMouse = true

_guiCreateButton = guiCreateButton
_guiCreateWindow = guiCreateWindow
_guiCreateMemo = guiCreateMemo
_guiCreateEdit = guiCreateEdit
_guiCreateStaticImage = guiCreateStaticImage
_guiCreateLabel = guiCreateLabel
_guiCreateCheckBox = guiCreateCheckBox
_guiCreateComboBox = guiCreateComboBox
_guiCreateGridList = guiCreateGridList
_guiCreateProgressBar = guiCreateProgressBar
_guiCreateRadioButton = guiCreateRadioButton
_guiCreateScrollBar = guiCreateScrollBar
_guiCreateScrollPane = guiCreateScrollPane
_guiCreateTabPanel = guiCreateTabPanel
_guiCreateTab = guiCreateTab
_guiSetInputEnabled = guiSetInputEnabled

numberFieldData = {}
progressBarData = {}

function westsideGuiCreateProgressBar ( x, y, width, height, bool, startValue, parent )

	if not parent then
		parent = nil
	end
	if startValue then
		startValue = math.abs ( tonumber ( startValue ) )
	end
	if not startValue then
		startValue = 0
	end
	
	if bool then
		width = width * screenwidth
		height = height * screenheight
	end
	
	local pxSizeW = width / 72 * 5
	local pxSizeH = height / 15 * 3
	
	local base = guiCreateStaticImage ( x, y, width, height, "images/gui/bar/bar_c1.png", false, parent )
	guiCreateStaticImage ( 0, 0, width, pxSizeH, "images/colors/c_black.jpg", false, base ) -- upper bar
	guiCreateStaticImage ( 0, height - pxSizeH, width, pxSizeH, "images/colors/c_black.jpg", false, base ) -- bottom bar
	guiCreateStaticImage ( 0, 0, pxSizeW, height, "images/colors/c_black.jpg", false, base ) -- left bar
	guiCreateStaticImage ( width - pxSizeW, 1, pxSizeW, height, "images/colors/c_black.jpg", false, base ) -- right bar
	
	progressBarData[base] = guiCreateStaticImage ( pxSizeW, pxSizeH * 2, ( width - 2 * ( pxSizeW ) ) * startValue, height - 2 * ( pxSizeH ) - 1, "images/gui/bar/bar_c2.png", false, base )
	
	return base
end

function vioGuiSetProgressBarFuelState ( bar, fuelState )

	width, height = guiGetSize ( bar, false )
	
	destroyElement ( progressBarData[bar] )
	
	local pxSizeW = width / 72 * 5
	local pxSizeH = height / 15 * 3
	
	progressBarData[bar] = guiCreateStaticImage ( pxSizeW, pxSizeH, ( width - 2 * ( pxSizeW ) ) * fuelState, height - 2 * ( pxSizeH ) - 1, "images/gui/bar/bar_c2.png", false, bar )
end

function guiCreateNumberField ( x, y, width, height, startValue, bool, parent, integer, abs )

	startValue = tonumber ( startValue )
	if integer == nil then
		integer = true
	end
	if abs == nil then
		abs = true
	end
	if not startValue then
		startValue = 0
	end
	if integer then
		startValue = math.floor ( startValue + 0.5 )
	end
	if abs then
		startValue = math.abs ( startValue )
	end
	local edit = guiCreateEdit ( x, y, width, height, tostring ( startValue ), bool, parent )
	if edit then
		numberFieldData[edit] = {}
			numberFieldData[edit]["oldValue"] = startValue
			numberFieldData[edit]["abs"] = abs
			numberFieldData[edit]["integer"] = integer
		addEventHandler ( "onClientGUIChanged", edit, 
			function ()
				local ctext = tonumber ( guiGetText ( source ) )
				if ctext then
					local int = numberFieldData[source]["integer"]
					local abs = numberFieldData[source]["abs"]
					if abs then
						if not ( math.abs ( ctext ) == ctext ) then
							guiSetText ( source, tostring ( numberFieldData[source]["oldValue"] ) )
						end
					end
					if int then
						if not ( math.floor ( ctext + 0.5 ) == ctext ) then
							guiSetText ( source, tostring ( numberFieldData[source]["oldValue"] ) )
						end
					end
				elseif guiGetText ( source ) == "" then
					guiSetText ( source, "0" )
				else
					guiSetText ( source, tostring ( numberFieldData[source]["oldValue"] ) )
				end
				numberFieldData[edit]["oldValue"] = tonumber ( guiGetText ( source ) )
			end
		)
	end
	return edit
end

function guiDebugClick ()

	if getElementType ( source ) == "gui-staticimage" and not ( colorSelectionImage == source ) then
		guiMoveToBack ( source )
	end
end
addEventHandler ( "onClientGUIClick", getRootElement(), guiDebugClick )

function guiSetFontSize ( element, size )

	return guiSetProperty ( element, "", size )
end

function setHudLessModeEnabled ( bool )

	bool = not bool
	showChat ( bool )
	showPlayerHudComponent ( "radar", bool )
end

function guiSetInputEnabled ( bool )

	toggleControl ( "chatbox", bool )
end

function guiSetToolTip ( element, toolTip )

end

function guiCreateScrollPane ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateScrollPane ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateTabPanel ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateTabPanel ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateTab ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateTab ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end


function guiCreateCheckBox ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateCheckBox ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateComboBox ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateComboBox ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateGridList ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateGridList ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateProgressBar ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateProgressBar ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateRadioButton ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateRadioButton ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateScrollBar ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateScrollBar ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateButton ( x, y, width, height, text, relative, parent )

	local btn = _guiCreateButton ( x, y, width, height, text, relative, parent )
	guiSetFont ( btn, "default-bold-small" )
	return btn
end

function guiCreateWindow ( x, y, width, height, titleBarText, relative )

	local element = _guiCreateWindow ( x, y, width, height, titleBarText, relative )
	
	guiWindowSetSizable ( element, false )
	guiWindowSetMovable ( element, false )
	
	return element
end

function guiCreateMemo ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateMemo ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateEdit ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateEdit ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateStaticImage ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateStaticImage ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function guiCreateLabel ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateLabel ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	return element
end

function mouseRender ()

	if getElementData ( lp, "cursorShowing" ) then
		local x, y = getCursorPosition ()
		if showVioGUIMouse then
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), mouseRender )--[[]]

_showCursor = showCursor

function showCursor ( bool )

	setElementData ( lp, "cursorShowing", bool )
	return _showCursor ( bool )
end

function slowDrawText ( string )

	local length = #string
	local totalTime = length * timeForEveryLetter + 2500
	addEventHandler ( "onClientRender", getRootElement(), slowDrawText_render )
	curTextDrawString = ""
	for i = 1, length do
		setTimer ( redoDrawString, i * timeForEveryLetter + 1, 1, string, i )
	end
	setTimer ( removeLetterDraw, totalTime, 1 )
end

function DrawText ( string )
	addEventHandler ( "onClientRender", getRootElement(), anzeige_render )
	setTimer ( function () removeEventHandler ( "onClientRender", getRootElement(), anzeige_render ) end, 4900, 1 )
	curText = string
end


function DrawText2 ( string )
	addEventHandler ( "onClientRender", getRootElement(), anzeige_render )
	setTimer ( function () removeEventHandler ( "onClientRender", getRootElement(), anzeige_render ) end, 500, 1 )
	curText = string
end

function redoDrawString ( string, i )
	curTextDrawString = string.sub ( string, 1, i )
end

function removeLetterDraw ()
	removeEventHandler ( "onClientRender", getRootElement(), slowDrawText_render )
end

function slowDrawText_render ()
	
	left, top, right, bottom = 0, 0, screenwidth, screenheight
	dxDrawText ( curTextDrawString, left, top, right, bottom, tocolor ( 0,150,200, 255 ), 1.0, "bankgothic", "center", "center", false, false, true )
end

function anzeige_render ()
	
	left, top, right, bottom = 0, 0, screenwidth, screenheight
	dxDrawText(curText, left, top, right, bottom, tocolor(4, 122, 1, 255), 2.50, "default-bold", "center", "bottom", false, false, true, false, false)
end

local guiElementToolTips = {}
local guiElementToolImages = {}

function guiGetScreenPosition ( element )

	local x, y = guiGetPosition ( element, false )
	local parent = getElementParent ( element )
	if parent and not ( getElementType ( parent ) == "guiroot" ) then
		local nx, ny = guiGetScreenPosition ( parent, false )
		return x + nx, y + ny
	else
		return x, y
	end
end