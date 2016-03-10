let logo = [
      \ '',
      \ '  __ _   ____   __    _  _   __   _  _ ',
      \ ' (  ( \ (  __) /  \  / )( \ (  ) ( \/ )',
      \ ' /    /  ) _) (  O ) \ \/ /  )(  /    \',
      \ ' \_)__) (____) \__/   \__/  (__) \_)(_/',
      \ '',
      \ '',
      \ ]

let mapleader = ","

" Plugins & their settings (vim-plug must be in autoload) ---- {{{
let g:plug_window = "tabnew"
call plug#begin()

" Restore sanity first
Plug 'tpope/vim-sensible'

" Languages & Highlighting {
Plug 'sheerun/vim-polyglot'
Plug 'Raimondi/delimitMate'
Plug 'valloric/MatchTagAlways'
Plug 'vim-utils/vim-man'
Plug 'lervag/vimtex'
Plug 'dag/vim-fish'
" }

" Features & Utilities {
Plug 'Chiel92/vim-autoformat'
map <Leader>f :Autoformat<CR>

Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1

Plug 'critiqjo/lldb.nvim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim' | Plug 'junegunn/limelight.vim'
let g:limelight_priority = -1
let g:limelight_conceal_ctermfg = 'Grey'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
map <Leader>g :Goyo<CR>
map <Leader><Leader>g :Goyo!<CR>


Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree")
      \ && b:NERDTree.isTabTree()) | q | endif
map <Leader>e :NERDTreeToggle<CR>

Plug 'mhinz/vim-startify'
let g:startify_enable_special = 0
let g:startify_custom_header = logo

Plug 'tpope/vim-surround'

Plug 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = ' -std=c++1z'
map <Leader>s :SyntasticCheck<CR>
map <Leader><Leader>s :SyntasticReset<CR>
" }

" Themes & Colors ---- {
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

Plug 'gorodinskiy/vim-coloresque'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

Plug 'Yggdroot/indentLine'
let g:indentLine_char = '┊'
let g:indentLine_color_term = 37
" }

call plug#end()
" }}} ---- end of vim-plug plugins

"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

set background=light
colorscheme solarized

set ignorecase                                  " Searching ignores case ...
set smartcase                                   " ... unless we use a Capital

set noshowmode                                  " let airline control show mode
set showcmd                                     " show in-progress commands
set splitright splitbelow

set nowrap
set list listchars=tab:›\ ,trail:•,extends:»
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

set wildignorecase
set wildignore+=.git,.hg,.svn
set wildignore+=.bak,.swp,.tmp
set wildmode=list:longest,full

set undofile
set undolevels=1024
set undoreload=8192

" Line & Numbers {
set cursorline colorcolumn=81

highlight clear CursorLine
highlight CursorLineNr ctermbg=DarkGreen ctermfg=White

autocmd VimEnter * set concealcursor="nc"

autocmd VimEnter * set number relativenumber
autocmd InsertLeave * set relativenumber
autocmd InsertEnter * set relativenumber!

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
  \   execute("normal `\"") |
  \ endif

" }

" Key Bindings {

" Who needs ex?
nnoremap Q <nop>

" Recording macros is beyond me
map q <nop>

" Too lazy to press Shift
nnoremap ; :

vmap < <gv
vmap > >gv

map <esc> :noh<cr>

" Strip white space
map <Leader>sw :%s/\s\+$//e<CR>
" }
