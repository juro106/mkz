# Mkz

I only have one thing to do.

Show a list of headings.

![ScreenShot](https://i.imgur.com/Tvrpbs2.png)

## Description

Simple outline(Table of Contents) viewer for Vim in only markdown(html).

This plugin do not mix up H2 in the content and the last line of yaml frontmatter.

## Quickstart

default keymapping `<F10>`

The key mapping can be configuerd in your .vimrc

example:
```vim
nmap <F8> <Plug>(mkz-toggle)
```
if you do this the F8 key will toggle the Outline window.

## Setting

example:
```vim
" window width (default 60)
let l:mkz_width=100
" window open left or right ( default -> 0(right), left -> 1 ) 
let l:mkz_open_left=1
" window focus ( default -> 0(stay), focus new window -> 1 )
let l:mkz_focus=1
```

## Mkzとは

markdown(またはhtml)で目次を表示するためだけに存在するVim Plugin です。

複雑なことはできません。見出し一覧を表示させるだけです。

- ウインドウは右側に開き、トグル式になっています。
- ウインドウを開いてもフォーカスはメインウインドウのままです。
- ジャンプ機能付。
- yaml形式でFront Matterを書いても最後の行はH2と認識しないようにしてあります。
- Hタグの中や外のaタグなどは排除して表示されます。

ウインドウを右側に表示させたい、そしてトグルしたい。yamlのfrontmatterの最終行は見出しとしてカウントしてほしくない。Ctagsうまくいかない。この４つのイシューのために作成されました。

声を大にしておすすめできる代物ではありません。
