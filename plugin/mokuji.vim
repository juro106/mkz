if exists('g:mokuji_outline')
    finish
endif

let g:mokuji_outline = 1

let s:save_cpo = &cpo
set cpo&vim

" vim script
command! -nargs=? Mokuji call Mokuji#ShowOutline(<f-args>)

" Toggle
nnoremap <silent> <F10>      :<C-u>Mokuji<CR>
nnoremap <silent> <leader>s  :<C-u>Mokuji<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
