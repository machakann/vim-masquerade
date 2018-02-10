" masquerade.vim : Tools to edit multiple selections
" Maintainer : Masaaki Nakamura <https://github.com/machakann>
if &compatible || exists("g:loaded_masquerade")
  finish
endif
let g:loaded_masquerade = 1

nnoremap <expr> <SID>(capture) masquerade#capture()
xnoremap <expr> <SID>(capture) masquerade#capture()
onoremap <expr> <SID>(capture) ''

nnoremap <silent> <SID>(masquerade-g~) :<C-u>call masquerade#edit('n', 'g~', {'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-g~) :<C-u>call masquerade#edit('x', 'g~', {'useregister': 0})<CR>
onoremap <SID>(masquerade-g~) g~
nnoremap <silent> <SID>(masquerade-~) :<C-u>call masquerade#edit('n', '~', {'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-~) :<C-u>call masquerade#edit('x', '~', {'useregister': 0})<CR>
onoremap <SID>(masquerade-~) ~
nnoremap <silent> <SID>(masquerade-gu) :<C-u>call masquerade#edit('n', 'gu', {'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-gu) :<C-u>call masquerade#edit('x', 'gu', {'useregister': 0})<CR>
onoremap <SID>(masquerade-gu) gu
nnoremap <silent> <SID>(masquerade-gU) :<C-u>call masquerade#edit('n', 'gU', {'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-gU) :<C-u>call masquerade#edit('x', 'gU', {'useregister': 0})<CR>
onoremap <SID>(masquerade-gU) gU
nnoremap <silent> <SID>(masquerade-g?) :<C-u>call masquerade#edit('n', 'g?', {'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-g?) :<C-u>call masquerade#edit('x', 'g?', {'useregister': 0})<CR>
onoremap <SID>(masquerade-g?) g?
nnoremap <silent> <SID>(masquerade-gq) :<C-u>call masquerade#edit('n', 'gq', {'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-gq) :<C-u>call masquerade#edit('x', 'gq', {'useregister': 0})<CR>
onoremap <SID>(masquerade-gq) gq
nnoremap <silent> <SID>(masquerade-gw) :<C-u>call masquerade#edit('n', 'gw', {'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-gw) :<C-u>call masquerade#edit('x', 'gw', {'useregister': 0})<CR>
onoremap <SID>(masquerade-gw) gw
nnoremap <silent> <SID>(masquerade-=) :<C-u>call masquerade#edit('n', '=', {'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-=) :<C-u>call masquerade#edit('x', '=', {'useregister': 0})<CR>
onoremap <SID>(masquerade-=) =
nnoremap <silent> <SID>(masquerade-<) :<C-u>call masquerade#edit('n', '<', {'usecount': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-<) :<C-u>call masquerade#edit('x', '<', {'usecount': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-<) <
nnoremap <silent> <SID>(masquerade->) :<C-u>call masquerade#edit('n', '>', {'usecount': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade->) :<C-u>call masquerade#edit('x', '>', {'usecount': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade->) >
nnoremap <silent> <SID>(masquerade-y) :<C-u>call masquerade#y('n', 'y')<CR>
xnoremap <silent> <SID>(masquerade-y) :<C-u>call masquerade#y('x', 'y')<CR>
onoremap <SID>(masquerade-y) y
nnoremap <silent> <SID>(masquerade-Y) :<C-u>call masquerade#y('n', 'Y', {'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-Y) :<C-u>call masquerade#y('x', 'Y', {'keepunedited': 1})<CR>
nnoremap <silent> <SID>(masquerade-d) :<C-u>call masquerade#d('n', 'd')<CR>
xnoremap <silent> <SID>(masquerade-d) :<C-u>call masquerade#d('x', 'd')<CR>
onoremap <SID>(masquerade-d) d
nnoremap <silent> <SID>(masquerade-D) :<C-u>call masquerade#d('n', 'D', {'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-D) :<C-u>call masquerade#d('x', 'D', {'keepunedited': 1})<CR>
nnoremap <silent> <SID>(masquerade-x) :<C-u>call masquerade#d('n', 'x')<CR>
xnoremap <silent> <SID>(masquerade-x) :<C-u>call masquerade#d('x', 'x')<CR>
nnoremap <silent> <SID>(masquerade-X) :<C-u>call masquerade#d('n', 'X', {'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-X) :<C-u>call masquerade#d('x', 'X', {'keepunedited': 1})<CR>
nnoremap <silent> <SID>(masquerade-!) :<C-u>call masquerade#exclamation('n', '!')<CR>
xnoremap <silent> <SID>(masquerade-!) :<C-u>call masquerade#exclamation('x', '!')<CR>
onoremap <SID>(masquerade-!) !
nnoremap <silent> <SID>(masquerade-p) :<C-u>call masquerade#p('n', 'p')<CR>
xnoremap <silent> <SID>(masquerade-p) :<C-u>call masquerade#p('x', 'p')<CR>
nnoremap <silent> <SID>(masquerade-P) :<C-u>call masquerade#p('n', 'P')<CR>
xnoremap <silent> <SID>(masquerade-P) :<C-u>call masquerade#p('x', 'P')<CR>
nnoremap <silent> <SID>(masquerade-gp) :<C-u>call masquerade#p('n', 'gp')<CR>
xnoremap <silent> <SID>(masquerade-gp) :<C-u>call masquerade#p('x', 'gp')<CR>
nnoremap <silent> <SID>(masquerade-gP) :<C-u>call masquerade#p('n', 'gP')<CR>
xnoremap <silent> <SID>(masquerade-gP) :<C-u>call masquerade#p('x', 'gP')<CR>
nnoremap <silent> <SID>(masquerade-i) :<C-u>call masquerade#i('n', 'i')<CR>
xnoremap <silent> <SID>(masquerade-i) :<C-u>call masquerade#i('x', 'i')<CR>
nnoremap <silent> <SID>(masquerade-I) :<C-u>call masquerade#i('n', 'i', {'fallback': 'I'})<CR>
xnoremap <silent> <SID>(masquerade-I) :<C-u>call masquerade#i('x', 'i', {'fallback': 'I'})<CR>
nnoremap <silent> <SID>(masquerade-a) :<C-u>call masquerade#a('n', 'a')<CR>
xnoremap <silent> <SID>(masquerade-a) :<C-u>call masquerade#a('x', 'a')<CR>
nnoremap <silent> <SID>(masquerade-A) :<C-u>call masquerade#a('n', 'a', {'fallback': 'A'})<CR>
xnoremap <silent> <SID>(masquerade-A) :<C-u>call masquerade#a('x', 'a', {'fallback': 'A'})<CR>
nnoremap <silent> <SID>(masquerade-c) :<C-u>call masquerade#c('n', 'c')<CR>
xnoremap <silent> <SID>(masquerade-c) :<C-u>call masquerade#c('x', 'c')<CR>
onoremap <SID>(masquerade-c) c
nnoremap <silent> <SID>(masquerade-C) :<C-u>call masquerade#c('n', 'C', {'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-C) :<C-u>call masquerade#c('x', 'C', {'keepunedited': 1})<CR>
nnoremap <silent> <SID>(masquerade-s) :<C-u>call masquerade#c('n', 's')<CR>
xnoremap <silent> <SID>(masquerade-s) :<C-u>call masquerade#c('x', 's')<CR>
nnoremap <silent> <SID>(masquerade-S) :<C-u>call masquerade#c('n', 'S', {'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-S) :<C-u>call masquerade#c('x', 'S', {'keepunedited': 1})<CR>

