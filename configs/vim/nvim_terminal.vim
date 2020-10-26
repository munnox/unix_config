
" Neovim terminal remap
if has("nvim")
    " got normal with Ctrl+[
    tnoremap <C-[> <C-\><C-n>
    " turn terminal to normal mode with escape
    tnoremap <Esc> <C-\><C-n>

    " Leave buffer in normal mode and move to the direction given
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l

    tnoremap <C-v> <C-\><C-n>"0pi
    " Move to the terminal on the right side move to the last cmd and run then
    " move back
    nmap <leader>tr :w<CR><C-w>li<UP><CR><C-\><C-n><C-w>h
    nmap <leader>tpae :w<CR><C-w>lisource pyvenv/bin/activate<CR><C-\><C-n><C-w>h
    nmap <leader>tpde :w<CR><C-w>lideactivate<CR><C-\><C-n><C-w>h

    " start terminal in insert mode
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif
    " open terminal on ctrl+n
    function! OpenTerminal()
            vsplit term://bash
            " resize 20
            vertical resize 80
    endfunction
    nnoremap <leader>ts :call OpenTerminal()<CR>
    nnoremap <leader>termss :vsplit <BAR> terminal<CR>

endif

