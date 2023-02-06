-- Extended Lua Standard String Library : version 1.0
-- By tinytop


function string.gfind(s, p, m)
	local min, max = 0, 1
	local f = 0
	local u = (table.unpack or unpack or _G.unpack)
	
	return function()
		local x = {s:sub(max):find(p)}
		if x[1] == nil then return nil end
		if m and m > 0 then f = f + 1; if f > m then return nil end end
		
		max = max + x[2]
		min = max - (x[2] - x[1]) - 1
		
		return min, max, u(x, 3)
	end
end
function string.gsplit(s, d, m)
	local c = {}
	local l, p = 0, 1
	d = d:gsub("([%^%$%*%[%]%+%-%.%%])", function(x) return ("%" .. x) end)
	
	if not m or m <= 0 then
		s:gsub(("([^" .. d .. "]+)"), function(x) l = l + 1; c[l] = x end)
	else
		for r in s:gmatch(("([^" .. d .. "]+)")) do
			l = l + 1
			if l > m then break end
			c[l] = r
		end
	end
	
	return function()
		local r = c[p]
		if not r then return nil end
		
		p = p + 1
		return r
	end
end

function string.starts(s, sw)
	return not not s:match('^' .. sw:gsub("([%^%$%*%[%]%+%-%.%%])", function(x) return ("%" .. x) end), nil)
end
function string.ends(s, sw)
	return not not s:reverse():match('^' .. sw:reverse():gsub("([%^%$%*%[%]%+%-%.%%])",function(x) return ("%" .. x) end), nil)
end
function string.contains(s, sw)
	return not not s:match(sw:gsub("([%^%$%*%[%]%+%-%.%%])", function(x) return ("%" .. x) end), nil)
end
function string.split(s, d, m)
    local c = {}
	local l, p = 0, 1
	d = d:gsub("([%^%$%*%[%]%+%-%.%%])", function(x) return ("%" .. x) end)
	
	if not m or m <= 0 then
		s:gsub(("([^" .. d .. "]+)"), function(x) l = l + 1; c[l] = x end)
	else
		for r in s:gmatch(("([^" .. d .. "]+)")) do
			l = l + 1
			if l > m then break end
			c[l] = r
		end
	end

    return c
end
function string.switchn(sA, sB, rS)
    if sA ~= sB then
        if type(rS) == "function" then
            return rS()
        end
        return (rS or false)
    end

    return sA
end
function string.switch(sA, sB, rS)
    if sA == sB then
        if type(rS) == "function" then
            return rS()
        end
        return (rS or false)
    end

    return sA
end
function string.eval(c, rS, nS)
	if c then
		if type(rS) == "function" then
			return rS()
		end

		return rS
	end 

	return nS
end
function string.spaces(s, sm, m)
    sm = sm or ''
    local p = sm:match("^*(.)")

    if p == 's' then
        if sm == '*s' then
            return s:gsub("\32+", '', m)
        elseif sm == '*se' then
            return s:gsub("\32+", "\32", m)
        end
    elseif p == 't' then
        if sm == '*t' then
            return s:gsub("\t+", '', m)
        elseif sm == '*te' then
            return s:gsub("\t+", "\t", m)
        end
    elseif p == 'n' then
        if sm == '*n' then
            return s:gsub("\n+", '', m)
        elseif sm == '*ne' then
            return s:gsub("\n+", "\n", m)
        end
    elseif p == nil or p == 'e' then
        if sm == '*' then
            return s:gsub("%s+", '', m)
        elseif sm == '*e' then
            return s:gsub("(%s+)", function(x)
                local _, a = x:gsub('\n','', m)
                local _, b = x:gsub('\t', '', m)
                local _, c = x:gsub('\32', '', m)

                return x:gsub('\n', '', a - 1):gsub('\t', '', b - 1):gsub('\32', '', c - 1)
            end)
        end
    end
    error("no valid mode for function \"string.spaces\"")
end
function string.tableize(s)
	local x = {}
	local l = 0
	for g in s:gmatch("(.)") do l=l+1; x[l] = g; end
	return x
end
function string.count(s, p)
	local _, x = s:gsub(p,'')

	return x
end
function string.blank(s)
	return (s:match("^(%s+)") == s or s == '')
end
function string.null(s)
	return (s == '')
end

return string
