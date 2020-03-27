function! Mokuji#ShowOutline() abort
 
    " すでに Outline のウインドウがあったら閉じてリターン
    if bufexists('[Outline]')
        wincmd l
        " save current number
        let l:cnumber = line(".")
        bw [Outline]
        return
    endif
    
    " 現在開いているバッファ（ウインドウ）の処理
    " 行（バッファ）の内容を取得
    let l:lines = getline(1,"$")

    if ! exists("b:outline_command")
        call <SID>HeadingSet()
    endif

    let l:outline_command = b:outline_command
    " 新しいウインドウを開いてからの処理

    " 新しいウインドウを開く
    if ! exists("b:outline_width")
        let b:outline_width=60
    endif

    " 右側に開く
    setlocal splitright
    exec "vertical ".b:outline_width." split [Outline]"

    " silent! 1,$delete _

    " 行番号を末尾に付与して書き出す
    let l:i=1
    while l:i < len(l:lines)+1
        call setline(l:i,l:lines[l:i-1]."  ".l:i)
        let l:i += 1
    endwhile

    " 見出しだけ抜き出して置換
    for outcommand in l:outline_command
        exec "silent!".outcommand
    endfor
    let l:header = ["", " ▼ Heading"]
    call append(0, l:header)

    setlocal nonumber
    setlocal bt=nofile noswf
    setlocal bufhidden=hide
    setlocal textwidth=0

    " 色を変える
    exec 'syntax match OutlineHeaderMark /^▼/'
    exec 'syntax match OutlineHeadingNum /Title\|H1\|\%(| \)\@<=H[1-6]/'
    exec 'syntax match OutlineHeadingBold /\%(H[1-2] \|Title \)\@<=\(.*\)  /'
    " exec 'syntax match OutlineHeadingBold /\%(Title \)\@<=\(.*\)  /'
    exec 'syntax match OutlineHeadingNormal /\%(H[3-6] \)\@<=\(.*\)  /'
    exec 'syntax match OutlineDepth /^\(| \)\+/'
    exec 'syntax match Hidden /\d\+$/'

    " hi! def link OutlineHeaderMark vimFuncName
    hi! def link OutlineHeaderMark Statement
    hi! OutlineDepth guifg=#333333
    hi! OutlineHeadingNum guifg=#222222 guibg=#999999 gui=bold
    hi! def link OutlineHeadingBold Title
    hi! OutlineHeadingNormal guifg=#eeeeee
    hi! Hidden guifg=#222222
    
    nnoremap <silent> <buffer> <CR> :call <SID>JumpToHeading()<CR>
    nnoremap <silent> <buffer> q :q<CR>

    setlocal noma

    "元の ウインドウへ戻る
    wincmd h
endfunction "}}}

function! s:JumpToHeading() abort "{{{
    let l:line = getline(".")
    let l:jumpline = matchstr(l:line,'\d\+$')
    wincmd p " 直前のウインドウへ移動する
    exec l:jumpline
    normal zz
endfunction "}}}

function! s:HeadingSet() abort "{{{
    if (&ft == 'markdown' || &ft == 'md')
        let b:outline_command=['g!/^title: \|^h1: \|^#\|^\s*<h[1-6]/d'
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
        let b:outline_command=['g!/^\s*\<h1\|<h2\|<h3\|<h4\|<h5\|<h6/d'
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
        let b:outline_command=['g!/^\*/d','%s/\[.\+\]//','%s/^\(\*\+\)\s*/\1/','%s/^\*//','%s/\*/  /g']
    endif
endfunction "}}}
