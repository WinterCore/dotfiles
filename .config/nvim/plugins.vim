call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-vinegar'
Plug 'mileszs/ack.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'vifm/vifm.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()
