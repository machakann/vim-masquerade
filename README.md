# vim-masquerade

Tools to edit multiple selections

**!!! This is a highly experimental plugin. Its behavior might be changed a lot for future. !!!**

# Dependency

- Vim 8.0 or higher
- [vim-multiselect](https://github.com/machakann/vim-multiselect)

# Introduction
*masquerade.vim* provides wrapped operators to work with *multiselect.vim*. These operators edit texts as repeating sets of visual selection and calling an original operator for each multi-selected regions.

This plugin does not provide any default keymappings. Choose what you need from the following list.

```vim
nmap y <Plug>(masquerade-y)
xmap y <Plug>(masquerade-y)

nmap Y <Plug>(masquerade-Y)
xmap Y <Plug>(masquerade-Y)

map d <Plug>(masquerade-d)

nmap D <Plug>(masquerade-D)
xmap D <Plug>(masquerade-D)

nmap x <Plug>(masquerade-x)
xmap x <Plug>(masquerade-x)

nmap X <Plug>(masquerade-X)
xmap X <Plug>(masquerade-X)

map c <Plug>(masquerade-c)

nmap C <Plug>(masquerade-C)
xmap C <Plug>(masquerade-C)

nmap s <Plug>(masquerade-s)
xmap s <Plug>(masquerade-s)

nmap S <Plug>(masquerade-S)
xmap S <Plug>(masquerade-S)

nmap p <Plug>(masquerade-p)
xmap p <Plug>(masquerade-p)

nmap P <Plug>(masquerade-P)
xmap P <Plug>(masquerade-P)

nmap i <Plug>(masquerade-i)
xmap I <Plug>(masquerade-i)

nmap a <Plug>(masquerade-a)
nmap A <Plug>(masquerade-a)

map < <Plug>(masquerade-<)
map > <Plug>(masquerade->)

map g~ <Plug>(masquerade-g~)
nmap ~ <Plug>(masquerade-~)
xmap ~ <Plug>(masquerade-~)

map gu <Plug>(masquerade-gu)
map gU <Plug>(masquerade-gU)

map g? <Plug>(masquerade-g?)

map gq <Plug>(masquerade-gq)
map gw <Plug>(masquerade-gw)

map = <Plug>(masquerade-=)

map ! <Plug>(masquerade-!)
```

# Demo

![masquerade demo](https://imgur.com/SZ4624O.gif)
