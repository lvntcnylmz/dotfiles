set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set exrc
set guicursor=
set nohlsearch
set termguicolors
set scrolloff=8
set signcolumn=yes
set hidden
set noswapfile
set nobackup
set clipboard+=unnamedplus

call plug#begin()
    Plug 'neovim/nvim-lspconfig'
    Plug 'gruvbox-community/gruvbox'
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

let mapleader = " "
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
