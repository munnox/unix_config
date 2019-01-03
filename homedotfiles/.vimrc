" vimRc file by Robert Munnoch

set nocompatible              " required
filetype off                  " required

autocmd! bufwritepost .vimrc source %
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
" Ctrl-p
Plugin 'kien/ctrlp.vim'
" You Complete Me 
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","       " leader is comma

" turn off search highlight with ,-<space>
nnoremap <leader><space> :nohlsearch<CR>

" Invoke Ctrl-p with c-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
""""""""""""""""""""""""""""""""""""""""""""""""

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

map <C-n> :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""
" To open a new empty buffer
" " This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>
"
" " Move to the next buffer
nmap <leader>bl :bnext<CR>
"
" " Move to the previous buffer
nmap <leader>bh :bprevious<CR>
"
" " Close the current buffer and move to the previous one
" " This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
"
" " Show all open buffers and their status
nmap <leader>bs :ls<CR>


""""""""""""""""""""""""""""""""""""""""""""""""
" General Configuration
""""""""""""""""""""""""""""""""""""""""""""""""

" Mouse
set mouse=a

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Automatically update a file if it is changed externally
set autoread

" Height of the command bar
set cmdheight=2

set hlsearch	    " highlight search matches
set incsearch	    " search while characters are entered

" search is case-insensitive by default
set ignorecase

" Show linenumbers
set number

set showcmd	" show last command in the bottom right

set ruler	" always show current position

" Line wrap (number of cols)
set wrap	    " wrap lines only visually
set linebreak	    " wrap only at valid characters
set textwidth=0	    " prevent vim from inserting linebreaks
set wrapmargin=0    "   in newly entered text

" Disable stupid backup and swap files - they trigger to many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile


" show matching braces
set showmatch

" =======================================================================
" Python IDE setup
" ========================================================================

" Settings for vim-powerline
" cd ~.vim/bundle
" git clone git://github.com/Lokaltob/vim-powerline.git
set laststatus=2

" Settings for vim-airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
" set wildignore+=*_build/*
" set wildignore+=*/coverage/*

" Settings for jedi-vim
" cd ~/.vim/bundle/ && git clone --recursive
" https://github.com/davidhalter/jedi-vim.git
let g:jedi#use_splits_not_buffers = "left"
" let g:jedi#popup_on_dot = 0 " this disable the autocompleation on a dot
" let g:jedi#popup_select_first = 0 " this disables the selection of the first
" line of the completion

let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#show_call_signatures = "1"
" let g:jedi#completions_enabled = 0 " To turn off auto compleation but keep
" all else


" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
" map <Leader>g :call RopeGotoDefinition()<CR>
" let ropevim_enable_shortcuts = 1
" let g:pymode_rope_goto_def_newwin = "vnew"
" let g:pymode_rope_extended_complete = 1
" let g:pymode_breakpoint = 0
" let g:pymode_syntax = 1
" let g:pymode_syntax_builtin_objs = 0
" let g:pymode_syntax_builtin_funcs = 0
" map <Leader>b 0import ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
"
" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for
" set completeopt=longest,menuone
" function! OmniPopup(action)
"   if pumvisible()
"       if a:action == 'j'
"           return "\<C-N>"
"       elseif a:action == 'k'
"           return "\<C-P>"
"       endif
"   endif
"   return a:action
"endfunction


inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" python folding
" mkdir -p ~/.vim/ftplugin
" wget -0 ~/.vim/ftplugin/python_editing.vim http://www.vim.org/script
set nofoldenable

" Setup soft linebreak will not list the line number and should not change the
" text but keep the test on screen
set wrap linebreak nolist


