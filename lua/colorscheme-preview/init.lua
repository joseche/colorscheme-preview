local M = {}

local v = vim
local api = v.api
local buf, win
local current_index = 1

local defaults = { -- these are all the values you can set via setup
	keymap_opts = { noremap = true, silent = true, nowait = true },
	up_keys = { "<Up>", "k" },
	down_keys = { "<Down>", "j" },
	enter_keys = "<Enter>",
	close_keys = { "q", "<Esc>" },

	dialog_width = 20,
    dialog_height = 10,

    verbose = true,  -- if it echos the colorscheme that is set when it changes
}

local colorschemes = v.fn.getcompletion("", "color")  -- list of schemes, its refreshed when called

local function set_colorscheme(index)
	colorschemes = v.fn.getcompletion("", "color") -- always get a fresh list
	local scheme = colorschemes[index]
	if scheme then
		v.cmd("colorscheme " .. scheme)
        if M.opts.verbose then
		    api.nvim_echo({ { "colorscheme set to " .. scheme, "Normal" } }, false, {})
        end
	end
end

local function delete_keymap(list_to_delete)
	if type(list_to_delete) == "table" then
		for _, item in ipairs(list_to_delete) do
			v.keymap.del("n", item)
		end
	else
		v.keymap.del("n", list_to_delete)
	end
end

local function close()
	if win and api.nvim_win_is_valid(win) then
		api.nvim_win_close(win, true)
	end
	if buf and api.nvim_buf_is_valid(buf) then
		api.nvim_buf_delete(buf, { force = true })
	end

	-- Unmap keys to prevent errors
	delete_keymap(M.opts.up_keys)
	delete_keymap(M.opts.down_keys)
	delete_keymap(M.opts.enter_keys)
	delete_keymap(M.opts.close_keys)
	win, buf = nil, nil -- Reset variables
end

local function draw_window()
	colorschemes = v.fn.getcompletion("", "color") -- always get a fresh list
	local colorscheme = v.g.colors_name

	-- find the index of the current colorscheme
	for i, name in ipairs(colorschemes) do
		if name == colorscheme then
			current_index = i
			break
		end
	end

	buf = api.nvim_create_buf(false, true)
	api.nvim_buf_set_lines(buf, 0, -1, false, colorschemes)

	local width = M.opts.dialog_width
	local height = math.min(#colorschemes, M.opts.dialog_height)
	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = (v.o.lines - height) / 2,
		col = (v.o.columns - width) / 2,
		style = "minimal",
		border = "rounded",
	}
	win = api.nvim_open_win(buf, true, opts)
	api.nvim_win_set_cursor(win, { current_index, 0 })
end

local function move_cursor(direction)
	if direction == "up" and current_index > 1 then
		current_index = current_index - 1
	elseif direction == "down" and current_index < #colorschemes then
		current_index = current_index + 1
	end
	api.nvim_win_set_cursor(win, { current_index, 0 })
	set_colorscheme(current_index)
end

local function set_keymap(keys, fn)
	if type(keys) == "table" then
		for _, item in ipairs(keys) do
			v.keymap.set("n", item, fn, M.opts.keymap_opts)
		end
	else
		v.keymap.set("n", keys, fn, M.opts.keymap_opts)
	end
end

local function keymaps()
	-- previous and next schemas
	set_keymap(M.opts.up_keys, function()
		move_cursor("up")
	end)
	set_keymap(M.opts.down_keys, function()
		move_cursor("down")
	end)

	-- set and close, enter key
	set_keymap(M.opts.enter_keys, function()
		set_colorscheme(current_index)
		close()
	end)

	-- close
	set_keymap(M.opts.close_keys, close)
end

function M.setup(opts)
	M.opts = v.tbl_deep_extend("force", defaults, opts or {})
	v.api.nvim_create_user_command("ColorschemePreview", function()
		draw_window()
		keymaps()
	end, {})
end

return M
