# Mkz

I only have one thing to do.

Show a list of headings.

![screenshot](https://i.imgur.com/WeAYWpY.png)

## Description

Simple outline(Table of Contents) viewer for Vim in only markdown(html).

This plugin do not mix up H2 in the content and the last line of yaml frontmatter.

## Quickstart

default keymapping `<F10>`

The key mapping can be configuerd in your .vimrc

example:
```vim
nmap <F8> <Plug>Mkz
```
if you do this the F8 key will toggle the Outline window.

## Mkzとは

mkzとは、markdown(またはhtml)で目次を表示するためだけに存在するVim Plugin です。

複雑なことはできません。見出し一覧を表示させるだけです。

- ウインドウは右側に開き、トグル式になっています。
- ウインドウを開いてもフォーカスはメインウインドウのままです。
- yaml形式でFront Matterを書いても最後の行はH2と認識しないようにしてあります。
- Hタグの中や外のaタグなどは排除して表示されます。

声を大にしておすすめできる代物ではありません。

色やウインドウの位置、表示内容のカスタマイズなどが柔軟にできるように改良していけたらと思っております。