function! s:defaultoperators() abort "{{{
	noremap <Plug>(masquerade-g~) g~
	noremap <Plug>(masquerade-~) ~
	noremap <Plug>(masquerade-gu) gu
	noremap <Plug>(masquerade-gU) gU
	noremap <Plug>(masquerade-g?) g?
	noremap <Plug>(masquerade-gq) gq
	noremap <Plug>(masquerade-gw) gw
	noremap <Plug>(masquerade-=) =
	noremap <Plug>(masquerade-<) <
	noremap <Plug>(masquerade->) >
	noremap <Plug>(masquerade-y) y
	noremap <Plug>(masquerade-Y) Y
	noremap <Plug>(masquerade-d) d
	noremap <Plug>(masquerade-D) D
	noremap <Plug>(masquerade-x) x
	noremap <Plug>(masquerade-X) X
	noremap <Plug>(masquerade-!) !
	noremap <Plug>(masquerade-p) p
	noremap <Plug>(masquerade-P) P
	noremap <Plug>(masquerade-gp) gp
	noremap <Plug>(masquerade-gP) gP
	noremap <Plug>(masquerade-i) i
	noremap <Plug>(masquerade-I) I
	noremap <Plug>(masquerade-a) a
	noremap <Plug>(masquerade-A) A
	noremap <Plug>(masquerade-c) c
	noremap <Plug>(masquerade-C) C
	noremap <Plug>(masquerade-s) s
	noremap <Plug>(masquerade-S) S
endfunction "}}}

