set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set background=dark
set clipboard^=unnamed,unnamedplus
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
set bs=2
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

if has('unix')
    set term=screen-256color
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
elseif has('win32')
    let g:ctrlp_cache_dir = $HOME . '\.cache\ctrlp'
end


filetype indent on
syntax enable

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

if !empty($CONEMUBUILD) && !has('gui_running')
    set term=pcansi
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set bs=indent,eol,start
endif

call pathogen#infect()
colorscheme gruvbox
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

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
            \ 'file': '\.so$\|\.dat$|\.DS_Store$'
            \ }

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup
    " --nocolor

    if has( 'unix' )
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    elseif has( 'win32' )
        let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
    endif

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 1
    nnoremap \ :Ag<SPACE>
    command! -nargs=+ -complete=file -bar Ag silent! grep! --ignore bin --ignore packages --ignore artifacts <args>|cwindow|redraw!
endif

""" SCRIPTS AND CUSTOM FUNCS


""" LINE NUMBER TOGGLE
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
