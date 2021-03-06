function! s:inherit(sub, super, ...) abort "{{{
	if a:0 == 0
		return s:_inherit(a:sub, a:super)
	endif
	let super = a:000[-1]
	let itemlist = [a:super] + a:000[:-2]
	for item in reverse(itemlist)
		let super = s:_inherit(item, super)
	endfor
	return s:_inherit(a:sub, super)
endfunction "}}}

function! s:super(sub, ...) abort "{{{
	if !has_key(a:sub, '__SUPER__')
		return {}
	endif

	let supername = get(a:000, 0, a:sub.__SUPER__.__CLASS__)
	let supermethods = a:sub
	try
		while supermethods.__CLASS__ isnot# supername
			let supermethods = supermethods.__SUPER__
		endwhile
	catch /^Vim\%((\a\+)\)\=:E716/
		echoerr printf('%s class does not have the super class named %s', a:sub.__CLASS__, supername)
	endtry

	let super = {}
	for [key, l:Val] in items(supermethods)
		if type(l:Val) is v:t_func
			let super[key] = function('s:_supercall', [a:sub, l:Val])
		endif
	endfor
	return super
endfunction "}}}

function! s:supercall(sub, supername, funcname) abort "{{{
	if !has_key(a:sub, '__SUPER__')
		return
	endif

	let supermethods = a:sub
	try
		while supermethods.__CLASS__ isnot# a:supername
			let supermethods = supermethods.__SUPER__
		endwhile
	catch /^Vim\%((\a\+)\)\=:E716/
		echoerr printf('%s class does not have the super class named %s', a:sub.__CLASS__, a:supername)
	endtry

	let args = get(a:000, 0, [])
	return s:_supercall(supermethods[a:funcname], args, a:sub)
endfunction "}}}

function! s:_inherit(sub, super) abort "{{{
	call extend(a:sub, a:super, 'keep')
	let a:sub.__SUPER__ = {}
	let a:sub.__SUPER__.__CLASS__ = a:super.__CLASS__
	for [key, l:Val] in items(a:super)
		if type(l:Val) is v:t_func || key is# '__SUPER__'
			let a:sub.__SUPER__[key] = l:Val
		endif
	endfor
	return a:sub
endfunction "}}}

function! s:_supercall(sub, Funcref, ...) abort "{{{
	return call(a:Funcref, a:000, a:sub)
endfunction "}}}



" ClassSys module {{{
unlockvar! s:ClassSys
let s:ClassSys = {
	\	'__MODULE__': 'ClassSys',
	\	'inherit': function('s:inherit'),
	\	'super': function('s:super'),
	\	}
lockvar! s:ClassSys
"}}}

function! masquerade#ClassSys#_import() abort "{{{
	return s:ClassSys
endfunction "}}}
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set noet ts=4 sw=4 sts=-1:
