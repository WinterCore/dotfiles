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
        split_ratio = 0.3,
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

-- Native LSP completion (nvim-cmp)
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    })
})

-- Snippet keymaps
vim.keymap.set({'i', 's'}, '<C-;>', function()
    if luasnip.expandable() then
        luasnip.expand()
    end
end)

vim.keymap.set({'i', 's'}, '<C-j>', function()
    if luasnip.jumpable(1) then
        luasnip.jump(1)
    end
end)

vim.keymap.set({'i', 's'}, '<C-k>', function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end)

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

-- Native LSP settings
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'

-- LSP on_attach function
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    -- LSP signature help (shows argument types as you type)
    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
            border = "rounded"
        },
        hint_enable = false,
        floating_window = true,
        floating_window_above_cur_line = true,
    }, bufnr)

    -- Diagnostics navigation
    vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
    
    -- GoTo code navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    
    -- Show documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    
    -- Symbol renaming
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    
    -- Formatting
    vim.keymap.set({'n', 'x'}, '<leader>f', function()
        vim.lsp.buf.format({ async = true })
    end, opts)
    
    -- Code actions
    vim.keymap.set({'n', 'x'}, '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, opts)
    
    -- Highlight symbol on cursor hold
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references
        })
    end
end

-- LSP servers setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common language servers
local servers = {
    'ts_ls',        -- TypeScript/JavaScript
    'rust_analyzer', -- Rust
    'clangd',       -- C/C++
    'pyright',      -- Python
    'lua_ls',       -- Lua
    'gopls',        -- Go
    'jsonls',       -- JSON
    'html',         -- HTML
    'cssls',        -- CSS
    'eslint',       -- ESLint
}

-- Check if we have Neovim 0.11+ for new API
if vim.lsp.config then
    -- New API (Neovim 0.11+)
    for _, server_name in ipairs(servers) do
        vim.lsp.config[server_name] = {
            capabilities = capabilities,
            on_attach = on_attach,
        }
    end
    
    -- Lua language server specific config
    vim.lsp.config.lua_ls = vim.tbl_deep_extend('force', vim.lsp.config.lua_ls or {}, {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'}
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            }
        }
    })
    
    -- Enable LSP servers
    vim.lsp.enable(servers)
else
    -- Old API (Neovim < 0.11)
    local lspconfig = require('lspconfig')
    
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end

    -- Lua language server specific config
    lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'}
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            }
        }
    })
end

-- Disable inlay hints
vim.lsp.inlay_hint.enable(false)

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
            [vim.diagnostic.severity.INFO] = " ",
        }
    }
})

-- Better hover styling with border and syntax highlighting
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

-- Commands
vim.api.nvim_create_user_command('Format', function()
    vim.lsp.buf.format({ async = true })
end, {})

vim.api.nvim_create_user_command('OR', function()
    vim.lsp.buf.code_action({
        context = { only = { 'source.organizeImports' } },
        apply = true,
    })
end, {})

-- Show diagnostics in location list
vim.keymap.set('n', '<space>a', vim.diagnostic.setloclist, { silent = true, nowait = true })
vim.keymap.set('n', '<space>e', '<cmd>Telescope diagnostics<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>o', '<cmd>Telescope lsp_document_symbols<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>sy', '<cmd>Telescope lsp_workspace_symbols<CR>', { silent = true, nowait = true })

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
vim.env.FZF_DEFAULT_COMMAND = 'git ls-files --cached --others --exclude-standard'
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
