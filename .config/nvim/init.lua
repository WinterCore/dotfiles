require("config.lazy")


-- Leader key
vim.g.mapleader = " "

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

-- Make capital Y behave like capital D
vim.keymap.set('n', 'Y', 'y$')

require("oil").setup({
    view_options = {
        show_hidden = false,
    },
    keymaps = {
        ["g."] = "actions.toggle_hidden",
        ["<CR>"] = "actions.select",
    },
    use_default_keymaps = false,
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require("claude-code").setup({
    window = {
        split_ratio = 0.4,
        position = "vertical",
        enter_insert = true,
        hide_numbers = true,
        hide_signcolumn = true,
        float = {
            width = "80%",
            height = "80%",
            row = "center",
            col = "center",
            relative = "editor",
            border = "rounded",
        },
    },
    refresh = {
        enable = true,
        updatetime = 100,
        timer_interval = 1000,
        show_notifications = true,
    },
    git = {
        use_git_root = true,
    },
    shell = {
        separator = '&&',
        pushd_cmd = 'pushd',
        popd_cmd = 'popd',
    },
    command = "claude",
    command_variants = {
        continue = "--continue",
        resume = "--resume",
        verbose = "--verbose",
    },
    keymaps = {
        toggle = {
            normal = "<C-,>",
            terminal = "<C-,>",
            variants = {
                continue = "<leader>cC",
                verbose = "<leader>cV",
            },
        },
        window_navigation = true,
        scrolling = true,
    }
})

-- Claude Code popup toggle
local claude_popup = {
    buf = nil,
    win = nil,
}

local function open_claude_popup()
    if claude_popup.win and vim.api.nvim_win_is_valid(claude_popup.win) then
        vim.api.nvim_set_current_win(claude_popup.win)
        return
    end

    if not claude_popup.buf or not vim.api.nvim_buf_is_valid(claude_popup.buf) then
        claude_popup.buf = vim.api.nvim_create_buf(false, true)
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    claude_popup.win = vim.api.nvim_open_win(claude_popup.buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    if vim.api.nvim_buf_line_count(claude_popup.buf) == 1
       and vim.api.nvim_buf_get_lines(claude_popup.buf, 0, 1, false)[1] == '' then
        vim.fn.termopen('claude')
    end

    vim.cmd('startinsert')
end

local function hide_claude_popup()
    if claude_popup.win and vim.api.nvim_win_is_valid(claude_popup.win) then
        vim.api.nvim_win_hide(claude_popup.win)
    end
end

local function toggle_claude_popup()
    if claude_popup.win and vim.api.nvim_win_is_valid(claude_popup.win) then
        hide_claude_popup()
    else
        open_claude_popup()
    end
end

vim.keymap.set('n', '<leader>d', toggle_claude_popup, { desc = 'Toggle Claude Code popup' })

vim.keymap.set('n', '<leader>,l', ':ClaudeCode<CR>')

-- Copilot keymaps
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<M-a>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true, replace_keycodes = false })
vim.keymap.set('i', '<M-s>', '<Plug>(copilot-accept-line)', { silent = true })

vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}

-- Astro settings
vim.g.astro_typescript = 'enable'
vim.g.astro_stylus = 'enable'

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmode = {'longest', 'list', 'full'}
vim.opt.encoding = 'utf-8'
vim.opt.compatible = false
vim.cmd('filetype plugin on')
vim.cmd('syntax on')
vim.cmd('colorscheme catppuccin')

-- Transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'NonText', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE', ctermbg = 'NONE' })

-- Buffers
vim.keymap.set('n', '<leader>b', ':Buffers<CR>')

-- Run shortcuts
vim.keymap.set('n', '<space>rd', ':!deno run -A %<CR>')
vim.keymap.set('n', '<space>rr', ':!cargo run<CR>')

-- Netrw
vim.g.netrw_fastbrowse = 0

vim.opt.wildmenu = true

-- Custom command for shell execution
vim.api.nvim_create_user_command('R', function(opts)
    vim.cmd('new')
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.bufhidden = 'hide'
    vim.opt_local.swapfile = false
    vim.cmd('r !' .. opts.args)
end, { nargs = '*', complete = 'shellcmd' })

vim.keymap.set('n', '<leader>ss', 'Bs')

-- Clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')

-- Make
vim.keymap.set('n', '<leader>md', ':make debug<CR>')
vim.keymap.set('n', '<leader>me', ':make exec<CR>')

-- Terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*',
    callback = function()
        vim.opt_local.modifiable = true
    end
})

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Split shortcuts
vim.keymap.set('n', '<leader>G', ':sp<CR>')
vim.keymap.set('n', '<leader>g', ':vsp<CR>')

-- Ack/Grep
vim.opt.grepprg = 'ack'
vim.g.grep_cmd_opts = '--noheading'

-- Search options
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.keymap.set('n', '<leader><space>', ':noh<CR>')

-- Fuzzy Finder (CtrlP)
vim.g.ctrlp_custom_ignore = '*/node_modules/*|git'
vim.g.ctrlp_lazy_update = 1
vim.g.ctrlp_map = '<F10>'

