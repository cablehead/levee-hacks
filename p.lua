local levee = require("levee")
local _ = levee._


local function child()
	local h = levee.Hub()
	local s = h.io:stdin():reads()
	local out = h.io:stdout()
	out:write(s)
	out:write(s)
end


local function parent()
	local h = levee.Hub()
	local child = h.process:respawn({argv={"..child"}})
	child.stdin:write("hi")
	local echo = child.stdout:reads()
	child.done:recv()
	print(echo)
end


local function main()
	if arg[1] == "..child" then
		child()
	else
		parent()
	end
end


main()
