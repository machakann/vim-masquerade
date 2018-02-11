" masquerade.vim : Tools to edit multiple selections
" Maintainer : Masaaki Nakamura <https://github.com/machakann>
if &compatible || exists("g:loaded_masquerade")
  finish
endif
let g:loaded_masquerade = 1

nnoremap <expr> <SID>(capture) masquerade#capture()
xnoremap <expr> <SID>(capture) masquerade#capture()
onoremap <expr> <SID>(capture) ''

" NOTE: 'noremap <unique> <Plug>(masquerade-fallback-Y) Y'
"       does not define the keymapping in visual mode if user set:
"       'nmap <Plug>(masquerade-fallback-Y) y$'
silent! nnoremap <unique> <Plug>(masquerade-fallback-g~) g~
silent! xnoremap <unique> <Plug>(masquerade-fallback-g~) g~
silent! onoremap <unique> <Plug>(masquerade-fallback-g~) g~
silent! nnoremap <unique> <Plug>(masquerade-fallback-~) ~
silent! xnoremap <unique> <Plug>(masquerade-fallback-~) ~
silent! nnoremap <unique> <Plug>(masquerade-fallback-gu) gu
silent! xnoremap <unique> <Plug>(masquerade-fallback-gu) gu
silent! onoremap <unique> <Plug>(masquerade-fallback-gu) gu
silent! nnoremap <unique> <Plug>(masquerade-fallback-gU) gU
silent! xnoremap <unique> <Plug>(masquerade-fallback-gU) gU
silent! onoremap <unique> <Plug>(masquerade-fallback-gU) gU
silent! nnoremap <unique> <Plug>(masquerade-fallback-g?) g?
silent! xnoremap <unique> <Plug>(masquerade-fallback-g?) g?
silent! onoremap <unique> <Plug>(masquerade-fallback-g?) g?
silent! nnoremap <unique> <Plug>(masquerade-fallback-gq) gq
silent! xnoremap <unique> <Plug>(masquerade-fallback-gq) gq
silent! onoremap <unique> <Plug>(masquerade-fallback-gq) gq
silent! nnoremap <unique> <Plug>(masquerade-fallback-gw) gw
silent! xnoremap <unique> <Plug>(masquerade-fallback-gw) gw
silent! onoremap <unique> <Plug>(masquerade-fallback-gw) gw
silent! nnoremap <unique> <Plug>(masquerade-fallback-=) =
silent! xnoremap <unique> <Plug>(masquerade-fallback-=) =
silent! onoremap <unique> <Plug>(masquerade-fallback-=) =
silent! nnoremap <unique> <Plug>(masquerade-fallback-<) <
silent! xnoremap <unique> <Plug>(masquerade-fallback-<) <
silent! onoremap <unique> <Plug>(masquerade-fallback-<) <
silent! nnoremap <unique> <Plug>(masquerade-fallback->) >
silent! xnoremap <unique> <Plug>(masquerade-fallback->) >
silent! onoremap <unique> <Plug>(masquerade-fallback->) >
silent! nnoremap <unique> <Plug>(masquerade-fallback-y) y
silent! xnoremap <unique> <Plug>(masquerade-fallback-y) y
silent! onoremap <unique> <Plug>(masquerade-fallback-y) y
silent! nnoremap <unique> <Plug>(masquerade-fallback-Y) Y
silent! xnoremap <unique> <Plug>(masquerade-fallback-Y) Y
silent! nnoremap <unique> <Plug>(masquerade-fallback-d) d
silent! xnoremap <unique> <Plug>(masquerade-fallback-d) d
silent! onoremap <unique> <Plug>(masquerade-fallback-d) d
silent! nnoremap <unique> <Plug>(masquerade-fallback-D) D
silent! xnoremap <unique> <Plug>(masquerade-fallback-D) D
silent! nnoremap <unique> <Plug>(masquerade-fallback-x) x
silent! xnoremap <unique> <Plug>(masquerade-fallback-x) x
silent! nnoremap <unique> <Plug>(masquerade-fallback-X) X
silent! xnoremap <unique> <Plug>(masquerade-fallback-X) X
silent! nnoremap <unique> <Plug>(masquerade-fallback-!) !
silent! xnoremap <unique> <Plug>(masquerade-fallback-!) !
silent! onoremap <unique> <Plug>(masquerade-fallback-!) !
silent! nnoremap <unique> <Plug>(masquerade-fallback-p) p
silent! xnoremap <unique> <Plug>(masquerade-fallback-p) p
silent! nnoremap <unique> <Plug>(masquerade-fallback-P) P
silent! xnoremap <unique> <Plug>(masquerade-fallback-P) P
silent! nnoremap <unique> <Plug>(masquerade-fallback-gp) gp
silent! xnoremap <unique> <Plug>(masquerade-fallback-gp) gp
silent! nnoremap <unique> <Plug>(masquerade-fallback-gP) gP
silent! xnoremap <unique> <Plug>(masquerade-fallback-gP) gP
silent! nnoremap <unique> <Plug>(masquerade-fallback-i) i
silent! xnoremap <unique> <Plug>(masquerade-fallback-i) i
silent! nnoremap <unique> <Plug>(masquerade-fallback-I) I
silent! xnoremap <unique> <Plug>(masquerade-fallback-I) I
silent! nnoremap <unique> <Plug>(masquerade-fallback-a) a
silent! xnoremap <unique> <Plug>(masquerade-fallback-a) a
silent! nnoremap <unique> <Plug>(masquerade-fallback-A) A
silent! xnoremap <unique> <Plug>(masquerade-fallback-A) A
silent! nnoremap <unique> <Plug>(masquerade-fallback-c) c
silent! xnoremap <unique> <Plug>(masquerade-fallback-c) c
silent! onoremap <unique> <Plug>(masquerade-fallback-c) c
silent! nnoremap <unique> <Plug>(masquerade-fallback-C) C
silent! xnoremap <unique> <Plug>(masquerade-fallback-C) C
silent! nnoremap <unique> <Plug>(masquerade-fallback-s) s
silent! xnoremap <unique> <Plug>(masquerade-fallback-s) s
silent! nnoremap <unique> <Plug>(masquerade-fallback-S) S
silent! xnoremap <unique> <Plug>(masquerade-fallback-S) S

