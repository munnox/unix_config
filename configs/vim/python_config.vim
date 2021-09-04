
" =======================================================================
" Python IDE setup
" ========================================================================

" Settings for vim-powerline
" cd ~.vim/bundle
" git clone git://github.com/Lokaltob/vim-powerline.git

" Settings for vim-airline
" Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1
" " Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
" let g:ctrlp_max_height = 30
" set wildignore+=*.pyc
" set wildignore+=*_build/*
" set wildignore+=*/coverage/*

" Settings for jedi-vim
" cd ~/.vim/bundle/ && git clone --recursive
" https://github.com/davidhalter/jedi-vim.git
" let g:jedi#use_splits_not_buffers = "left"
" let g:jedi#popup_on_dot = 0 " this disable the autocompleation on a dot
" let g:jedi#popup_select_first = 0 " this disables the selection of the first
" line of the completion

" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_definitions_command = "<leader>d"
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
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


" inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
" inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" python folding
" mkdir -p ~/.vim/ftplugin
" wget -0 ~/.vim/ftplugin/python_editing.vim http://www.vim.org/script
" set nofoldenable
