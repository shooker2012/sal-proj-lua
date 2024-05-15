local svn_cmd = "TortoiseProc.exe"

-- Log
vim.api.nvim_create_user_command('SVNLog', function(arg_table)
	local path = arg_table.fargs[1] and vim.fn.expand(arg_table.fargs[1]) or vim.fn.expand("%")

	local command_line = string.format('start %s  /command:log /path:"%s"', svn_cmd, path)
	io.popen(command_line)
end, {nargs='*', complete="file"})

-- Update
vim.api.nvim_create_user_command('SVNUpdate', function(arg_table)
	local path = arg_table.fargs[1] and vim.fn.expand(arg_table.fargs[1]) or vim.fn.expand("%")

	local command_line = string.format('start %s  /command:update /path:"%s"', svn_cmd, path)
	io.popen(command_line)
end, {nargs='*', complete="file"})

-- Commit
vim.api.nvim_create_user_command('SVNCommit', function(arg_table)
	local path = arg_table.fargs[1] and vim.fn.expand(arg_table.fargs[1]) or vim.fn.expand(".")

	local command_line = string.format('start %s  /command:commit /path:"%s"', svn_cmd, path)
	io.popen(command_line)
end, {nargs='*', complete="file"})

-- Revert
vim.api.nvim_create_user_command('SVNRevert', function(arg_table)
	local path = arg_table.fargs[1] and vim.fn.expand(arg_table.fargs[1]) or vim.fn.expand(".")

	local command_line = string.format('start %s  /command:revert /path:"%s"', svn_cmd, path)
	io.popen(command_line)
end, {nargs='*', complete="file"})

-- Cleanup
vim.api.nvim_create_user_command('SVNCleanup', function(arg_table)
	local path = arg_table.fargs[1] and vim.fn.expand(arg_table.fargs[1]) or vim.fn.expand(".")

	local command_line = string.format('start %s  /command:cleanup /path:"%s"', svn_cmd, path)
	io.popen(command_line)
end, {nargs='*', complete="file"})

-- Diff
vim.api.nvim_create_user_command('SVNDiff', function(arg_table)
	local path = arg_table.fargs[1] and vim.fn.expand(arg_table.fargs[1]) or vim.fn.expand("%")

	local command_line = string.format('start %s  /command:diff /path:"%s"', svn_cmd, path)
	io.popen(command_line)
end, {nargs='*', complete="file"})

-- Blame
vim.api.nvim_create_user_command('SVNBlame', function(arg_table)
	local path = vim.fn.expand("%")
	local line = vim.fn.getcurpos()[2]

	local command_line
	command_line = string.format('start %s  /command:blame /path:"%s" /line:%d', svn_cmd, path, line)

	io.popen(command_line)
end, {nargs='*', complete="file"})
