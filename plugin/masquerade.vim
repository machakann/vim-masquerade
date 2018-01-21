" masquerade.vim : Tools to edit multiple selections
" Maintainer : Masaaki Nakamura <https://github.com/machakann>
if &compatible || exists("g:loaded_masquerade")
  finish
endif
let g:loaded_masquerade = 1

nnoremap <silent><expr> <Plug>(masquerade-g~) masquerade#edit('n', 'g~', {'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-g~) masquerade#edit('x', 'g~', {'useregister': 0})
onoremap <Plug>(masquerade-g~) g~
nnoremap <silent><expr> <Plug>(masquerade-~) masquerade#edit('n', '~', {'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-~) masquerade#edit('x', '~', {'useregister': 0})
onoremap <Plug>(masquerade-~) ~
nnoremap <silent><expr> <Plug>(masquerade-gu) masquerade#edit('n', 'gu', {'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-gu) masquerade#edit('x', 'gu', {'useregister': 0})
onoremap <Plug>(masquerade-gu) gu
nnoremap <silent><expr> <Plug>(masquerade-gU) masquerade#edit('n', 'gU', {'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-gU) masquerade#edit('x', 'gU', {'useregister': 0})
onoremap <Plug>(masquerade-gU) gU
nnoremap <silent><expr> <Plug>(masquerade-g?) masquerade#edit('n', 'g?', {'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-g?) masquerade#edit('x', 'g?', {'useregister': 0})
onoremap <Plug>(masquerade-g?) g?
nnoremap <silent><expr> <Plug>(masquerade-gq) masquerade#edit('n', 'gq', {'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-gq) masquerade#edit('x', 'gq', {'useregister': 0})
onoremap <Plug>(masquerade-gq) gq
nnoremap <silent><expr> <Plug>(masquerade-gw) masquerade#edit('n', 'gw', {'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-gw) masquerade#edit('x', 'gw', {'useregister': 0})
onoremap <Plug>(masquerade-gw) gw
nnoremap <silent><expr> <Plug>(masquerade-=) masquerade#edit('n', '=', {'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-=) masquerade#edit('x', '=', {'useregister': 0})
onoremap <Plug>(masquerade-=) =
nnoremap <silent><expr> <Plug>(masquerade-<) masquerade#edit('n', '<', {'usecount': 1, 'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade-<) masquerade#edit('x', '<', {'usecount': 1, 'useregister': 0})
onoremap <Plug>(masquerade-<) <
nnoremap <silent><expr> <Plug>(masquerade->) masquerade#edit('n', '>', {'usecount': 1, 'useregister': 0})
xnoremap <silent><expr> <Plug>(masquerade->) masquerade#edit('x', '>', {'usecount': 1, 'useregister': 0})
onoremap <Plug>(masquerade->) >
nnoremap <silent><expr> <Plug>(masquerade-y) masquerade#y('n', 'y')
xnoremap <silent><expr> <Plug>(masquerade-y) masquerade#y('x', 'y')
onoremap <Plug>(masquerade-y) y
nnoremap <silent><expr> <Plug>(masquerade-Y) masquerade#y('n', 'Y', {'keepunedited': 1})
xnoremap <silent><expr> <Plug>(masquerade-Y) masquerade#y('x', 'Y', {'keepunedited': 1})
nnoremap <silent><expr> <Plug>(masquerade-d) masquerade#d('n', 'd')
xnoremap <silent><expr> <Plug>(masquerade-d) masquerade#d('x', 'd')
onoremap <Plug>(masquerade-d) d
nnoremap <silent><expr> <Plug>(masquerade-D) masquerade#d('n', 'D', {'keepunedited': 1})
xnoremap <silent><expr> <Plug>(masquerade-D) masquerade#d('x', 'D', {'keepunedited': 1})
onoremap <Plug>(masquerade-D) D
nnoremap <silent><expr> <Plug>(masquerade-x) masquerade#d('n', 'x')
xnoremap <silent><expr> <Plug>(masquerade-x) masquerade#d('x', 'x')
onoremap <Plug>(masquerade-x) x
nnoremap <silent><expr> <Plug>(masquerade-X) masquerade#d('n', 'X', {'keepunedited': 1})
xnoremap <silent><expr> <Plug>(masquerade-X) masquerade#d('x', 'X', {'keepunedited': 1})
onoremap <Plug>(masquerade-X) X
nnoremap <silent><expr> <Plug>(masquerade-!) masquerade#exclamation('n', '!')
xnoremap <silent><expr> <Plug>(masquerade-!) masquerade#exclamation('x', '!')
onoremap <Plug>(masquerade-!) !
nnoremap <silent><expr> <Plug>(masquerade-p) masquerade#p('n', 'p')
xnoremap <silent><expr> <Plug>(masquerade-p) masquerade#p('x', 'p')
nnoremap <silent><expr> <Plug>(masquerade-P) masquerade#p('n', 'P')
xnoremap <silent><expr> <Plug>(masquerade-P) masquerade#p('x', 'P')
nnoremap <silent><expr> <Plug>(masquerade-gp) masquerade#p('n', 'gp')
xnoremap <silent><expr> <Plug>(masquerade-gp) masquerade#p('x', 'gp')
nnoremap <silent><expr> <Plug>(masquerade-gP) masquerade#p('n', 'gP')
xnoremap <silent><expr> <Plug>(masquerade-gP) masquerade#p('x', 'gP')
nnoremap <silent> <Plug>(masquerade-i) :<C-u>call masquerade#i('n', 'i')<CR>
xnoremap <silent> <Plug>(masquerade-i) <Esc>:call masquerade#i('x', 'i')<CR>
nnoremap <silent> <Plug>(masquerade-a) :<C-u>call masquerade#a('n', 'a')<CR>
xnoremap <silent> <Plug>(masquerade-a) <Esc>:call masquerade#a('x', 'a')<CR>
nnoremap <silent> <Plug>(masquerade-c) :<C-u>call masquerade#c('n', 'c')<CR>
xnoremap <silent> <Plug>(masquerade-c) <Esc>:call masquerade#c('x', 'c')<CR>
nnoremap <silent> <Plug>(masquerade-C) :<C-u>call masquerade#c('n', 'C', {'keepunedited': 1})<CR>
xnoremap <silent> <Plug>(masquerade-C) <Esc>:call masquerade#c('x', 'C', {'keepunedited': 1})<CR>
nnoremap <silent> <Plug>(masquerade-s) :<C-u>call masquerade#c('n', 's')<CR>
xnoremap <silent> <Plug>(masquerade-s) <Esc>:call masquerade#c('x', 's')<CR>
nnoremap <silent> <Plug>(masquerade-S) :<C-u>call masquerade#c('n', 'S', {'keepunedited': 1})<CR>
xnoremap <silent> <Plug>(masquerade-S) <Esc>:call masquerade#c('x', 'S', {'keepunedited': 1})<CR>
onoremap <Plug>(masquerade-c) c
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set noet ts=4 sw=4 sts=4:
