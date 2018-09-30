set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set background=dark
set clipboard=unnamedplus
set mouse=a
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
set laststatus=2
set foldenable 
set visualbell
set number
set cursorline
set wildmenu
set lazyredraw 
set showmatch
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set splitright
set splitbelow

filetype indent on
syntax enable
colorscheme gruvbox

if &term =~ '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

execute pathogen#infect()
let mapleader=","
let g:gundo_prefer_python3 = 1
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_map_keys = 0
autocmd BufWritePost * GitGutter
map <leader>n :NERDTreeToggle<CR>
map <leader>p :CtrlP<CR>
map <leader>P :CtrlPMRU<CR>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader><space> :nohlsearch<CR>

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

""" SCRIPTS AND CUSTOM FUNCS

""" LINE NUMBER TOGGLE
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