function! s:readyformultiselect() abort "{{{
	map  <Plug>(masquerade-g~) <SID>(capture)<SID>(masquerade-g~)
	map  <Plug>(masquerade-~)  <SID>(capture)<SID>(masquerade-~)
	map  <Plug>(masquerade-gu) <SID>(capture)<SID>(masquerade-gu)
	map  <Plug>(masquerade-gU) <SID>(capture)<SID>(masquerade-gU)
	map  <Plug>(masquerade-g?) <SID>(capture)<SID>(masquerade-g?)
	map  <Plug>(masquerade-gq) <SID>(capture)<SID>(masquerade-gq)
	map  <Plug>(masquerade-gw) <SID>(capture)<SID>(masquerade-gw)
	map  <Plug>(masquerade-=)  <SID>(capture)<SID>(masquerade-=)
	map  <Plug>(masquerade-<)  <SID>(capture)<SID>(masquerade-<)
	map  <Plug>(masquerade->)  <SID>(capture)<SID>(masquerade->)
	map  <Plug>(masquerade-y)  <SID>(capture)<SID>(masquerade-y)
	nmap <Plug>(masquerade-Y)  <SID>(capture)<SID>(masquerade-Y)
	xmap <Plug>(masquerade-Y)  <SID>(capture)<SID>(masquerade-Y)
	map  <Plug>(masquerade-d)  <SID>(capture)<SID>(masquerade-d)
	nmap <Plug>(masquerade-D)  <SID>(capture)<SID>(masquerade-D)
	xmap <Plug>(masquerade-D)  <SID>(capture)<SID>(masquerade-D)
	nmap <Plug>(masquerade-x)  <SID>(capture)<SID>(masquerade-x)
	xmap <Plug>(masquerade-x)  <SID>(capture)<SID>(masquerade-x)
	nmap <Plug>(masquerade-X)  <SID>(capture)<SID>(masquerade-X)
	xmap <Plug>(masquerade-X)  <SID>(capture)<SID>(masquerade-X)
	map  <Plug>(masquerade-!)  <SID>(capture)<SID>(masquerade-!)
	nmap <Plug>(masquerade-p)  <SID>(capture)<SID>(masquerade-p)
	xmap <Plug>(masquerade-p)  <SID>(capture)<SID>(masquerade-p)
	nmap <Plug>(masquerade-P)  <SID>(capture)<SID>(masquerade-P)
	xmap <Plug>(masquerade-P)  <SID>(capture)<SID>(masquerade-P)
	nmap <Plug>(masquerade-gp) <SID>(capture)<SID>(masquerade-gp)
	xmap <Plug>(masquerade-gp) <SID>(capture)<SID>(masquerade-gp)
	nmap <Plug>(masquerade-gP) <SID>(capture)<SID>(masquerade-gP)
	xmap <Plug>(masquerade-gP) <SID>(capture)<SID>(masquerade-gP)
	nmap <Plug>(masquerade-i)  <SID>(capture)<SID>(masquerade-i)
	xmap <Plug>(masquerade-i)  <SID>(capture)<SID>(masquerade-i)
	nmap <Plug>(masquerade-I)  <SID>(capture)<SID>(masquerade-I)
	xmap <Plug>(masquerade-I)  <SID>(capture)<SID>(masquerade-I)
	nmap <Plug>(masquerade-a)  <SID>(capture)<SID>(masquerade-a)
	xmap <Plug>(masquerade-a)  <SID>(capture)<SID>(masquerade-a)
	nmap <Plug>(masquerade-A)  <SID>(capture)<SID>(masquerade-A)
	xmap <Plug>(masquerade-A)  <SID>(capture)<SID>(masquerade-A)
	map  <Plug>(masquerade-c)  <SID>(capture)<SID>(masquerade-c)
	nmap <Plug>(masquerade-C)  <SID>(capture)<SID>(masquerade-C)
	xmap <Plug>(masquerade-C)  <SID>(capture)<SID>(masquerade-C)
	nmap <Plug>(masquerade-s)  <SID>(capture)<SID>(masquerade-s)
	xmap <Plug>(masquerade-s)  <SID>(capture)<SID>(masquerade-s)
	nmap <Plug>(masquerade-S)  <SID>(capture)<SID>(masquerade-S)
	xmap <Plug>(masquerade-S)  <SID>(capture)<SID>(masquerade-S)
endfunction "}}}

if exists('*multiselect#import')
	call s:readyformultiselect()
else
	call s:defaultoperators()

	augroup masquerade-keymapping
		autocmd!
		autocmd User MultiselectEnter call s:readyformultiselect()
	augroup END
endif

command! -nargs=0 MasqueradeOff call s:defaultoperators()
command! -nargs=0 MasqueradeOn  call s:readyformultiselect()
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set noet ts=4 sw=4 sts=4:
