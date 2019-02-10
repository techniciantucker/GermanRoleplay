local screenx, screeny = guiGetScreenSize()
local valx, valy = screenx/1366, screeny/768
sw, sh = guiGetScreenSize()

pickerTable = {}

Colorpicker = {}
Colorpicker.__index = Colorpicker

function openPicker(id, start, title)
  if id and not pickerTable[id] then
    pickerTable[id] = Colorpicker.create(id, start, title)
    pickerTable[id]:updateColor()
    return true
  end
  return false
end

function closePicker(id)
  if id and pickerTable[id] then
    pickerTable[id]:destroy()
    return true
  end
  return false
end


function Colorpicker.create(id, start, title)
  local cp = {}
  setmetatable(cp, Colorpicker)
  cp.id = id
  cp.color = {}
  cp.color.h, cp.color.s, cp.color.v, cp.color.r, cp.color.g, cp.color.b, cp.color.hex = 0, 1, 1, 255, 0, 0, "#FF0000"
  cp.color.white = tocolor(255,255,255,255)
  cp.color.black = tocolor(0,0,0,255)
  cp.color.current = tocolor(255,0,0,255)
  cp.color.huecurrent = tocolor(255,0,0,255)
  if start and getColorFromString(start) then
    cp.color.h, cp.color.s, cp.color.v = rgb2hsv(getColorFromString(start))
  end
  cp.gui = {}
  cp.gui.width = 416
  cp.gui.height = 304
  cp.gui.snaptreshold = 0.02
  cp.gui.window = guiCreateWindow((sw-cp.gui.width)/1.3, 0, cp.gui.width, cp.gui.height, tostring(title or "Colorpicker"), false)
  cp.gui.svmap = guiCreateStaticImage(16*valx, 32*valy, 256*valx, 256*valy, "Carsystem/Spezialtunings/Colorpicker/Blank.png", false, cp.gui.window)
  cp.gui.hbar = guiCreateStaticImage(288*valx, 32*valy, 32*valx, 256*valy, "Carsystem/Spezialtunings/Colorpicker/Blank.png", false, cp.gui.window)
  cp.gui.Blank = guiCreateStaticImage(336*valx, 32*valy, 64*valx, 64*valy, "Carsystem/Spezialtunings/Colorpicker/Blank.png", false, cp.gui.window)
  cp.gui.edith = guiCreateLabel(338*valx, 106*valy, 64*valx, 20*valy, "H: 0°", false, cp.gui.window)
  cp.gui.edits = guiCreateLabel(338*valx, 126*valy, 64*valx, 20*valy, "S: 100%", false, cp.gui.window)
  cp.gui.editv = guiCreateLabel(338*valx, 146*valy, 64*valx, 20*valy, "V: 100%", false, cp.gui.window)
  cp.gui.editr = guiCreateLabel(338*valx, 171*valy, 64*valx, 20*valy, "R: 255", false, cp.gui.window)
  cp.gui.editg = guiCreateLabel(338*valx, 191*valy, 64*valx, 20*valy, "G: 0", false, cp.gui.window)
  cp.gui.editb = guiCreateLabel(338*valx, 211*valy, 64*valx, 20*valy, "B: 0", false, cp.gui.window)
  cp.gui.okb = guiCreateButton(336*valx, 235*valy, 64*valx, 24*valy, "OK", false, cp.gui.window)
  cp.gui.closeb = guiCreateButton(336*valx, 265*valy, 64*valx, 24*valy, "Cancel", false, cp.gui.window)
  guiWindowSetSizable(cp.gui.window, false)	
  cp.handlers = {}
  cp.handlers.mouseDown = function() cp:mouseDown() end
  cp.handlers.mouseSnap = function() cp:mouseSnap() end
  cp.handlers.mouseUp = function(b,s) cp:mouseUp(b,s) end
  cp.handlers.mouseMove = function(x,y) cp:mouseMove(x,y) end
  cp.handlers.render = function() cp:render() end
  cp.handlers.guiFocus = function() cp:guiFocus() end
  cp.handlers.guiBlur = function() cp:guiBlur() end
  cp.handlers.pickColor = function() cp:pickColor() end
  cp.handlers.destroy = function() cp:destroy() end
  addEventHandler("onClientGUIMouseDown", cp.gui.svmap, cp.handlers.mouseDown, false)
  addEventHandler("onClientMouseLeave", cp.gui.svmap, cp.handlers.mouseSnap, false)
  addEventHandler("onClientMouseMove", cp.gui.svmap, cp.handlers.mouseMove, false)
  addEventHandler("onClientGUIMouseDown", cp.gui.hbar, cp.handlers.mouseDown, false)
  addEventHandler("onClientMouseMove", cp.gui.hbar, cp.handlers.mouseMove, false)
  addEventHandler("onClientClick", root, cp.handlers.mouseUp)
  addEventHandler("onClientGUIMouseUp", root, cp.handlers.mouseUp)
  addEventHandler("onClientRender", root, cp.handlers.render)
  addEventHandler("onClientGUIFocus", cp.gui.window, cp.handlers.guiFocus, false)
  addEventHandler("onClientGUIBlur", cp.gui.window, cp.handlers.guiBlur, false)
  addEventHandler("onClientGUIClick", cp.gui.okb, cp.handlers.pickColor, false)
  addEventHandler("onClientGUIClick", cp.gui.closeb, cp.handlers.destroy, false)  
  showCursor(true)
  return cp