nnoremap <silent> <SID>(masquerade-g~) :<C-u>call masquerade#edit('n', 'g~', {'fallback': "\<Plug>(masquerade-fallback-g~)", 'remapfallback': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-g~) :<C-u>call masquerade#edit('x', 'g~', {'fallback': "\<Plug>(masquerade-fallback-g~)", 'remapfallback': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-g~) g~
nnoremap <silent> <SID>(masquerade-~) :<C-u>call masquerade#edit('n', '~', {'fallback': "\<Plug>(masquerade-fallback-~)", 'remapfallback': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-~) :<C-u>call masquerade#edit('x', '~', {'fallback': "\<Plug>(masquerade-fallback-~)", 'remapfallback': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-~) ~
nnoremap <silent> <SID>(masquerade-gu) :<C-u>call masquerade#edit('n', 'gu', {'fallback': "\<Plug>(masquerade-fallback-gu)", 'remapfallback': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-gu) :<C-u>call masquerade#edit('x', 'gu', {'fallback': "\<Plug>(masquerade-fallback-gu)", 'remapfallback': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-gu) gu
nnoremap <silent> <SID>(masquerade-gU) :<C-u>call masquerade#edit('n', 'gU', {'fallback': "\<Plug>(masquerade-fallback-gU)", 'remapfallback': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-gU) :<C-u>call masquerade#edit('x', 'gU', {'fallback': "\<Plug>(masquerade-fallback-gU)", 'remapfallback': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-gU) gU
nnoremap <silent> <SID>(masquerade-g?) :<C-u>call masquerade#edit('n', 'g?', {'fallback': "\<Plug>(masquerade-fallback-g?)", 'remapfallback': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-g?) :<C-u>call masquerade#edit('x', 'g?', {'fallback': "\<Plug>(masquerade-fallback-g?)", 'remapfallback': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-g?) g?
nnoremap <silent> <SID>(masquerade-gq) :<C-u>call masquerade#edit('n', 'gq', {'fallback': "\<Plug>(masquerade-fallback-gq)", 'remapfallback': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-gq) :<C-u>call masquerade#edit('x', 'gq', {'fallback': "\<Plug>(masquerade-fallback-gq)", 'remapfallback': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-gq) gq
nnoremap <silent> <SID>(masquerade-gw) :<C-u>call masquerade#edit('n', 'gw', {'fallback': "\<Plug>(masquerade-fallback-gw)", 'remapfallback': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-gw) :<C-u>call masquerade#edit('x', 'gw', {'fallback': "\<Plug>(masquerade-fallback-gw)", 'remapfallback': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-gw) gw
nnoremap <silent> <SID>(masquerade-=) :<C-u>call masquerade#edit('n', '=', {'fallback': "\<Plug>(masquerade-fallback-=)", 'remapfallback': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-=) :<C-u>call masquerade#edit('x', '=', {'fallback': "\<Plug>(masquerade-fallback-=)", 'remapfallback': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-=) =
nnoremap <silent> <SID>(masquerade-<) :<C-u>call masquerade#edit('n', '<', {'fallback': "\<Plug>(masquerade-fallback-<)", 'remapfallback': 1, 'usecount': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade-<) :<C-u>call masquerade#edit('x', '<', {'fallback': "\<Plug>(masquerade-fallback-<)", 'remapfallback': 1, 'usecount': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade-<) <
nnoremap <silent> <SID>(masquerade->) :<C-u>call masquerade#edit('n', '>', {'fallback': "\<Plug>(masquerade-fallback->)", 'remapfallback': 1, 'usecount': 1, 'useregister': 0})<CR>
xnoremap <silent> <SID>(masquerade->) :<C-u>call masquerade#edit('x', '>', {'fallback': "\<Plug>(masquerade-fallback->)", 'remapfallback': 1, 'usecount': 1, 'useregister': 0})<CR>
onoremap <SID>(masquerade->) >
nnoremap <silent> <SID>(masquerade-y) :<C-u>call masquerade#y('n', 'y', {'fallback': "\<Plug>(masquerade-fallback-y)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-y) :<C-u>call masquerade#y('x', 'y', {'fallback': "\<Plug>(masquerade-fallback-y)", 'remapfallback': 1})<CR>
onoremap <SID>(masquerade-y) y
nnoremap <silent> <SID>(masquerade-Y) :<C-u>call masquerade#y('n', 'Y', {'fallback': "\<Plug>(masquerade-fallback-Y)", 'remapfallback': 1, 'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-Y) :<C-u>call masquerade#y('x', 'Y', {'fallback': "\<Plug>(masquerade-fallback-Y)", 'remapfallback': 1, 'keepunedited': 1})<CR>
nnoremap <silent> <SID>(masquerade-d) :<C-u>call masquerade#d('n', 'd', {'fallback': "\<Plug>(masquerade-fallback-d)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-d) :<C-u>call masquerade#d('x', 'd', {'fallback': "\<Plug>(masquerade-fallback-d)", 'remapfallback': 1})<CR>
onoremap <SID>(masquerade-d) d
nnoremap <silent> <SID>(masquerade-D) :<C-u>call masquerade#d('n', 'D', {'fallback': "\<Plug>(masquerade-fallback-D)", 'remapfallback': 1, 'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-D) :<C-u>call masquerade#d('x', 'D', {'fallback': "\<Plug>(masquerade-fallback-D)", 'remapfallback': 1, 'keepunedited': 1})<CR>
nnoremap <silent> <SID>(masquerade-x) :<C-u>call masquerade#d('n', 'x', {'fallback': "\<Plug>(masquerade-fallback-x)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-x) :<C-u>call masquerade#d('x', 'x', {'fallback': "\<Plug>(masquerade-fallback-x)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-X) :<C-u>call masquerade#d('n', 'X', {'fallback': "\<Plug>(masquerade-fallback-X)", 'remapfallback': 1, 'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-X) :<C-u>call masquerade#d('x', 'X', {'fallback': "\<Plug>(masquerade-fallback-X)", 'remapfallback': 1, 'keepunedited': 1})<CR>
nnoremap <silent> <SID>(masquerade-!) :<C-u>call masquerade#exclamation('n', '!', {'fallback': "\<Plug>(masquerade-fallback-!)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-!) :<C-u>call masquerade#exclamation('x', '!', {'fallback': "\<Plug>(masquerade-fallback-!)", 'remapfallback': 1})<CR>
onoremap <SID>(masquerade-!) !
nnoremap <silent> <SID>(masquerade-p) :<C-u>call masquerade#p('n', 'p', {'fallback': "\<Plug>(masquerade-fallback-p)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-p) :<C-u>call masquerade#p('x', 'p', {'fallback': "\<Plug>(masquerade-fallback-p)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-P) :<C-u>call masquerade#p('n', 'P', {'fallback': "\<Plug>(masquerade-fallback-P)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-P) :<C-u>call masquerade#p('x', 'P', {'fallback': "\<Plug>(masquerade-fallback-P)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-gp) :<C-u>call masquerade#p('n', 'gp', {'fallback': "\<Plug>(masquerade-fallback-gp)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-gp) :<C-u>call masquerade#p('x', 'gp', {'fallback': "\<Plug>(masquerade-fallback-gp)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-gP) :<C-u>call masquerade#p('n', 'gP', {'fallback': "\<Plug>(masquerade-fallback-gP)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-gP) :<C-u>call masquerade#p('x', 'gP', {'fallback': "\<Plug>(masquerade-fallback-gP)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-i) :<C-u>call masquerade#i('n', 'i', {'fallback': "\<Plug>(masquerade-fallback-i)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-i) :<C-u>call masquerade#i('x', 'i', {'fallback': "\<Plug>(masquerade-fallback-i)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-I) :<C-u>call masquerade#i('n', 'i', {'fallback': "\<Plug>(masquerade-fallback-I)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-I) :<C-u>call masquerade#i('x', 'i', {'fallback': "\<Plug>(masquerade-fallback-I)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-a) :<C-u>call masquerade#a('n', 'a', {'fallback': "\<Plug>(masquerade-fallback-a)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-a) :<C-u>call masquerade#a('x', 'a', {'fallback': "\<Plug>(masquerade-fallback-a)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-A) :<C-u>call masquerade#a('n', 'a', {'fallback': "\<Plug>(masquerade-fallback-A)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-A) :<C-u>call masquerade#a('x', 'a', {'fallback': "\<Plug>(masquerade-fallback-A)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-c) :<C-u>call masquerade#c('n', 'c', {'fallback': "\<Plug>(masquerade-fallback-c)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-c) :<C-u>call masquerade#c('x', 'c', {'fallback': "\<Plug>(masquerade-fallback-c)", 'remapfallback': 1})<CR>
onoremap <SID>(masquerade-c) c
nnoremap <silent> <SID>(masquerade-C) :<C-u>call masquerade#c('n', 'C', {'fallback': "\<Plug>(masquerade-fallback-C)", 'remapfallback': 1, 'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-C) :<C-u>call masquerade#c('x', 'C', {'fallback': "\<Plug>(masquerade-fallback-C)", 'remapfallback': 1, 'keepunedited': 1})<CR>
nnoremap <silent> <SID>(masquerade-s) :<C-u>call masquerade#c('n', 's', {'fallback': "\<Plug>(masquerade-fallback-s)", 'remapfallback': 1})<CR>
xnoremap <silent> <SID>(masquerade-s) :<C-u>call masquerade#c('x', 's', {'fallback': "\<Plug>(masquerade-fallback-s)", 'remapfallback': 1})<CR>
nnoremap <silent> <SID>(masquerade-S) :<C-u>call masquerade#c('n', 'S', {'fallback': "\<Plug>(masquerade-fallback-S)", 'remapfallback': 1, 'keepunedited': 1})<CR>
xnoremap <silent> <SID>(masquerade-S) :<C-u>call masquerade#c('x', 'S', {'fallback': "\<Plug>(masquerade-fallback-S)", 'remapfallback': 1, 'keepunedited': 1})<CR>

