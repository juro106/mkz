if exists('b:current_syntax')
  finish
endif

syn match OutlineHeaderMark '^▼'
syn match OutlineHeadingNum '^Title\|^H1'
syn match OutlineHeadingNum '\%(| \)\@<=H[2-6]'
syn match OutlineHeadingBold '\%(Title \|H[1-2] \)\@<=\(.*\)\s\s'
syn match OutlineHeadingNormal '\%(H[3-6] \)\@<=\(.*\)\s\s'
syn match OutlineDepth '^\(| \)\+'
syn match Hidden '\d\+$'

hi def link OutlineHeaderMark Statement
hi def link OutlineHeadingBold Title
if &background ==# 'dark'
    hi OutlineDepth guifg=#333333
    hi OutlineHeadingNum guifg=#222222 guibg=#999999 gui=bold
    hi OutlineHeadingNormal guifg=#eeeeee
    hi Hidden guifg=#222222
else
    hi OutlineDepth guifg=#e9e9e9
    hi OutlineHeadingNum guifg=#555555 guibg=#eeeeee gui=bold
    hi def link OutlineHeadingNormal String
    hi Hidden guifg=#efefef
endif

let b:current_syntax = 'mkz'
