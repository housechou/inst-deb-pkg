" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Add or remove your Bundles here:

"Plug 'neoclide/coc.nvim', 'release'
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'flazz/vim-colorschemes'
Plug 'NLKNguyen/papercolor-theme'
"auto indent based on current file
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
" You can specify revision/branch/tag.
Plug 'Shougo/vimshell', { 'rev' : '3787e5' }
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'bogado/file-line'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'mhinz/vim-grepper'
Plug 'will133/vim-dirdiff'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/indentpython.vim'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'junegunn/vim-easy-align'

" Initialize plugin system
call plug#end()
call glaive#Install()

Glaive codefmt plugin[mappings]



set backspace=indent,eol,start
"Set leader to <Space>
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

"# Plugins setting
"## vim-codefmt
nnoremap <leader>fc :FormatCode<CR>
nnoremap <leader>fl :FormatLines<CR>
"# vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
nnoremap de d$
"## leaderf
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_ShowDevIcons = 0
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
" search word under cursor, the pattern is treated as regex, then use CTRL+T to open new tab
noremap <C-F> :<C-U><C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR>
noremap <leader>rr :<C-U>Leaderf! rg --recall<CR>
noremap <leader>fr :<C-U>Leaderf! file --recall<CR>


"## air-line
set laststatus=2
"let g:airline#extensions#tabline#enabled = 1
let g:airline_exclude_preview = 1
let g:airline_theme='dark'

"## Tagbar
nmap <F2> :TagbarToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set t_BE=
set history=700
set autoread
set nu
set hlsearch
set mouse=a
set autoindent
set smartindent
set cindent
set smarttab
set showmatch
set report=0
set modeline
set nofoldenable

"Edit vimrc quickly and apply immediately
nmap <leader>e :e ~/.vimrc<CR>
autocmd! bufwritepost .vimrc source ~/.vimrc

"Select all
"map <C-A> ggVG

"Suuround word in quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"A buffer becomes hidden when it is abandoned
set hidden

" Ignore case when searching
" set ignorecase

" Highlight search results
set hlsearch

"# Files, backups and undo
" ## Turn backup off
set nobackup
set nowb
set noswapfile

"Toggles paste mode
nnoremap <F12> :set invpaste paste?<CR>i
set pastetoggle=<F12>
set showmode

" clipbaord selection
set clipboard=unnamedplus
" primary selection
"set clipboard=unnamed
"
"Toggles indent line
set list listchars=tab:\|-,trail:.,extends:>
set list
nmap <leader>i :set list!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
set t_Co=256

set background=dark
colorscheme PaperColor
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1
  \     }
  \   },
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
"colorscheme wombat256
"hi Normal guibg=NONE ctermbg=NONE
"if has('gui_running')
"  set guifont=Hack\ 14
"  colorscheme PaperColor
"  set lines=999 columns=999
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
nnoremap <silent> <leader><cr> :noh<cr>
" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <leader>j <C-W>j
noremap <leader>k <C-W>k
noremap <leader>h <C-W>h
noremap <leader>l <C-W>l

" Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<space>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>

"Exit insert mode quickly
inoremap jj <ESC>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

au BufNewFile,BufRead *.icli setlocal ft=c
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set expandtab

"au BufNewFile,BufRead *.c set tabstop=8
"au BufNewFile,BufRead *.c set softtabstop=8
"au BufNewFile,BufRead *.c set shiftwidth=8
"au BufNewFile,BufRead *.c set noexpandtab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Grep searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map  <F5> :execute "lgrep! -srnw --binary-files=without-match --exclude-dir=.git --exclude-dir=.svn . -e " . expand("<cword>") . " "<bar>lw<CR><CR>
if executable("rg")
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%m
endif
nnoremap  <leader>g :lgrep! "\b<C-R><C-W>\b"<CR>:lw<CR>

nnoremap <silent> <leader>lt :call LocationlistToggle()<CR>
augroup LoctionlistToggle
  autocmd!
  autocmd BufWinEnter quickfix let g:llist_opened = 1
  autocmd BufWinLeave quickfix let g:llist_opened = 0
augroup END
set switchbuf+=usetab,newtab "new tab for quickfix


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LocationlistToggle()
  if g:llist_opened
    lclose
    let g:llist_opened = 0
  else
    lopen
    let g:llist_opened = 1
  endif
endfunction
