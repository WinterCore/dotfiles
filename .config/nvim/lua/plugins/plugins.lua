-- plugins.lua
-- Returns plugin specifications for lazy.nvim

return {
    -- coc.nvim
    {
        'neoclide/coc.nvim',
        branch = 'release',
    },

    -- Telescope
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
}
