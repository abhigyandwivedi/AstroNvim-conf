local M = {}


local function clamp(int)
  return math.max(math.min(int, 255), 0)
end

local function remap(int, min, max)
  return math.max(math.min(int, max), min)
end

function M.rawToHex(raw)
  return "#" .. string.format("%06x", raw)
end

function M.rawToRgb(raw)
  raw = string.format("%06x", raw)
  raw = string.lower(raw)
  return {
    r = tonumber(raw:sub(1, 2), 16),
    g = tonumber(raw:sub(3, 4), 16),
    b = tonumber(raw:sub(5, 6), 16),
  }
end

function M.toHex(rgb)
  return table.concat({
    "#",
    string.format("%02x", rgb.r),
    string.format("%02x", rgb.g),
    string.format("%02x", rgb.b),
  })
end

function M.toRgb(hex)
  hex = hex:gsub("#", "")
  hex = string.lower(hex)
  return {
    r = tonumber(hex:sub(1, 2), 16),
    g = tonumber(hex:sub(3, 4), 16),
    b = tonumber(hex:sub(5, 6), 16),
  }
end

function M.mix(rgb1, rgb2)
  local function average(c1, c2)
    c1           = c1 * c1
    c2           = c2 * c2
    local add    = c1 + c2
    local devide = add / 2
    local sum    = math.sqrt(devide)
    return math.floor(sum)
  end

  return {
    r = average(rgb1.r, rgb2.r),
    g = average(rgb1.g, rgb2.g),
    b = average(rgb1.b, rgb2.b),
  }
end

function M.darkenPercent(rgb, percent)
  local float = percent * 0.01
  return {
    r = clamp((rgb.r * (-float)) + rgb.r),
    g = clamp((rgb.g * (-float)) + rgb.g),
    b = clamp((rgb.b * (-float)) + rgb.b),
  }
end

function M.darken(rgb, int)
  return {
    r = clamp(rgb.r - int),
    g = clamp(rgb.g - int),
    b = clamp(rgb.b - int),
  }
end

function M.hue(rgb, percent)
  local float = 1 + (percent * 0.01)
  return {
    r = clamp(rgb.r * float),
    g = clamp(rgb.g * float),
    b = clamp(rgb.b * float),
  }
end

function M.lighten(rgb, int)
  return {
    r = clamp(rgb.r + int),
    g = clamp(rgb.g + int),
    b = clamp(rgb.b + int),
  }
end
function M.invert(rgb)
  return {
    r = clamp(255 - rgb.r),
    g = clamp(255 - rgb.g),
    b = clamp(255 - rgb.b),
  }
end
return M