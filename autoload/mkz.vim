function! Mkz#ToggleOutline() abort
    
    if bufexists('Outline')
        call <SID>DeleteOutline()
        return
    endif

    let l:lines = getline(1,"$")

    if ! exists("b:regex_command")
        call <SID>HeadingSet()
    endif

    let l:regex_command = b:regex_command

    if ! exists("b:outline_width")
        let b:outline_width=60
    endif

    setlocal splitright
    exec "vertical ".b:outline_width." split Outline"

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
    setlocal nonumber
    setlocal bt=nofile noswf
    setlocal bufhidden=hide
    setlocal textwidth=0

    exec 'syntax match OutlineHeaderMark /^▼/'
    exec 'syntax match OutlineHeadingNum /Title\|H1\|\%(| \)\@<=H[1-6]/'
    exec 'syntax match OutlineHeadingBold /\%(H[1-2] \|Title \)\@<=\(.*\)  /'
    exec 'syntax match OutlineHeadingNormal /\%(H[3-6] \)\@<=\(.*\)  /'
    exec 'syntax match OutlineDepth /^\(| \)\+/'
    exec 'syntax match Hidden /\d\+$/'
    
    hi! def link OutlineHeaderMark Statement
    hi! OutlineDepth guifg=#333333
    hi! OutlineHeadingNum guifg=#222222 guibg=#999999 gui=bold
    hi! def link OutlineHeadingBold Title
    hi! OutlineHeadingNormal guifg=#eeeeee
    hi! Hidden guifg=#222222
    
    nnoremap <silent> <buffer> <CR> :<C-u>call <SID>JumpToHeading()<CR>
    nnoremap <silent> <buffer> q :<C-u>call <SID>DeleteOutline()<CR>
    cnoremap <silent> <buffer> q <C-u>call <SID>DeleteOutline()<CR>

    setlocal noma

    echo "open"
    
    wincmd h
endfunction

function! s:JumpToHeading() abort
    let l:line = getline(".")
    let l:jumpline = matchstr(l:line,'\d\+$')
    wincmd p
    exec l:jumpline
    normal zz
endfunction

function! s:HeadingSet() abort
    if (&ft == 'markdown' || &ft == 'md')
        let b:regex_command=['g!/^title: \|^h1: \|^#\|^\s*<h[1-6]/d'
            \, '%s/<\/h1>\|<\/h2>\|<\/h3>\|<\/h4>\|<\/h5>\|<\/h6>//'
            \, '%s/\v\<a [^\>]*\>//'
            \, '%s/<\/a>//'
            \, '%s/\v\<div[^\>]*\>//'
            \, '%s/<\/div>//'
            \, '%s/\v\<span[^\>]*\>//'
            \, '%s/<\/span>//'
            \, '%s/\v\<p[^\>]*\>//'
            \, '%s/<\/p>//'
            \, '%s/h1: /# /'
            \, '%s/\v\<h1[^\>]*\>/# /'
            \, '%s/\v\<h2[^\>]*\>/## /'
            \, '%s/\v\<h3[^\>]*\>/### /'
            \, '%s/\v\<h4[^\>]*\>/#### /'
            \, '%s/\v\<h5[^\>]*\>/##### /'
            \, '%s/\v\<h6[^\>]*\>/###### /'
            \, "%s/'//g"
            \, '%s/\"//g'
            \, "%s/{.*}//g"
            \, '%s/title: /Title /'
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
    wincmd l
    bw Outline
    echo "close"
endfunction
