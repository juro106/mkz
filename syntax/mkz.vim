if exists('b:current_syntax')
  finish
endif

syn match OutlineHeaderMark '/^▼/'
syn match OutlineHeadingNum '/Title\|H1\|\%(| \)\@<=H[1-6]/'
syn match OutlineHeadingBold '/\%(H[1-2] \)\@<=\(.*\)  /'
syn match OutlineHeadingBold '/\%(Title \)\@<=\(.*\)  /'
syn match OutlineHeadingNormal '/\%(H[3-6] \)\@<=\(.*\)  /'
syn match OutlineDepth '/^\(| \)\+/'
syn match Hidden '/\d\+$/'

hi! OutlineDepth guifg=#333333
hi! OutlineHeadingNum guifg=#222222 guibg=#999999 gui=bold
hi! OutlineHeadingBold gui=bold
hi! OutlineHeadingNormal guifg=#eeeeee
hi! def link OutlineHeaderMark vimFuncName
hi! Hidden guifg=#222222

let b:current_syntax = 'mokuji'