-- Vim Airline
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g.airline_powerline_fonts = 1

-- EasyAlign
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', '<leader>aa=', 'vip<Plug>(EasyAlign)*=<CR>')

-- HaskellVim
vim.g.haskell_enable_quantification = 1
vim.g.haskell_enable_recursivedo = 1
vim.g.haskell_enable_arrowsyntax = 1
vim.g.haskell_enable_pattern_synonyms = 1
vim.g.haskell_enable_typeroles = 1
vim.g.haskell_enable_static_pointers = 1
vim.g.haskell_backpack = 1

vim.opt.backspace = {'indent', 'eol', 'start'}

-- coc.nvim settings
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'

-- coc.nvim keymaps
local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

-- Use Tab for trigger completion with characters ahead and navigate
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Highlight the symbol and its references on cursor hold
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
})

-- Code actions
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", {silent = true, nowait = true})
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", {silent = true, nowait = true})
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", {silent = true, nowait = true})
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", {silent = true, nowait = true})
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", {silent = true, nowait = true})

-- Remap keys for apply refactor code actions
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", {silent = true})
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", {silent = true})
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", {silent = true})

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", {silent = true, nowait = true})

-- Function and class text objects
keyset("x", "if", "<Plug>(coc-funcobj-i)", {silent = true, nowait = true})
keyset("o", "if", "<Plug>(coc-funcobj-i)", {silent = true, nowait = true})
keyset("x", "af", "<Plug>(coc-funcobj-a)", {silent = true, nowait = true})
keyset("o", "af", "<Plug>(coc-funcobj-a)", {silent = true, nowait = true})
keyset("x", "ic", "<Plug>(coc-classobj-i)", {silent = true, nowait = true})
keyset("o", "ic", "<Plug>(coc-classobj-i)", {silent = true, nowait = true})
keyset("x", "ac", "<Plug>(coc-classobj-a)", {silent = true, nowait = true})
keyset("o", "ac", "<Plug>(coc-classobj-a)", {silent = true, nowait = true})

-- Scroll float windows/popups
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', {silent = true, nowait = true, expr = true})
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', {silent = true, nowait = true, expr = true})
keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', {silent = true, nowait = true, expr = true})
keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', {silent = true, nowait = true, expr = true})
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', {silent = true, nowait = true, expr = true})
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', {silent = true, nowait = true, expr = true})

-- Use CTRL-S for selections ranges
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

-- Commands
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", {silent = true, nowait = true})
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", {silent = true, nowait = true})
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", {silent = true, nowait = true})
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", {silent = true, nowait = true})
keyset("n", "<space>sy", ":<C-u>CocList -I symbols<cr>", {silent = true, nowait = true})
keyset("n", "<space>j", ":<C-u>CocNext<CR>", {silent = true, nowait = true})
keyset("n", "<space>k", ":<C-u>CocPrev<CR>", {silent = true, nowait = true})
keyset("n", "<space>p", ":<C-u>CocListResume<CR>", {silent = true, nowait = true})

-- Show diagnostic float
keyset("n", "L", "<CMD>call CocActionAsync('diagnosticInfo')<CR>", {silent = true})

-- Binary files
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = {'*.bin', '*.dat', '*.raw'},
    callback = function()
        vim.opt_local.binary = true
        vim.opt_local.fixeol = false
    end
})

vim.keymap.set('n', '<leader>xh', ':%!xxd -g 1 -c 16<CR>')
vim.keymap.set('n', '<leader>xb', ':%!xxd -r -g 1 -c 16<CR>')

-- FZF
vim.keymap.set('n', '<C-p>', ':Files<CR>')

-- Vifm
vim.keymap.set('n', '<C-n>', ':Vifm<CR>')
vim.keymap.set('n', '<leader>-', ':Vifm<CR>')

-- FZF quickfix action
local function build_quickfix_list(lines)
    vim.fn.setqflist(vim.tbl_map(function(line)
        return { filename = line }
    end, lines))
    vim.cmd('copen')
    vim.cmd('cc')
end

vim.g.fzf_action = {
    ['ctrl-q'] = build_quickfix_list,
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit'
}

-- FZF layout
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

-- FZF colors
vim.g.fzf_colors = {
    fg = {'fg', 'Normal'},
    bg = {'bg', 'Normal'},
    hl = {'fg', 'Comment'},
    ['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
    ['bg+'] = {'bg', 'CursorLine', 'CursorColumn'},
    ['hl+'] = {'fg', 'Statement'},
    info = {'fg', 'PreProc'},
    border = {'fg', 'Ignore'},
    prompt = {'fg', 'Conditional'},
    pointer = {'fg', 'Exception'},
    marker = {'fg', 'Keyword'},
    spinner = {'fg', 'Label'},
    header = {'fg', 'Comment'}
}

-- FZF history
vim.g.fzf_history_dir = '~/.local/share/fzf-history'

-- Ag: run from git root so ag can find .gitignore
vim.cmd([[
  command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': '--delimiter : --nth 4..'}), <bang>0)
]])
