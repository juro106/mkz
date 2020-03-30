function! Mkz#ToggleOutline() abort
    
    if bufexists('Outline')
        call <SID>DeleteOutline()
        return
    endif

    if !exists("l:mkz_open_left")
        let mkz_open_left = 0
    endif
    if !exists("l:mkz_focus")
        let mkz_focus = 0
    endif

    if !exists("l:mkz_width")
        let l:mkz_width=60
    endif

    let l:lines = getline(1,"$")

    if !exists("b:regex_command")
        call <SID>HeadingSet()
    endif

    let l:regex_command = b:regex_command

    if l:mkz_open_left == 0
        setlocal splitright
    endif
    exec "vertical ".l:mkz_width." split Outline"

    let l:i=1
    while l:i < len(l:lines)+1
        call setline(l:i,l:lines[l:i-1]."  ".l:i)
        let l:i += 1
    endwhile
    
    for cmd in l:regex_command
        exec "silent!".cmd
    endfor
    let l:header = ["", " ▼ Heading"]
    call append(0, l:header)

    setlocal statusline=[OUTLINE]
    setlocal filetype=mkz
    setlocal nonumber
    setlocal buftype=nofile
    setlocal noswf
    setlocal bufhidden=unload

    nnoremap <silent> <buffer> <CR> :<C-u>call <SID>JumpToHeading()<CR>
    nnoremap <silent> <buffer> q :<C-u>call <SID>DeleteOutline()<CR>
    cnoremap <silent> <buffer> q <C-u>call <SID>DeleteOutline()<CR>

    augroup outline
        autocmd!
        autocmd Bufleave <buffer> setlocal nobuflisted
        autocmd VimLeavePre <buffer> setlocal nobuflisted
        autocmd WinEnter * if (winnr("$") == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'nofile' | quit | endif
    augroup END

    setlocal nomodifiable
    setlocal readonly

    " echo 'open'
    
    if l:mkz_open_left==0 && l:mkz_focus==0
        wincmd h
    elseif l:mkz_open_left==0 && l:mkz_focus==1
        wincmd l 
    elseif l:mkz_open_left==1 && l:mkz_focus==0
        wincmd l
    elseif l:mkz_open_left==1 && l:mkz_focus==1
        wincmd h 
    endif
endfunction

function! s:JumpToHeading() abort
    let l:line = getline(".")
    let l:jumpline = matchstr(l:line, '\d\+$')
    wincmd p
    exec l:jumpline
    normal zz
endfunction

function! s:HeadingSet() abort
    if (&ft == 'markdown' || &ft == 'md')
        let b:regex_command=[ ''
            \, '%s/\v-+(\_.{-})\n-+/\r\1\r/'
            \, '%s/\v\++(\_.{-})\n\++/\r\1\r/'
            \, '%s/\v(.*)\n\=+(\ \ \d+)/\r# \1/'
            \, '%s/\v(.*)\n-+(\ \ \d+)/\r## \1/'
            \, '%s/^h1: /# /'
            \, 'g!/\v^title: |^#|\<h[1-6]\>/d'
            \, '%s/\v.*\<h1[^\>]*\>/# /'
            \, '%s/\v.*\<h2[^\>]*\>/## /'
            \, '%s/\v.*\<h3[^\>]*\>/### /'
            \, '%s/\v.*\<h4[^\>]*\>/#### /'
            \, '%s/\v.*\<h5[^\>]*\>/##### /'
            \, '%s/\v.*\<h6[^\>]*\>/###### /'
            \, '%s/<.*>//g'
            \, '%s/<\/.*>//g'
            \, "%s/'//g"
            \, '%s/\"//g'
            \, '%s/^title: /Title /'
            \, '%s/^# /H1 /'
            \, '%s/^## /| H2 /'
            \, '%s/^### /| | H3 /'
            \, '%s/^#### /| | | H4 /'
            \, '%s/^##### /| | | | H5 /'
            \, '%s/^###### /| | | | | H6 /'
            \, ]
    elseif (&ft == 'html')
        let b:regex_command=['g!/^\s*\<h1\|<h2\|<h3\|<h4\|<h5\|<h6/d'
            \, '%s/<\/h1>\|<\/h2>\|<\/h3>\|<\/h4>\|<\/h5>\|<\/h6>//'
            \, '%s/\v\<a[^\>]*\>//'
            \, '%s/<\/a>//'
            \, '%s/\v\<div[^\>]*\>//'
            \, '%s/<\/div>//'
            \, '%s/\v\<span[^\>]*\>//'
            \, '%s/<\/span>//'
            \, '%s/\v\<p[^\>]*\>//'
            \, '%s/<\/p>//'
            \, "%s/'//g"
            \, '%s/\"//g'
            \, '%s/\v\<h1[^\>]*\>/# /'
            \, '%s/\v\<h2[^\>]*\>/## /'
            \, '%s/\v\<h3[^\>]*\>/### /'
            \, '%s/\v\<h4[^\>]*\>/#### /'
            \, '%s/\v\<h5[^\>]*\>/##### /'
            \, '%s/\v\<h6[^\>]*\>/###### /'
            \, '%s/^# /H1 /'
            \, '%s/^## /| H2 /'
            \, '%s/^### /| | H3 /'
            \, '%s/^#### /| | | H4 /'
            \, '%s/^##### /| | | | H5 /'
            \, '%s/^###### /| | | | | H6 /'
            \, ]
    else
        let b:regex_command=['g!/^\*/d','%s/\[.\+\]//','%s/^\(\*\+\)\s*/\1/','%s/^\*//','%s/\*/  /g']
    endif
endfunction

function! s:DeleteOutline() abort
    bw Outline
    " echo 'close'
endfunction
