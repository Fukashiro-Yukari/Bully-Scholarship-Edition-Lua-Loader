qtglib = qtglib or {}
table = table or {}
string = string or {}

function isnum(a)
    return type(a) == 'number'
end

function isstr(a)
    return type(a) == 'string'
end

function istable(a)
	local f,e = pcall(pairs,a)
	return f
end

function isfunction(a)
	return type(a) == 'function'
end

function str(a)
	return tostring(a)
end

function num(a)
	return tonumber(a)
end

function bool(a)
	if a then
		return true
	end

	return false
end

function len(a)
	if istable(a) then
		return table.count(a)
	elseif isstr(a) then
		return string.len(a)
	elseif str(a) then
		return len(str(a))
	end
end

function pass(a)
    if not isnum(a) then return end

    local pass = ''

    for i = 0,a do
        pass = pass..' '
    end

    return pass
end

function switch(a,b,c)
	b = b or {}
	c = c or function() end
	setmetatable(b,{__index = function(t,k) return c end})
	b[a]()
end

function printerror(a)
    if str(a) then
        print('Error: '..str(a))
    end
end

function table.count(t)
	local i = 0
	for k in pairs(t) do
		i = i+1
	end

	return i
end

function table.random(t)
	local rk = math.random(1,table.getn(t))
	local i = 1
	for k,v in pairs(t) do
		if i == rk then return v, k end
		i = i+1
	end
end

function table.empty(t)
	for k,v in pairs(t) do
		t[k] = nil
	end
end

function table.isempty(t)
	return next(t) == nil
end

function table.getkeys(a)
	local key = {}

	for k,v in pairs(a) do
		key[table.getn(key)] = k
	end

	return key
end

function table.getmax(a)
    local max = 0
    
	for k,v in pairs(a) do
		if v > max then
			max = v
		end
	end
	
	return max
end

function table.getmin(a)
	local min = math.huge
	for k,v in pairs(a) do
		if v < min then
			min = v
		end
	end

	return min
end

function table.copy(t)
	local tbl = {}
	for k,v in pairs(t) do
		tbl[k] = v
	end
	
	return tbl
end

function table.hasvalue(t,val)
	for k,v in pairs(t) do
		if v == val then return true end
	end

	return false
end

function range(a,b)
	local e = 'arg not number!'

	a = num(a)
	b = num(b)
	
	if not b then
		b = a
		a = 0
	end

	assert(isnum(a),e)
	assert(isnum(b),e)

	if a < b then
		a = a-1

		return function()
			if a < b then
				a = a+1
	
				return a,a
			end
		end
	else
		a = a+1

		return function()
			if a > b then
				a = a-1

				return a,a
			end
		end
	end
end

function string.split(input,delimiter)
    input = tostring(input)
	delimiter = tostring(delimiter)
	
	if delimiter == '' then return false end
	
	local pos,arr = 0,{}
	
    for st,sp in function() return string.find(input,delimiter,pos,true) end do
        table.insert(arr,string.sub(input,pos,st-1))
        pos = sp + 1
	end
	
    table.insert(arr, string.sub(input,pos))
    return arr
end

return qtglib