end

function Colorpicker:render()
  local x,y = guiGetPosition(self.gui.window, false)
  dxDrawRectangle((x+16)*valx, (y+32)*valy, 256*valx, 256*valy, self.color.huecurrent, self.gui.focus)
  dxDrawImage((x+16)*valx, (y+32)*valy, 256*valx, 256*valy, "Carsystem/Spezialtunings/Colorpicker/SV.png", 0, 0, 0, self.color.white, self.gui.focus)
  dxDrawImage((x+288)*valx, (y+32)*valy, 32*valx, 256*valy, "Carsystem/Spezialtunings/Colorpicker/H.png", 0, 0, 0, self.color.white, self.gui.focus)
  dxDrawImageSection((x+8+math.floor(256*self.color.s))*valx, (y+24+(256-math.floor(256*self.color.v)))*valy, 16*valx, 16*valy, 0*valx, 0*valy, 16*valx, 16*valy, "Carsystem/Spezialtunings/Colorpicker/Cursor.png", 0, 0, 0, self.color.white, self.gui.focus)
  dxDrawImageSection((x+280)*valx, (y+24+(256-math.floor(256*self.color.h)))*valy, 48*valx, 16*valy, 16*valx, 0*valy, 48*valx, 16*valy, "Carsystem/Spezialtunings/Colorpicker/Cursor.png", 0, 0, 0, self.color.huecurrent, self.gui.focus)
  dxDrawRectangle((x+336)*valx, (y+32)*valy, 64*valx, 64*valy, self.color.current, self.gui.focus)
  dxDrawText(self.color.hex, (x+336)*valx, (y+32)*valy, (x+400)*valx, (y+96)*valy, self.color.v < 0.5 and self.color.white or self.color.black, 1, "default", "center", "center", true, true, self.gui.focus)
end

function Colorpicker:mouseDown()
  if source == self.gui.svmap or source == self.gui.hbar then
    self.gui.track = source
    local cx, cy = getCursorPosition()
    self:mouseMove(sw*cx, sh*cy)
  end  
end

function Colorpicker:mouseUp(button, state)
  if not state or state ~= "down" then
    if self.gui.track then 
      triggerEvent("onColorpickerChange", root, self.id, self.color.hex, self.color.r, self.color.g, self.color.b) 
    end
    self.gui.track = false 
  end  
end

function Colorpicker:mouseMove(x,y)
  if self.gui.track and source == self.gui.track then
    local gx,gy = guiGetPosition(self.gui.window, false)
    if source == self.gui.svmap then
      local offsetx, offsety = x - (gx + 16), y - (gy + 32)
      self.color.s = offsetx/255
      self.color.v = (255-offsety)/255
    elseif source == self.gui.hbar then
      local offset = y - (gy + 32)
      self.color.h = (255-offset)/255
    end 
    self:updateColor()
  end
end

