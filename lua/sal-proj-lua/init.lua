 -- Copyright (c) 2024
-- shooker2012 <lovelywzz@gmail.com>
--
-- When open *.vimproj or _vimproj, use some custom settings.
--
-- For Add net type project:
-- 1. Create a new type config file in "config" folder which is with name [new type].lua
-- 2. Add new type name to custom_project_type.

local custom_project_type = {"lua"}

local project_pattern_table = { "*.vimproj", "_vimproj" }

function InitSalProj()
	local file_type = nil
	local file_name = vim.fn.expand("%")
	local s = file_name:find("%.")
	if s then
		file_type = file_name:sub(1, s-1):lower()
	end

	-- Base config.
	vim.opt.autochdir = false

	local current_win = vim.api.nvim_get_current_win()

	vim.cmd("Neotree action=show reveal_force_cwd=true")
	vim.cmd("Copen")

	vim.api.nvim_set_current_win(current_win)

	for i, v in ipairs(custom_project_type) do
		if file_type == v:lower() then
			require("sal-proj-lua/configs/"..v)
		end
	end

	-- custom config in vimproj file
	vim.cmd("so %")
end

function SetupAutoCommand()
	vim.api.nvim_create_autocmd("BufReadPost", {pattern = project_pattern_table, callback = InitSalProj})
end

SetupAutoCommand()
