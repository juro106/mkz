scriptencoding utf-8

if exists('g:loaded_mkz')
    finish
endif

let g:loaded_mkz = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists(":Mkz")
    command! -nargs=? Mkz call Mokuji#ShowOutline(<f-args>)
endif

if !hasmapto('<Plug>Mkz')
    nnoremap <silent> <F10> :<C-u>Mkz<CR>
endif
nnoremap <Plug>Mkz :<C-u>Mkz

let &cpo = s:save_cpo
unlet s:save_cpo
