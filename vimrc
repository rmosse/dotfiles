" =============================================================================
" Bundle plugins 
" =============================================================================


set nocompatible              " be iMproved
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

let uname = substitute(system("uname"),"\n","","g")

Plugin 'kien/ctrlp.vim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'kana/vim-operator-user'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/grep.vim'
Plugin 'bling/vim-airline'
Plugin 'dhruvasagar/vim-markify'
Plugin 'derekwyatt/vim-protodef'
Plugin 'scrooloose/nerdtree'
Plugin 'aperezdc/vim-template'
Plugin 'Rip-Rip/clang_complete'
Plugin 'benekastah/neomake'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" =============================================================================
" General settings 
" =============================================================================

set encoding=utf-8
scriptencoding utf-8
syntax enable

set wildmode=longest,list,full
set wildmenu                  " autocomplete menu 
set hlsearch
set laststatus=2 " tell VIM to always put a status line in, 
                 " even if there is only one window
set ignorecase              
set number 

" show tabs
set list listchars=tab:\|\

" Indentation
set cino=N-s " Don't indent namespaces.
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=80

" GUI 
set guifont=Monospace\ 13
set go-=m ""no menu bar             " Splits lines that are inserted after 80 chars
set go-=T "no toolbar              set textwidth=80
" set go-=r "no right hand scroll bar

set diffopt+=iwhite

let g:ack_use_dispatch = 0

let g:valgrind_arguments = ""

set shortmess+=A
"=============================================================================
" Shortcuts 
" =============================================================================
noremap ,t  :!/opt/swt/bin/ctags -R ../ <cr>
noremap ,a :Grep <cword><cr><cr>
noremap ,d :w !diff % - <cr>

"=============================================================================
" NERDtree 
" =============================================================================

let NERDTreeIgnore = ['\.pyc$','\.o$','\.d$','\.dd$', 'dummy\.c$', 'llcalc_ref*', '00*', '_dum\.c', '.pdf$', 'plink_timestamp\.*\.c$', '\.mapfile$',  'ported\.*$', '_refs\.c$', '^tags$']
let g:NERDTreeDirArrows=0 
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

map <C-n> :NERDTreeToggle<CR>

" =============================================================================
" Powerline
" =============================================================================

" set fillchars+=stl:\ ,stlnc:\
" let g:Powerline_symbols = 'fancy'


" =============================================================================
" Make
" =============================================================================

noremap ,m :Make!<cr>
noremap ,ms :Make<cr>
noremap ,mc :Make clean <cr>
noremap ,b :Make buildobjs <cr>
noremap ,e :Copen <cr>
noremap ,ee :cclose <cr>

    
if uname == "Darwin"
    set makeprg=Make
    autocmd! BufWritePost * Neomake!
else
    set makeprg=plink\ *.mk
endif

set errorformat=%f:%l:%c:\ %trror:\ %m,
        \%f:%l:%c:\ %tarning:\ %m,
        \%f:%l:%c:\ %m

" =============================================================================
" Clang Complete
" ==============================================================================

let g:clang_use_library = 1
let g:clang_jumpto_declaration_key = "<Nop>"
let g:clang_jumpto_back_key = "<Nop>"

let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"
" =============================================================================
" Rainbow Parentheses 
" =============================================================================
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" =============================================================================
"  Gvim
" =============================================================================
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=81 columns=316
else
  set t_ut=
  " This is console Vim.
 " if exists("+lines")
 "   set lines=120
 " endif
 " if exists("+columns")
 "   set columns=120
 " endif
endif

" =============================================================================
"  Shortcuts
" =============================================================================

"clear search highlight
noremap ,/ :let @/ = ""<cr> 

"saving
inoremap <C-s> <esc>:w<cr>a
noremap <C-s> :w<cr> 
noremap <C-q> :q<cr> 

"noremap <silent> <C-S>          :update<CR>
"vnoremap <silent> <C-S>         <C-C>:update<CR>
"inoremap <silent> <C-S>         <C-O>:update<CR>

:set pastetoggle=<f5>
set backspace=indent,eol,start

" =============================================================================
"  learn vim 
" =============================================================================
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

" =============================================================================
"  F-Switch
" =============================================================================
" TODO When in cpp, if there is no .h creates .hpp
noremap <silent> -- :FSHere<cr>
noremap <silent> -j :FSBelow<cr>
noremap <silent> -k :FSAbove<cr>
noremap <silent> -l :FSRight<cr>
noremap <silent> -h :FSLeft<cr>
 
" =============================================================================
"  Ctrlp
" =============================================================================
noremap <silent> ,o :CtrlP<cr>
let g:ctrlp_follow_symlinks = 2
let g:ctrlp_working_path_mode = 'r'

" =============================================================================
"  Svndiff
" =============================================================================
hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green' 
hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red' 
hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow' 

noremap ,sd :call Svndiff("next")<CR> 
noremap ,sc :call Svndiff("next")<CR> 

" =============================================================================
"  Clang format
" =============================================================================

" let g:clang_format#style_options = {
"             \ "AccessModifierOffset" : -4,
"             \ "AllowShortIfStatementsOnASingleLine" : "true",
"             \ "AlwaysBreakTemplateDeclarations" : "true",
"             \ "Standard" : "C++11",
"             \ "BreakBeforeBraces" : "Allman"}
" 
" 
"
"map <C-K> :pyf ~/bin/clang-format.py<CR>
"imap <C-K> <ESC>:pyf ~/bin/clang-format.py<CR>i

autocmd FileType c,cpp,objc nnoremap <buffer><C-K> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><C-K> :ClangFormat<CR>

"map <C-K> :pyf /opt/bb/share/clang/clang-format.py<cr>
"imap <C-K> <c-o>:pyf <path-to-this-file>/clang-format.py<cr>
"
" =============================================================================
" Autodefinition 
" =============================================================================

nmap ,h :CopyDefinition<CR> :FSHere<CR>
nmap ,g :ImplementDefinition<CR>


" =============================================================================
" Colorscheme 
" =============================================================================
set t_Co=256
colorscheme molokai

if &diff
     set background=dark
endif

