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

## Option

example:
```vim
" if you want to change width (# default: 60)
let l:mkz_width=100
" if you want to open window left (# default: 0)
let l:mkz_open_left=1
" if you want to focus new window (# default: 0)
let l:mkz_focus=1
```

## Mkzとは

markdown(またはhtml)で目次を表示するためだけに存在する Vim Plugin です。

複雑なことはできません。見出し一覧を表示させるだけです。

### オプション

- ウインドウを開く位置を左右どちらか選べます。
- ウインドウを開いた直後、フォーカスを移すかメインウインドウのままにするか選べます。
- yaml形式でFront Matterを書いても最後の行はH2と認識しないようにしてあります。
- ジャンプ機能付。
- Hタグの中や外のaタグなどは排除して表示されます。

声を大にしておすすめできる代物ではありません。
