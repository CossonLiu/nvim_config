local quick_motion_ns = vim.api.nvim_create_namespace("quick_motion_ns")

local quick_row = -1
local quick_col = -1

local function clear_hl()
	if quick_row == -1 then return end
	vim.api.nvim_buf_clear_namespace(0, quick_motion_ns, quick_row, quick_row + 1)
	quick_row = -1
	quick_col = -1
end

local function get_next_chars_index()
	local lines = vim.api.nvim_buf_get_lines(0, quick_row, quick_row + 1, false)
	if #lines == 0 then return end
	local line = lines[1]
	local col = quick_col + 1
	if col >= #line then return end
	local checked = {}
	local nexts = {}
	for i = col + 1, #line do
		local char = line:sub(i, i)
		if not checked[char] then 
			table.insert(nexts, i - 1)
			checked[char] = true
		end
	end

	return nexts
end

local function get_next_chars_index_rev()
	local lines = vim.api.nvim_buf_get_lines(0, quick_row, quick_row + 1, false)
	if #lines == 0 then return end
	local line = lines[1]
	local col = quick_col
	if col == 0 then return end
	local checked = {}
	local nexts = {}
	for i = col, 1, -1 do
		local char = line:sub(i, i)
		if not checked[char] then 
			table.insert(nexts, 1, i - 1)
			checked[char] = true
		end
	end

	return nexts
end

local function add_highlight_to_nexts(nexts)
	local col_start, col_end = -1, -1
	local add_hl = function(i)
		if col_start == -1 then
			col_start = i
			col_end = i
			return
		end

		if i - col_end == 1 then
			col_end = i
			return
		end

		vim.api.nvim_buf_add_highlight(
			0,
			quick_motion_ns,
			"Cursor",
			quick_row,
			col_start,
			col_end + 1
		)

		col_start = i
		col_end = i
	end

	for _, i in ipairs(nexts) do
		add_hl(i)
	end

	if col_start ~= -1 then
		vim.api.nvim_buf_add_highlight(
			0,
			quick_motion_ns,
			"Cursor",
			quick_row,
			col_start,
			col_end + 1
		)
	end
end

local function exe_motion(motion, input)
	if input == 27 then
		 -- <esc>
		return
	end

	vim.cmd("unmap " .. motion)
	vim.api.nvim_feedkeys(motion .. vim.fn.nr2char(input), 'n', true)

	local cmd = string.format(
		":lua require'quick_motion.quick_scope'.quick_scope('%s')<cr>",
		motion
	)
	vim.api.nvim_set_keymap(
		"n",
		motion,
		cmd,
		{silent = true}
	)
end

local function quick_scope(motion)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	quick_row = row -1
	quick_col = col
	local nexts = nil
	if motion == 'f' or motion == 't' then
		nexts = get_next_chars_index()
	else
		nexts = get_next_chars_index_rev()
	end

	if not nexts then
		quick_row = -1
		quick_col = -1
		return
	end

	add_highlight_to_nexts(nexts)
	vim.schedule(function()
		local input = vim.fn.getchar()
		exe_motion(motion, input)
		clear_hl()
	end)
end

return {
	quick_scope = quick_scope
}
