" masquerade.vim - Tools to edit multiple selections
let s:TRUE = 1
let s:FALSE = 0

function! s:SID() abort
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID = printf("\<SNR>%s_", s:SID())
delfunction s:SID

noremap <SID>(gv) gv
noremap <SID>(doublequote) "
let s:GV = s:SID . '(gv)'
let s:DOUBLEQUOTE = s:SID . '(doublequote)'

let g:masquerade#keepothers = !!get(g:, 'masquerade#keepothers', s:FALSE)
let g:masquerade#highlight = get(g:, 'masquerade#highlight', 300)

let g:masquerade#__CURRENT__ = {}
let s:OPTIONS = {
	\ 'noremap': s:TRUE,
	\ 'keepothers': g:masquerade#keepothers,
	\ 'highlight': g:masquerade#highlight,
	\ }

function! s:getoptions(args) abort "{{{
	let options = deepcopy(s:OPTIONS)
	call extend(options, get(a:args, 0, {}), 'force')
	return options
endfunction "}}}
function! masquerade#edit(mode, cmd, ...) abort "{{{
	let options = s:getoptions(a:000)
	if !exists('*multiselect#import')
		let fallback = get(options, 'fallback', a:cmd)
		return fallback
	endif
	return masquerade#impl#edit(a:mode, a:cmd, options)
endfunction "}}}
function! masquerade#y(mode, cmd, ...) abort "{{{
	let options = s:getoptions(a:000)
	if !exists('*multiselect#import')
		let fallback = get(options, 'fallback', a:cmd)
		return fallback
	endif
	return masquerade#impl#y(a:mode, a:cmd, options)
endfunction "}}}
function! masquerade#d(mode, cmd, ...) abort "{{{
	let options = s:getoptions(a:000)
	if !exists('*multiselect#import')
		let fallback = get(options, 'fallback', a:cmd)
		return fallback
	endif
	return masquerade#impl#d(a:mode, a:cmd, options)
endfunction "}}}
function! masquerade#exclamation(mode, cmd, ...) abort "{{{
	let options = s:getoptions(a:000)
	if !exists('*multiselect#import')
		let fallback = get(options, 'fallback', a:cmd)
		return fallback
	endif
	return masquerade#impl#exclamation(a:mode, a:cmd, options)
endfunction "}}}
function! masquerade#p(mode, cmd, ...) abort "{{{
	let options = s:getoptions(a:000)
	if !exists('*multiselect#import')
		let fallback = get(options, 'fallback', a:cmd)
		return fallback
	endif
	return masquerade#impl#p(a:mode, a:cmd, options)
endfunction "}}}
function! masquerade#i(mode, cmd, ...) abort "{{{
	let options = s:getoptions(a:000)
	if !exists('*multiselect#import')
		let fallback = get(options, 'fallback', a:cmd)
		if a:mode is# 'x'
			let countstr = v:prevcount ? v:prevcount : ''
		else
			let countstr = v:count ? v:count : ''
		endif
		if options.noremap is s:TRUE
			let flag = 'in'
		else
			let flag = 'im'
		endif
		call feedkeys(printf('%s%s', countstr, fallback), flag)
		return
	endif
	call masquerade#impl#i(a:mode, a:cmd, options)
endfunction "}}}
function! masquerade#a(mode, cmd, ...) abort "{{{
	let options = s:getoptions(a:000)
	if !exists('*multiselect#import')
		let fallback = get(options, 'fallback', a:cmd)
		if a:mode is# 'x'
			let countstr = v:prevcount ? v:prevcount : ''
		else
			let countstr = v:count ? v:count : ''
		endif
		if options.noremap is s:TRUE
			let flag = 'in'
		else
			let flag = 'im'
		endif
		call feedkeys(printf('%s%s', countstr, fallback), flag)
		return
	endif
	call masquerade#impl#a(a:mode, a:cmd, options)
endfunction "}}}
function! masquerade#c(mode, cmd, ...) abort "{{{
	let options = s:getoptions(a:000)
	if !exists('*multiselect#import')
		let fallback = get(options, 'fallback', a:cmd)
		if options.noremap is s:TRUE
			let gv = 'gv'
			let register = '"' . v:register
			let flag = 'in'
		else
			let gv = s:GV
			let register = s:DOUBLEQUOTE . v:register
			let flag = 'im'
		endif
		if a:mode is# 'x'
			let cmd = printf('%s%s%s', gv, register, fallback)
		else
			let countstr = v:count ? v:count : ''
			let cmd = printf('%s%s%s', countstr, register, fallback)
		endif
		call feedkeys(cmd, flag)
		return
	endif
	call masquerade#impl#c(a:mode, a:cmd, options)
endfunction "}}}
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set noet ts=4 sw=4 sts=4:
