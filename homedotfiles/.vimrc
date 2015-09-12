" vimRc file by Robert Munnoch
autocmd! bufwritepost .vimrc source %

set pastetoggle=<F2>
set clipboard=unnamed

" Mouse and keyboard settings to keep it inline with other devices
set mouse=a " on osx press alt and click
set bs=2	" make backspace behave like a normal agian

" Rebind <leader> key
let mapleader = "`" " is a key that vim will wait till 

" Course Highlighting section
" set cursorline

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

noremap   <leader>k      :s,^\(\s*\)[^# \t]\@=,\1#,e<CR>:nohls<CR>zvj
noremap   <leader>K  :s,^\(\s*\)#\s\@!,\1,e<CR>:nohls<CR>zvj

" Bind nohl
" Removes highlight  of your last search
"noremap <C-n> :nohl<CR>
"vnoremap <C-n> :nohl<CR>
"inoremap <C-n> :nohl<CR>

" Quicksave command
"noremap <C-Z> :update<CR>
"vnoremap <C-Z> :update<CR>
"inoremap <C-z> :update<CR>

" Enable Syntax Highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on 
" From the python wiki to turn on the python autocomplete
filetype plugin on

" Folder parameters
set foldmethod=indent
set foldcolumn=2
set foldlevel=99

" Showline numbers and length
set number " show line number
set tw=79 " width of document (used by gd)
set nowrap " don't automatically wrap on load
set fo-=t " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Useful settings
set history =700
set undolevels=700

" Real programmers don't use spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Disable stupid backup and swap files - they trigger to many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim
" 
" " Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()

colorscheme murphy

" Buffer shortcuts
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