function Colorpicker:mouseSnap()
  if self.gui.track and source == self.gui.track then
    if self.color.s < self.gui.snaptreshold or self.color.s > 1-self.gui.snaptreshold then self.color.s = math.round(self.color.s) end
    if self.color.v < self.gui.snaptreshold or self.color.v > 1-self.gui.snaptreshold then self.color.v = math.round(self.color.v) end
    self:updateColor()
  end
end

function Colorpicker:updateColor()
  self.color.r, self.color.g, self.color.b = hsv2rgb(self.color.h, self.color.s, self.color.v)
  self.color.current = tocolor(self.color.r, self.color.g, self.color.b,255)
  self.color.huecurrent = tocolor(hsv2rgb(self.color.h, 1, 1))
  self.color.hex = string.format("#%02X%02X%02X", self.color.r, self.color.g, self.color.b)
  guiSetText(self.gui.edith, "H: "..tostring(math.round(self.color.h*360)).."°")
  guiSetText(self.gui.edits, "S: "..tostring(math.round(self.color.s*100)).."%")
  guiSetText(self.gui.editv, "V: "..tostring(math.round(self.color.v*100)).."%")
  guiSetText(self.gui.editr, "R: "..tostring(self.color.r))
  guiSetText(self.gui.editg, "G: "..tostring(self.color.g))
  guiSetText(self.gui.editb, "B: "..tostring(self.color.b))
end


function Colorpicker:guiFocus()
  self.gui.focus = true
  guiSetAlpha(self.gui.window, 1)
end

function Colorpicker:guiBlur()
  self.gui.focus = false
  guiSetAlpha(self.gui.window, 0.5)
end

function Colorpicker:pickColor()
  triggerEvent("onColorpickerOK", root, self.id, self.color.hex, self.color.r, self.color.g, self.color.b)
  self:destroy()
end

function Colorpicker:destroy()
  removeEventHandler("onClientGUIMouseDown", self.gui.svmap, self.handlers.mouseDown)
  removeEventHandler("onClientMouseLeave", self.gui.svmap, self.handlers.mouseSnap)
  removeEventHandler("onClientMouseMove", self.gui.svmap, self.handlers.mouseMove)
  removeEventHandler("onClientGUIMouseDown", self.gui.hbar, self.handlers.mouseDown)
  removeEventHandler("onClientMouseMove", self.gui.hbar, self.handlers.mouseMove)
  removeEventHandler("onClientClick", root, self.handlers.mouseUp)
  removeEventHandler("onClientGUIMouseUp", root, self.handlers.mouseUp)
  removeEventHandler("onClientRender", root, self.handlers.render)
  removeEventHandler("onClientGUIClick", self.gui.okb, self.handlers.pickColor)
  removeEventHandler("onClientGUIClick", self.gui.closeb, self.handlers.destroy)  
  destroyElement(self.gui.window)
  pickerTable[self.id] = nil
  setmetatable(self, nil)
end

function areThereAnyPickers()
  for _ in pairs(pickerTable) do
    return true
  end
  return false
end

function hsv2rgb(h, s, v)
  local r, g, b
  local i = math.floor(h * 6)
  local f = h * 6 - i
  local p = v * (1 - s)
  local q = v * (1 - f * s)
  local t = v * (1 - (1 - f) * s)
  local switch = i % 6
  if switch == 0 then
    r = v g = t b = p
  elseif switch == 1 then
    r = q g = v b = p
  elseif switch == 2 then
    r = p g = v b = t
  elseif switch == 3 then
    r = p g = q b = v
  elseif switch == 4 then
    r = t g = p b = v
  elseif switch == 5 then
    r = v g = p b = q
  end
  return math.floor(r*255), math.floor(g*255), math.floor(b*255)
end

function rgb2hsv(r, g, b)
  r, g, b = r/255, g/255, b/255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s 
  local v = max
  local d = max - min
  s = max == 0 and 0 or d/max
  if max == min then 
    h = 0
  elseif max == r then 
    h = (g - b) / d + (g < b and 6 or 0)
  elseif max == g then 
    h = (b - r) / d + 2
  elseif max == b then 
    h = (r - g) / d + 4
  end
  h = h/6
  return h, s, v
end

function math.round(v)
  return math.floor(v+0.5)
end
addEvent("onColorpickerOK", true)
addEvent("onColorpickerChange", true)