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
hi OutlineDepth guifg=#333333
hi OutlineHeadingNum guifg=#222222 guibg=#999999 gui=bold
hi def link OutlineHeadingBold Title
hi OutlineHeadingNormal guifg=#eeeeee
hi Hidden guifg=#222222

let b:current_syntax = 'mkz'
