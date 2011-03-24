LINE_HEIGHT = 14
TOP_MARGIN = 10
LEFT_MARGIN = 20
HELP_MARGIN = -200
BOTTOM_MARGIN = -24
DEFAULT_TEXT_COLOR = {255, 255, 255}

-- Prints a line of text and persists the x and y positions, automatically
-- incrementing y for each new line.   This allows you to only specify x
-- and y once for a sequence of lines
--
-- pass a table of args:
--   args.str = either a string (to print directly), or a table to be unpacked
--              and passed to string.format
--   args.x   = x position.  Defaults to last x position.
--              Negative values interpreted as left from the right edge of the screen.
--   args.y   = y position.  Defaults to last y position + LINE_HEIGHT.
--              Negative values interpreted as up from the bottom edge of the screen.
--   args.color = R,G,B table.   Defaults to DEFAULT_TEXT_COLOR
function textLine(args)
  if      type(args.str) == 'table'  then to_print = string.format(unpack(args.str))
  elseif  type(args.str) == 'string' then to_print = args.str
  else error('must specify string to print as either string or table')
  end

  if args.x then line_x = args.x end
  if args.y then line_y = args.y end
  if line_x < 0 then line_x = love.graphics.getWidth() + line_x end
  if line_y < 0 then line_y = love.graphics.getHeight() + line_y end

  love.graphics.setColor(unpack(args.color or DEFAULT_TEXT_COLOR))
  love.graphics.print(to_print, line_x, line_y)
  -- auto-increment line position
  line_y = line_y + LINE_HEIGHT
end

