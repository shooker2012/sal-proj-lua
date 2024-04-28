local custom_macro_dir = vim.fn.stdpath("data").."/sal_proj_data"

local uv = vim.loop

-- Check root.
if not uv.fs_stat(custom_macro_dir) then
	uv.fs_mkdir(custom_macro_dir, 777)
end

function LoadMacroTable(p_file_path)
	local status, ret = pcall(dofile, p_file_path)
	return status and ret or {}
end

function SaveMacroTable(p_file_path, p_macro_table)
	if type(p_macro_table) ~= "table" then return false end
	local file = io.open(p_file_path, "w")
	if not file then return false end

	local lines = {}
	table.insert(lines, "return {")

	for k, v in pairs(p_macro_table) do
		if type(k) == "string" and type(v) == "string" then
			local line = string.format('["%s"] = "%s"', k, v)
			table.insert(lines, line)
		end
	end
	table.insert(lines, "}")

	-- Write to file.
	for i, lines in ipairs(lines) do
		file:write(lines, "\n")
	end

	file:close()
	return true
end

function ExecuteMacro(p_macro_table, p_macro_name)
	local macro = p_macro_table[p_macro_name]
	if not macro then return end

	local cmd = string.format('exec "norm %s"', macro)
	vim.cmd(cmd)
end

function SetMacro(p_macro_table, key, register)
	if type(key) ~= "string" or type(register) ~= "string" then return end
	if register[1] == "@" then register = string.sub(register, 2) end

	local v = vim.fn.getreg(register)
	if v == "" then return end

	p_macro_table[key] = v
end


-- Read file
local file_path  = custom_macro_dir.."/custom_macro.dat"
local macro_table = LoadMacroTable(file_path)

-- commands
vim.api.nvim_create_user_command("SalSaveMacroTable", function() SaveMacroTable(file_path, macro_table) end, {})
vim.api.nvim_create_user_command("SalExecuteMacro", function(arg_table) ExecuteMacro(macro_table, arg_table.args) end, {nargs=1})
vim.api.nvim_create_user_command("SalSetMacro", function(arg_table) SetMacro(macro_table, arg_table.fargs[1], arg_table.fargs[2]) end, {nargs="*"})
vim.api.nvim_create_user_command("SalClearMacroTable", function(arg_table) macro_table = {} end, {nargs=0})

-- command alias
vim.cmd([[ cnoreabbrev SE SalExecuteMacro ]])

-- -- auto commands.
-- vim.api.nvim_create_autocmd("VimLeavePre", {callback =  function() SaveMacroTable(file_path, macro_table) end})
