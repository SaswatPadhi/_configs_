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
"Plug 'MnO2/vim-ocaml-conceal'
Plug 'sheerun/vim-polyglot'
Plug 'raichoo/smt-vim'
Plug 'Raimondi/delimitMate'
Plug 'valloric/MatchTagAlways'
Plug 'lervag/vimtex'
autocmd FileType tex set conceallevel=2
Plug 'dag/vim-fish'
" }

" Features & Utilities {
Plug 'junegunn/vim-easy-align'
noremap <Leader>a :LiveEasyAlign<CR>

Plug 'Chiel92/vim-autoformat'
map <Leader>f :Autoformat<CR>

Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1

Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
let g:limelight_priority = -1
let g:limelight_conceal_ctermfg = 'Grey'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
noremap <Leader>g :Goyo<CR>

Plug 'henrik/vim-indexed-search'

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
noremap <Leader>e :NERDTreeToggle<CR>

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
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '❗'
noremap <Leader>s :SyntasticCheck<CR>
noremap <Leader><Leader>s :SyntasticReset<CR>
" }

" Themes & Colors ---- {
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

Plug 'gorodinskiy/vim-coloresque'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']
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
set spell
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
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \                    && &filetype != "gitcommit" |
      \   execute("normal `\"") |
      \ endif
" }

" Key Bindings {
" Who needs ex?
noremap Q <NOP>

" Recording macros is beyond me
noremap q <NOP>

" Too lazy to press Shift
nnoremap ; :

" Copy to clipboard
noremap  <leader>y  "+y
noremap  <leader>Y  "+yg_

" Paste from clipboard
noremap <leader>p "+p
noremap <leader>P "+P

inoremap <C-s> <C-o>:update<CR>
inoremap <C-y> <C-o><C-r>
inoremap <C-z> <C-o>u

noremap t :tabnew<SPACE>
noremap <Leader>t :tabnext<CR>
noremap <Leader><Leader>t :tabprevious<CR>

noremap <Leader>b :bnext<CR>
noremap <Leader><Leader>b :bprevious<CR>

noremap <Leader>hs :split<SPACE>
noremap <Leader>vs :vsplit<SPACE>

noremap <Leader>sh :split<CR>:terminal fish<CR>

vnoremap < <gv
vnoremap > >gv

noremap <ESC> :noh<CR>

" Strip white space
noremap <Leader>sw :%s/\s\+$//e<CR>
" }