function! s:defaultoperators() abort "{{{
	map <Plug>(masquerade-g~) <Plug>(masquerade-fallback-g~)
	map <Plug>(masquerade-~) <Plug>(masquerade-fallback-~)
	map <Plug>(masquerade-gu) <Plug>(masquerade-fallback-gu)
	map <Plug>(masquerade-gU) <Plug>(masquerade-fallback-gU)
	map <Plug>(masquerade-g?) <Plug>(masquerade-fallback-g?)
	map <Plug>(masquerade-gq) <Plug>(masquerade-fallback-gq)
	map <Plug>(masquerade-gw) <Plug>(masquerade-fallback-gw)
	map <Plug>(masquerade-=) <Plug>(masquerade-fallback-=)
	map <Plug>(masquerade-<) <Plug>(masquerade-fallback-<)
	map <Plug>(masquerade->) <Plug>(masquerade-fallback->)
	map <Plug>(masquerade-y) <Plug>(masquerade-fallback-y)
	map <Plug>(masquerade-Y) <Plug>(masquerade-fallback-Y)
	map <Plug>(masquerade-d) <Plug>(masquerade-fallback-d)
	map <Plug>(masquerade-D) <Plug>(masquerade-fallback-D)
	map <Plug>(masquerade-x) <Plug>(masquerade-fallback-x)
	map <Plug>(masquerade-X) <Plug>(masquerade-fallback-X)
	map <Plug>(masquerade-!) <Plug>(masquerade-fallback-!)
	map <Plug>(masquerade-p) <Plug>(masquerade-fallback-p)
	map <Plug>(masquerade-P) <Plug>(masquerade-fallback-P)
	map <Plug>(masquerade-gp) <Plug>(masquerade-fallback-gp)
	map <Plug>(masquerade-gP) <Plug>(masquerade-fallback-gP)
	map <Plug>(masquerade-i) <Plug>(masquerade-fallback-i)
	map <Plug>(masquerade-I) <Plug>(masquerade-fallback-I)
	map <Plug>(masquerade-a) <Plug>(masquerade-fallback-a)
	map <Plug>(masquerade-A) <Plug>(masquerade-fallback-A)
	map <Plug>(masquerade-c) <Plug>(masquerade-fallback-c)
	map <Plug>(masquerade-C) <Plug>(masquerade-fallback-C)
	map <Plug>(masquerade-s) <Plug>(masquerade-fallback-s)
	map <Plug>(masquerade-S) <Plug>(masquerade-fallback-S)
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
