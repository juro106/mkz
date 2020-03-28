scriptencoding utf-8

if exists('g:loaded_mkz')
    finish
endif

let g:loaded_mkz = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists(":Mkz")
    command! -nargs=? Mkz call Mkz#ToggleOutline(<f-args>)
endif

if !hasmapto('<Plug>Mkz')
    nmap <silent> <F10> <Plug>Mkz
endif
nnoremap <Plug>Mkz :<C-u>Mkz<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
