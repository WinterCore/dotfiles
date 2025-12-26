-- plugins.lua
-- Returns plugin specifications for lazy.nvim

return {
    -- LSP Configuration (replaces coc.nvim)
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
    },

    -- Autocompletion (replaces coc.nvim completion)
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
        },
    },

    -- Snippets (replaces coc-snippets)
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
    },

    -- Telescope (replaces coc-fzf for LSP features)
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },

    -- Catppuccin colorscheme
    {
        'catppuccin/nvim',
        name = 'catppuccin',
    },

    -- FZF
    {
        'junegunn/fzf.vim',
        dependencies = {
            { 'junegunn/fzf', build = ':call fzf#install()' },
        },
    },

    -- Vim Airline
    'vim-airline/vim-airline',

    -- Git integration
    'tpope/vim-fugitive',

    -- VimWiki
    'vimwiki/vimwiki',

    -- EasyAlign
    'junegunn/vim-easy-align',

    -- Ack.vim
    'mileszs/ack.vim',

    -- GLSL syntax
    'tikhomirov/vim-glsl',

    -- Oil.nvim file explorer
    'stevearc/oil.nvim',

    -- TypeScript syntax
    'leafgarland/typescript-vim',
    'peitalin/vim-jsx-typescript',

    -- EditorConfig
    'editorconfig/editorconfig-vim',

    -- GitHub Copilot
    'github/copilot.vim',

    -- Claude Code integration
    'greggh/claude-code.nvim',

    -- LSP signature help (shows argument types as you type)
    {
        'ray-x/lsp_signature.nvim',
        event = 'VeryLazy',
        opts = {},
    },

    -- Treesitter for better syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        version = 'v0.9.*',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'markdown', 'markdown_inline',
                    'typescript', 'tsx', 'javascript',
                    'lua', 'rust', 'python', 'go', 'c', 'cpp',
                    'html', 'css', 'json', 'yaml',
                },
                highlight = { enable = true },
                indent = { enable = true },
                auto_install = true,
            })
        end,
    },
}
