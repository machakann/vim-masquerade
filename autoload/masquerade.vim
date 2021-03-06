" masquerade.vim - Tools to edit multiple selections
let s:ClassSys = masquerade#ClassSys#_import()
let s:Multiselect = multiselect#import()
let s:ms = s:Multiselect.load()
let s:shiftenv = s:Multiselect.shiftenv
let s:restoreenv = s:Multiselect.restoreenv
let s:inorderof = s:Multiselect.inorderof
let s:str2type = s:Multiselect.str2type
let s:isextended = s:Multiselect.isextended

let s:TRUE = 1
let s:FALSE = 0
let s:MAXCOL = 2147483647
let s:NULLPOS = [0, 0, 0, 0]
let s:HIDURATION = 300
function! s:SID() abort
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID = printf("\<SNR>%s_", s:SID())
delfunction s:SID
noremap <SID>(gv) gv
noremap <SID>(g@) g@
noremap <SID>(g@l) g@l
noremap <SID>(doublequote) "
let s:GV = s:SID . '(gv)'
let s:GAT = s:SID . '(g@)'
let s:GATL = s:SID . '(g@l)'
let s:DOUBLEQUOTE = s:SID . '(doublequote)'

let g:masquerade#keepothers = !!get(g:, 'masquerade#keepothers', s:FALSE)
let g:masquerade#highlight = get(g:, 'masquerade#highlight', s:HIDURATION)

let g:masquerade#__CURRENT__ = {}
let s:OPERATORFUNC = 'masquerade#operatorfunc'
function! masquerade#operatorfunc(motionwise) abort "{{{
	let [head, tail] = [getpos("'["), getpos("']")]
	if head == s:NULLPOS || tail == s:NULLPOS || s:inorderof(tail, head)
		return
	endif

	let operator = g:masquerade#__CURRENT__
	call operator.update()
	let env = operator.prepare()
	try
		let itemlist = operator.itemlist()
		if !empty(itemlist)
			call operator.execute(itemlist)
		endif
	finally
		call operator.finish(env)
	endtry
endfunction "}}}

let s:count = 0
let s:count1 = 1
let s:register = v:register
let s:curpos = [0, 0, 0, 0]
let s:view = {}
function! masquerade#capture() abort "{{{
	let s:count = v:count
	let s:count1 = v:count1
	let s:register = v:register
	let s:curpos = getpos('.')
	let s:view = {}
	return ''
endfunction "}}}

function! masquerade#edit(mode, cmd, ...) abort "{{{
	let options = {
		\ 'keepothers': g:masquerade#keepothers,
		\ 'highlight': g:masquerade#highlight,
		\ 'Constructor': function('s:MasqueradeEditor'),
		\ }
	call extend(options, get(a:000, 0, {}), 'force')
	let msqrd = options.Constructor(a:mode, a:cmd)
	call msqrd.initialize(options)
	let args = msqrd.start()
	call call('feedkeys', args)
endfunction "}}}

" MasqueradeEditor class{{{
unlockvar! s:MasqueradeEditor
let s:MasqueradeEditor = {
	\	'__CLASS__': 'MasqueradeEditor',
	\	'cmd': '',
	\	'fallback': '',
	\	'mode': '',
	\	'count': '',
	\	'count1': '',
	\	'register': '',
	\	'filter': {},
	\	'curpos': copy(s:NULLPOS),
	\	'view': {},
	\	'highlight': s:HIDURATION,
	\	'remap': s:FALSE,
	\	'remapfallback': s:FALSE,
	\	'keepcurpos': s:TRUE,
	\	'keepothers': s:FALSE,
	\	'usecount': s:FALSE,
	\	'useregister': s:TRUE,
	\	'sort': s:TRUE,
	\	'shiftenv': s:TRUE,
	\	'TextChanged': s:TRUE,
	\	'dotrepeat': s:FALSE,
	\	'_hiitemlist': [],
	\	'_otheritems': [],
	\	}
function! s:MasqueradeEditor(mode, cmd) abort "{{{
	let masquerade = deepcopy(s:MasqueradeEditor)
	let masquerade.mode = a:mode
	let masquerade.cmd = a:cmd
	return masquerade
endfunction "}}}

function! s:MasqueradeEditor.initialize(...) abort "{{{
	let options = get(a:000, 0, {})
	let self.fallback = get(options, 'fallback', self.cmd)
	let self.count = s:count
	let self.count1 = s:count1
	let self.register = s:register
	let self.curpos = s:curpos
	let self.view = s:view
	call self._setopt(options, 'highlight')
	call self._setboolopt(options, 'remap')
	call self._setboolopt(options, 'keepcurpos')
	call self._setboolopt(options, 'keepothers')
	call self._setboolopt(options, 'usecount')
	call self._setboolopt(options, 'useregister')
	let self.remapfallback = get(options, 'remapfallback', self.remap)
endfunction "}}}

function! s:MasqueradeEditor.start() abort "{{{
	if !s:ms.isempty()
		let &operatorfunc = s:OPERATORFUNC
		let g:masquerade#__CURRENT__ = self
		let args = self._startkeys()
	else
		let args = self._fallbackkeys()
	endif
	return args
endfunction "}}}

function! s:MasqueradeEditor.update() abort "{{{
	if self.dotrepeat is s:FALSE
		if self.mode is# 'x'
			let start = getpos("'<")
			let end = getpos("'>")
			let type = s:str2type(visualmode())
			let self.filter = s:getfilter(start, end, type)
		endif
	else
		let self.count = v:count
		let self.count1 = v:count1
		let self.curpos = getpos('.')
		let self.view = winsaveview()
		if self.mode is# 'x'
			let start = getpos('.')
			let self.filter = s:rerenderfilter(start, self.filter)
		endif
	endif
endfunction "}}}

function! s:MasqueradeEditor.prepare() abort "{{{
	if self.shiftenv
		let env = s:shiftenv()
	else
		let env = {}
	endif
	return env
endfunction "}}}

function! s:MasqueradeEditor.itemlist() abort "{{{
	if !empty(self.filter)
		let itemlist = s:ms.emit_inside(self.filter)
		if self.keepothers is s:TRUE
			call extend(self._otheritems, s:ms.emit())
		else
			call s:ms.uncheckall()
		endif
	else
		let itemlist = s:ms.emit()
	endif
	return itemlist
endfunction "}}}

function! s:MasqueradeEditor.execute(itemlist) abort "{{{
	call filter(a:itemlist, '!empty(v:val)')
	if empty(a:itemlist)
		return
	endif

	if self.sort is s:TRUE
		call s:ms.sort(a:itemlist)
	endif

	let cmd = self._docmd()
	for item in reverse(a:itemlist)
		let [change, hiitemlist] = self.do(item, cmd)

		if self.keepcurpos
			call s:shiftcurpos(self.curpos, change)
		endif

		call filter(hiitemlist, '!empty(v:val)')
		if self.highlight > 0
			call s:shiftitems(self._hiitemlist, change)
			if !empty(hiitemlist)
				call extend(self._hiitemlist, hiitemlist)
			endif
		endif

		if self.keepothers
			call s:shiftitems(self._otheritems, change)
		endif
	endfor
	call self.show()
endfunction "}}}

function! s:MasqueradeEditor.do(item, cmd, ...) abort "{{{
	call a:item.select()
	execute a:cmd
	let hiitem = self._hiitem(a:item)
	return [{}, [hiitem]]
endfunction "}}}

function! s:MasqueradeEditor.show() abort "{{{
	if self.highlight <= 0
		return
	endif
	call filter(self._hiitemlist, '!empty(v:val)')
	for hiitem in self._hiitemlist
		call hiitem.show(s:HIGROUP)
	endfor
endfunction "}}}

function! s:MasqueradeEditor.finish(env) abort "{{{
	if !empty(a:env)
		call s:restoreenv(a:env)
	endif

	call filter(self._hiitemlist, '!empty(v:val)')
	if self.highlight > 0 && !empty(self._hiitemlist)
		let task = s:Multiselect.Task()
		for hiitem in self._hiitemlist
			call task.call(hiitem.quench, [], hiitem)
		endfor
		if self.TextChanged is s:TRUE
			call task.skip(1)  " skip the next TextChanged event
		endif

		" NOTE: This is a hack for cmdline-window
		" If entering to the cmdline-window when highlight is on,
		" it cannot be removed. Thus using TaskChain to remove it
		" when coming back to the original buffer
		let taskchain = s:Multiselect.TaskChain()
		call taskchain.hook(['CmdwinEnter']).call(task.cancel, [], task)
		call taskchain.hook(['CmdwinLeave'])
		call taskchain.hook([100]).call(task.trigger, [s:TRUE], task)
		call taskchain.waitfor()

		" NOTE: If everything goes on normally, the taskchain is abandoned
		call task.call(taskchain.cancel, [], taskchain)
		call task.waitfor([self.highlight, 'InsertEnter', 'TextChanged',
						\'BufLeave', 'TabLeave'])
	endif

	if self.keepothers is s:TRUE && !empty(self._otheritems)
		call s:ms.append(remove(self._otheritems, 0, -1))
		if self.TextChanged is s:TRUE
			call s:ms.event('TextChanged').skip(1)
		endif
	endif

	if self.keepcurpos is s:TRUE
		call winrestview(self.view)
		call setpos('.', self.curpos)
	endif

	call filter(self._hiitemlist, 0)
	let self.dotrepeat = s:TRUE
endfunction "}}}



function! s:MasqueradeEditor._fallbackkeys() abort "{{{
	let keyseq = ''
	if self.remapfallback is s:TRUE
		if self.mode is# 'x'
			let keyseq .= s:GV
		endif
		let keyseq .= s:countstr(self.count)
		let keyseq .= s:DOUBLEQUOTE . self.register
		let keyseq .= self.fallback
		let flag = 'im'
	else
		if self.mode is# 'x'
			let keyseq .= 'gv'
		endif
		let keyseq .= s:countstr(self.count)
		let keyseq .= '"' . self.register
		let keyseq .= self.fallback
		let flag = 'in'
	endif
	return [keyseq, flag]
endfunction "}}}

function! s:MasqueradeEditor._startkeys() abort "{{{
	let keyseq = ''
	if self.remap is s:TRUE
		if self.mode is# 'x'
			let keyseq .= s:GV
		endif
		if self.usecount is s:TRUE
			let keyseq .= s:countstr(self.count)
		endif
		if self.useregister is s:TRUE
			let keyseq .= s:DOUBLEQUOTE . self.register
		endif
		if self.mode is# 'x'
			let keyseq .= s:GAT
		else
			let keyseq .= s:GATL
		endif
		let flag = 'im'
	else
		if self.mode is# 'x'
			let keyseq .= 'gv'
		endif
		if self.usecount is s:TRUE
			let keyseq .= s:countstr(self.count)
		endif
		if self.useregister is s:TRUE
			let keyseq .= '"' . self.register
		endif
		if self.mode is# 'x'
			let keyseq .= 'g@'
		else
			let keyseq .= 'g@l'
		endif
		let flag = 'in'
	endif
	return [keyseq, flag]
endfunction "}}}

function! s:MasqueradeEditor._docmd() abort "{{{
	let cmd = 'noautocmd normal'
	if self.remap is s:TRUE
		let cmd .= ' '
		if self.usecount is s:TRUE
			let cmd .= s:countstr(self.count)
		endif
		if self.useregister is s:TRUE
			let cmd .= s:DOUBLEQUOTE . self.register
		endif
	else
		let cmd .= '! '
		if self.usecount is s:TRUE
			let cmd .= s:countstr(self.count)
		endif
		if self.useregister is s:TRUE
			let cmd .= '"' . self.register
		endif
	endif
	let cmd .= self.cmd
	return cmd
endfunction "}}}

function! s:MasqueradeEditor._hiitem(item) abort "{{{
	if self.highlight > 0
		let head = getpos("'[")
		let tail = getpos("']")
		if s:inorderof(head, tail) || head == tail
			let hiitem = s:Multiselect.Item(head, tail, a:item.type, a:item.extended)
			return hiitem
		endif
	endif
	return {}
endfunction "}}}

function! s:MasqueradeEditor._setboolopt(options, name) abort "{{{
	if has_key(a:options, a:name)
		let self[a:name] = !!a:options[a:name]
	endif
endfunction "}}}

function! s:MasqueradeEditor._setopt(options, name) abort "{{{
	if has_key(a:options, a:name)
		let self[a:name] = a:options[a:name]
	endif
endfunction "}}}



function! s:getfilter(start, end, type) abort "{{{
	let filter = s:Multiselect.Region(a:start, a:end, a:type)
	let filter.lines = a:end[1] - a:start[1] + 1
	if filter.type is# 'block'
		let virtcolstart = virtcol(a:start[1:2]) + a:start[3]
		let virtcolend = virtcol(a:end[1:2]) + a:end[3]
		let filter.width = virtcolend - virtcolstart + 1
		let filter.extended = s:isextended()
	elseif filter.type is# 'char'
		if filter.lines > 1
			let filter.width = a:end[2] + a:end[3]
		else
			let filter.width = a:end[2] + a:end[3] - a:start[2] + 1
		endif
	endif
	return filter
endfunction "}}}

function! s:rerenderfilter(start, oldfilter) abort "{{{
	if empty(a:oldfilter)
		return {}
	endif

	let endlnum = a:start[1] + a:oldfilter.lines - 1
	if a:oldfilter.type is# 'block'
		let virtcolstart = virtcol(a:start[1:2]) + a:start[3]
		let virtcolend = virtcolstart + a:oldfilter.width - 1
		let end = s:virt2pos(endlnum, virtcolend)
		let type = a:oldfilter.type
		let extended = a:oldfilter.extended
		let newfilter = s:Multiselect.Region(a:start, end, type, extended)
		let newfilter.width = a:oldfilter.width
		let newfilter.extended = a:oldfilter.extended
	elseif a:oldfilter.type is# 'line'
		let head = [0, a:start[1], 1, 0]
		let tail = [0, endlnum, 1, 0]
		let newfilter = s:Multiselect.Region(head, tail, 'V')
	else
		let colmax = col([endlnum, '$'])
		if a:oldfilter.lines > 1
			let endcol = a:oldfilter.width
		else
			let endcol = a:start[2] + a:oldfilter.width - 1
		endif
		if endcol <= colmax
			let end = [0, endlnum, endcol, 0]
		else
			let end = [0, endlnum, colmax, endcol - colmax]
		endif
		let type = a:oldfilter.type
		let newfilter = s:Multiselect.Region(a:start, end, type)
		let newfilter.width = a:oldfilter.width
	endif
	let newfilter.type = a:oldfilter.type
	let newfilter.lines = a:oldfilter.lines
	return newfilter
endfunction "}}}

function! s:virt2pos(lnum, virtcol) abort "{{{
	let view = winsaveview()
	let virtualedit = &virtualedit
	let &virtualedit = 'all'
	try
		execute printf('normal! %dG%d|', a:lnum, a:virtcol)
		let pos = getpos('.')
	finally
		let &virtualedit = virtualedit
	endtry
	return pos
endfunction "}}}

function! s:shiftcurpos(curpos, change) abort "{{{
	if empty(a:change)
		return a:curpos
	endif
	return a:change.apply(a:curpos)
endfunction "}}}

function! s:shiftitems(itemlist, change) abort "{{{
	if empty(a:itemlist) || empty(a:change)
		return a:itemlist
	endif
	return a:change.mapapply(a:itemlist)
endfunction "}}}
lockvar! s:MasqueradeEditor
"}}}



" y
function! masquerade#y(mode, cmd, ...) abort "{{{
	let options = get(a:000, 0, {})
	let options.Constructor = function('s:MasqueradeY')
	return masquerade#edit(a:mode, a:cmd, options)
endfunction "}}}

" MasqueradeYank class {{{
unlockvar! s:MasqueradeYank
let s:MasqueradeYank = {
	\	'__CLASS__': 'MasqueradeYank',
	\	'yankedlist': [],
	\	}
function! s:MasqueradeYank() abort "{{{
	return deepcopy(s:MasqueradeYank)
endfunction "}}}

function! s:MasqueradeYank.do(item, cmd) abort "{{{
	call a:item.select()
	execute a:cmd
	let a:item.textlist = getreg(self.register, 0, 1)
	call add(self.yankedlist, a:item)
	let hiitem = self._hiitem(a:item)
	return [{}, [hiitem]]
endfunction "}}}

function! s:MasqueradeYank.finish(env) abort "{{{
	call s:ms.sort(self.yankedlist)
	let type = 'block'
	let textlist = []
	for item in self.yankedlist
		call extend(textlist, item.textlist)
		if item.type is# 'line'
			let type = 'line'
		endif
	endfor
	call setreg(self.register, textlist, type[0])
	call s:ClassSys.super(self, 'MasqueradeEditor').finish(a:env)
endfunction "}}}
lockvar! s:MasqueradeYank
"}}}

" MasqueradeY class {{{
unlockvar! s:MasqueradeY
let s:MasqueradeY = {
	\	'__CLASS__': 'MasqueradeY',
	\	'TextChanged': s:FALSE,
	\	}
function! s:MasqueradeY(mode, cmd) abort "{{{
	let y = deepcopy(s:MasqueradeY)
	let yank = s:MasqueradeYank()
	let editor = s:MasqueradeEditor(a:mode, a:cmd)
	return s:ClassSys.inherit(y, yank, editor)
endfunction "}}}
lockvar! s:MasqueradeY
"}}}



" d
function! masquerade#d(mode, cmd, ...) abort "{{{
	let options = get(a:000, 0, {})
	let options.Constructor = function('s:MasqueradeD')
	return masquerade#edit(a:mode, a:cmd, options)
endfunction "}}}

" MasqueradeD class{{{
unlockvar! s:MasqueradeD
let s:MasqueradeD = {
	\	'__CLASS__': 'MasqueradeD',
	\	'highlight': 0,
	\	'keepcurpos': s:TRUE,
	\	}
function! s:MasqueradeD(mode, cmd) abort "{{{
	let d = deepcopy(s:MasqueradeD)
	let yank = s:MasqueradeYank()
	let editor = s:MasqueradeEditor(a:mode, a:cmd)
	return s:ClassSys.inherit(d, yank, editor)
endfunction "}}}

function! s:MasqueradeD.do(item, cmd) dict abort "{{{
	let change = s:Multiselect.Change()
	call change.beforedelete(a:item)
	let [_, hiitem] = s:ClassSys.super(self, 'MasqueradeYank').do(a:item, a:cmd)
	return [change, []]
endfunction "}}}
lockvar! s:MasqueradeD
"}}}



" !
function! masquerade#exclamation(mode, cmd, ...) abort "{{{
	let options = get(a:000, 0, {})
	let options.Constructor = function('s:MasqueradeExclamation')
	return masquerade#edit(a:mode, a:cmd, options)
endfunction "}}}

" MasqueradeExclamation class{{{
unlockvar! s:MasqueradeExclamation
let s:MasqueradeExclamation = {
	\	'__CLASS__': 'MasqueradeExclamation',
	\	'useregister': s:FALSE,
	\	}
function! s:MasqueradeExclamation(mode, cmd) abort "{{{
	let exclamation = deepcopy(s:MasqueradeExclamation)
	let editor = s:MasqueradeEditor(a:mode, a:cmd)
	return s:ClassSys.inherit(exclamation, editor)
endfunction "}}}

function! s:MasqueradeExclamation.start() abort "{{{
	if !s:ms.isempty()
		let inputlist = s:setfiltercmdhist()
		let self.shellcmd = input('!', '', 'shellcmd')
		call s:restorecmdhist('input', inputlist)
		let &operatorfunc = s:OPERATORFUNC
		let g:masquerade#__CURRENT__ = self
		let args = self._startkeys()
	else
		let args = self._fallbackkeys()
	endif
	return args
endfunction "}}}

function! s:MasqueradeExclamation.do(item, _) dict abort "{{{
	call a:item.select()
	execute printf("normal! !%s\<CR>", self.shellcmd)
	let hiitem = self._hiitem(a:item)
	return [{}, [hiitem]]
endfunction "}}}

function! s:MasqueradeExclamation.finish(env) dict abort "{{{
	if self.dotrepeat is s:FALSE
		call histadd('cmd', '!' . self.shellcmd)
	endif
	call s:ClassSys.super(self, 'MasqueradeEditor').finish(a:env)
endfunction "}}}

function! s:MasqueradeExclamation._hiitem(item) abort "{{{
	if self.highlight > 0
		let head = line("'[")
		let tail = line("']")
		let hiitem = s:Multiselect.Item(head, tail, 'line')
	else
		let hiitem = {}
	endif
	return hiitem
endfunction "}}}



function! s:setfiltercmdhist() abort "{{{
	let inputlist = s:getcmdhist('input')
	let cmdlist = s:getcmdhist('cmd')
	call filter(cmdlist, 'v:val =~# ''^!.*''')
	call s:restorecmdhist('input', cmdlist)
	return inputlist
endfunction "}}}

function! s:restorecmdhist(history, histlist) abort "{{{
	if empty(a:histlist)
		return
	endif
	call histdel(a:history, '.*')
	for histitem in reverse(copy(a:histlist))
		call histadd(a:history, histitem)
	endfor
endfunction "}}}

function! s:getcmdhist(history) abort "{{{
	let histlist = []
	let histnr = histnr(a:history)
	if histnr == -1
		return []
	endif
	for index in range(histnr)
		let histlist += [histget(a:history, index)]
	endfor
	return histlist
endfunction "}}}
lockvar! s:MasqueradeExclamation
"}}}



" p
function! masquerade#p(mode, cmd, ...) abort "{{{
	let options = get(a:000, 0, {})
	let options.Constructor = function('s:MasqueradeP')
	return masquerade#edit(a:mode, a:cmd, options)
endfunction "}}}

" MasqueradeP class{{{
unlockvar! s:MasqueradeP
let s:MasqueradeP = {
	\	'__CLASS__': 'MasqueradeP',
	\	'keepcurpos': s:TRUE,
	\	'register_contents': {},
	\	'register_anonymous': {},
	\	}
function! s:MasqueradeP(mode, cmd) abort "{{{
	let p = deepcopy(s:MasqueradeP)
	let editor = s:MasqueradeEditor(a:mode, a:cmd)
	return s:ClassSys.inherit(p, editor)
endfunction "}}}

function! s:MasqueradeP.update(...) abort "{{{
	call s:ClassSys.super(self, 'MasqueradeEditor').update()
	let type = getregtype(self.register)
	let self.register_contents.pastetext = ['"', getreg(self.register), type]
	let self.register_contents.saved = [self.register, getreg(self.register, 1), type]
	let self.register_anonymous.saved = ['"', getreg('"'), getregtype('"')]
endfunction "}}}

function! s:MasqueradeP.do(item, _) abort "{{{
	let change = s:Multiselect.Change()
	call change.beforedelete(a:item)
	call s:setregister(self.register_contents.pastetext)
	call a:item.select()
	normal! ""p
	let type_addition = self.register_contents.pastetext[2]
	call change.afterinsert(getpos("'["), getpos("']"), type_addition)
	let hiitem = self._hiitem(a:item)
	return [change, [hiitem]]
endfunction "}}}

function! s:MasqueradeP.finish(env) abort "{{{
	call s:setregister(self.register_anonymous.saved)
	call s:setregister(self.register_contents.saved)
	call s:ClassSys.super(self, 'MasqueradeEditor').finish(a:env)
endfunction "}}}



function! s:setregister(register) abort "{{{
	call call('setreg', a:register)
endfunction "}}}
lockvar! s:MasqueradeP
"}}}



" i, a, c
function! masquerade#i(mode, cmd, ...) abort "{{{
	let options = get(a:000, 0, {})
	let options.Constructor = function('s:MasqueradeI')
	call masquerade#edit(a:mode, a:cmd, options)
endfunction "}}}

function! masquerade#a(mode, cmd, ...) abort "{{{
	let options = get(a:000, 0, {})
	let options.Constructor = function('s:MasqueradeA')
	call masquerade#edit(a:mode, a:cmd, options)
endfunction "}}}

function! masquerade#c(mode, cmd, ...) abort "{{{
	let options = get(a:000, 0, {})
	let options.Constructor = function('s:MasqueradeC')
	call masquerade#edit(a:mode, a:cmd, options)
endfunction "}}}

" MasqueradeInsert class{{{
unlockvar! s:MasqueradeInsert
let s:MasqueradeInsert = {
	\	'__CLASS__': 'MasqueradeInsert',
	\	'reserved_itemlist': [],
	\	'insertion': '',
	\	'_change': {},
	\	}
function! s:MasqueradeInsert() abort "{{{
	return deepcopy(s:MasqueradeInsert)
endfunction "}}}

function! s:MasqueradeInsert.start() abort "{{{
	if s:ms.isempty()
		return self._fallbackkeys()
	endif

	call s:ClassSys.super(self, 'MasqueradeEditor').update()
	let firsttarget = self.lastitem()
	if empty(firsttarget)
		return self._fallbackkeys()
	endif

	let self._change = s:Multiselect.Change()
	call self._change.beforedelete(firsttarget)

	call s:ms.event('InsertEnter').skip(1)
	call s:Multiselect.Task()
					 \.call(function('s:InsertLeave'), [])
					 \.waitfor(['InsertLeave'])

	let &operatorfunc = s:OPERATORFUNC
	let g:masquerade#__CURRENT__ = self
	call self.aim(firsttarget)
	return self._startkeys()
endfunction "}}}

function! s:MasqueradeInsert.lastitem() abort "{{{
	" s:ms.itemlist should not be empty for this method
	if !empty(self.filter)
		if self.keepothers is s:TRUE
			let others = s:ms.emit({_, item -> !item.isinside(self.filter)})
			call extend(self._otheritems, others)
		else
			call s:ms.filter({_, item -> item.isinside(self.filter)})
		endif
	endif
	let itemlist = s:ms.enumerate()
	if empty(itemlist)
		return {}
	endif
	call s:ms.sort(itemlist)
	let [i, firsttarget] = itemlist[-1]
	call s:ms.remove(i)
	if firsttarget.type is# 'line'
		let itemlist = s:splitlines(firsttarget)
		let firsttarget = remove(itemlist, -1)
		if !empty(itemlist)
			call s:ms.append(itemlist)
		endif
	elseif firsttarget.type is# 'block'
		let itemlist = s:splitblock(firsttarget)
		let firsttarget = remove(itemlist, -1)
		if !empty(itemlist)
			call s:ms.append(itemlist)
		endif
	endif
	return firsttarget
endfunction "}}}

function! s:MasqueradeInsert.update() abort "{{{
	if self.dotrepeat is s:FALSE
		" reset skip count set in s:InsertLeave()
		call s:ms.event('TextChanged').skip(0)

		" .update() has done in self.start()
		return
	endif
	call s:ClassSys.super(self, 'MasqueradeEditor').update()
endfunction "}}}

function! s:MasqueradeInsert.execute(itemlist) abort "{{{
	if self.dotrepeat is s:FALSE
		let self.insertion = @.
	endif
	call s:ClassSys.super(self, 'MasqueradeEditor').execute(a:itemlist)
endfunction "}}}

function! s:MasqueradeInsert._startkeys() abort "{{{
	let keyseq = ''
	if self.remap is s:TRUE
		if self.usecount is s:TRUE
			let keyseq .= s:countstr(self.count)
		endif
		if self.useregister is s:TRUE
			let keyseq .= s:DOUBLEQUOTE . self.register
		endif
		let flag = 'im'
	else
		if self.usecount is s:TRUE
			let keyseq .= s:countstr(self.count)
		endif
		if self.useregister is s:TRUE
			let keyseq .= '"' . self.register
		endif
		let flag = 'in'
	endif
	let keyseq .= self.cmd
	return [keyseq, flag]
endfunction "}}}

function! s:MasqueradeInsert._hiitem(item) abort "{{{
	if self.highlight > 0
		let head = getpos("'[")
		let tail = getpos("']")
		if a:item.type isnot# 'line'
			let tail[2] -= 1
		endif
		if s:inorderof(head, tail) || head == tail
			return s:Multiselect.Item(head, tail, a:item.type, a:item.extended)
		endif
	endif
	return {}
endfunction "}}}

function! s:InsertLeave() abort "{{{
	let msqrd = g:masquerade#__CURRENT__

	" this 'insertion' cannot be obtain in MasqueradeInsert.update()
	" because the following feedkeys(countstr . 'g@', 'in') updates '[, '] marks
	let insertion = s:Multiselect.Region(getpos("'["), getpos("']"), 'char')
	call msqrd._change.afterinsert(insertion)
	call s:shiftitems(msqrd._otheritems, msqrd._change)

	let hiitem = msqrd._hiitem(insertion)
	if !empty(hiitem)
		call add(msqrd._hiitemlist, hiitem)
	endif

	" Only right after a completion, TextChanged event is triggered after
	" InsertLeave event. This is a hack to skip the TextChanged event.
	call s:ms.event('TextChanged').skip(1)

	if msqrd.usecount is s:TRUE
		let countstr = s:countstr(msqrd.count)
	else
		let countstr = ''
	endif
	call feedkeys(countstr . 'g@l', 'in')
endfunction "}}}
lockvar! s:MasqueradeInsert
"}}}

" MasqueradeI class{{{
unlockvar! s:MasqueradeI
let s:MasqueradeI = {
	\	'__CLASS__': 'MasqueradeI',
	\	'usecount': s:TRUE,
	\	'useregister': s:FALSE,
	\	}
function! s:MasqueradeI(mode, cmd) abort "{{{
	let i = deepcopy(s:MasqueradeI)
	let insert = s:MasqueradeInsert()
	let editor = s:MasqueradeEditor(a:mode, a:cmd)
	return s:ClassSys.inherit(i, insert, editor)
endfunction "}}}

function! s:MasqueradeI.aim(firsttarget) abort "{{{
	call setpos('.', a:firsttarget.head)
	call s:openfolding()
	let self.curpos = getpos('.')
	let self.view = winsaveview()
endfunction "}}}

function! s:MasqueradeI.do(item, cmd) abort "{{{
	let hiitemlist = []
	if a:item.type is# 'line'
		let itemlist = reverse(s:splitlines(a:item))
	elseif a:item.type is# 'block'
		let itemlist = reverse(s:splitblock(a:item))
	else
		let itemlist = [a:item]
	endif
	for item in itemlist
		call setpos('.', item.head)
		execute a:cmd . self.insertion
		let hiitem = self._hiitem(item)
		call add(hiitemlist, hiitem)
	endfor
	return [{}, hiitemlist]
endfunction "}}}
lockvar! s:MasqueradeI
"}}}

" MasqueradeA class{{{
unlockvar! s:MasqueradeA
let s:MasqueradeA = {
	\	'__CLASS__': 'MasqueradeA',
	\	'usecount': s:TRUE,
	\	'useregister': s:FALSE,
	\	}
function! s:MasqueradeA(mode, cmd) abort "{{{
	let a = deepcopy(s:MasqueradeA)
	let insert = s:MasqueradeInsert()
	let editor = s:MasqueradeEditor(a:mode, a:cmd)
	return s:ClassSys.inherit(a, insert, editor)
endfunction "}}}

function! s:MasqueradeA.aim(firsttarget) abort "{{{
	call setpos('.', a:firsttarget.tail)
	call s:openfolding()
	let self.curpos = getpos('.')
	let self.view = winsaveview()
endfunction "}}}

function! s:MasqueradeA.do(item, cmd) abort "{{{
	let hiitemlist = []
	if a:item.type is# 'line'
		let itemlist = reverse(s:splitlines(a:item))
	elseif a:item.type is# 'block'
		let itemlist = reverse(s:splitblock(a:item))
	else
		let itemlist = [a:item]
	endif
	for item in itemlist
		call setpos('.', item.tail)
		execute a:cmd . self.insertion
		let hiitem = self._hiitem(item)
		call add(hiitemlist, hiitem)
	endfor
	return [{}, [hiitem]]
endfunction "}}}
lockvar! s:MasqueradeA
"}}}

" MasqueradeC class{{{
unlockvar! s:MasqueradeC
let s:MasqueradeC = {
	\	'__CLASS__': 'MasqueradeC',
	\	}
function! s:MasqueradeC(mode, cmd) abort "{{{
	let c = deepcopy(s:MasqueradeC)
	let insert = s:MasqueradeInsert()
	let yank = s:MasqueradeYank()
	let editor = s:MasqueradeEditor(a:mode, a:cmd)
	return s:ClassSys.inherit(c, insert, yank, editor)
endfunction "}}}

function! s:MasqueradeC.aim(firsttarget) abort "{{{
	call setpos('.', a:firsttarget.head)
	call s:openfolding()
	let self.curpos = getpos('.')
	let self.view = winsaveview()
	call add(self.yankedlist, a:firsttarget)
	call a:firsttarget.select()
endfunction "}}}

function! s:MasqueradeC.update() abort "{{{
	if self.dotrepeat is s:FALSE
		let firsttarget = self.yankedlist[0]
		let firsttarget.textlist = getreg(self.register, 0, 1)
	endif
	call s:ClassSys.super(self, 'MasqueradeInsert').update()
endfunction "}}}

function! s:MasqueradeC.do(item, cmd) abort "{{{
	let change = s:Multiselect.Change()
	call change.beforedelete(a:item)
	let cmd = a:cmd . self.insertion
	call s:ClassSys.super(self, 'MasqueradeYank').do(a:item, cmd)
	call change.afterinsert(getpos("'["), getpos("']"), 'char')
	let hiitem = self._hiitem(a:item)
	return [change, [hiitem]]
endfunction "}}}
lockvar! s:MasqueradeC
"}}}

function! s:splitlines(item) abort "{{{
	let itemlist = []
	for lnum in range(a:item.head[1], a:item.tail[1])
		let line = getline(lnum)
		if empty(line)
			continue
		endif
		let indentstr = matchstr(line, '\m^\s*')
		let head = [0, lnum, strlen(indentstr) + 1, 0]
		let tail = [0, lnum, strlen(line) + 1, 0]
		if s:inorderof(tail, head)
			continue
		endif
		let itemlist += [s:Multiselect.Item(head, tail, 'v')]
	endfor
	return itemlist
endfunction "}}}

function! s:splitblock(item) abort "{{{
	let view = winsaveview()
	let dispheadcol = virtcol(a:item.head[1:2])
	let disptailcol = virtcol(a:item.tail[1:2])
	let virtualedit = &virtualedit
	let &virtualedit = 'onemore'
	try
		let itemlist = []
		if a:item.extended
			for lnum in range(a:item.head[1], a:item.tail[1])
				if empty(getline(lnum))
					continue
				endif
				execute printf('normal! %sG%s|', lnum, dispheadcol)
				let head = getpos('.')
				normal! $
				let tail = getpos('.')
				if virtcol(tail[1:2]) < dispheadcol
					continue
				endif
				let itemlist += [s:Multiselect.Item(head, tail, 'v')]
			endfor
		else
			for lnum in range(a:item.head[1], a:item.tail[1])
				if empty(getline(lnum))
					continue
				endif
				execute printf('normal! %sG%s|', lnum, dispheadcol)
				let head = getpos('.')
				execute printf('normal! %s|', disptailcol)
				let tail = getpos('.')
				if virtcol(tail[1:2]) < dispheadcol
					continue
				endif
				let itemlist += [s:Multiselect.Item(head, tail, 'v')]
			endfor
		endif
	finally
		let &virtualedit = virtualedit
		call winrestview(view)
	endtry
	return itemlist
endfunction "}}}



function! s:countstr(count) abort "{{{
	return a:count ? string(a:count) : ''
endfunction "}}}

function! s:openfolding() abort "{{{
	if foldclosed(line('.')) != -1
		normal! zO
	endif
endfunction "}}}



" highlight group{{{
let s:HIGROUP = 'MasqueradeChange'
function! s:default_highlight() abort
	if hlexists('DiffChange')
		highlight default link MasqueradeChange DiffChange
	else
		highlight default MasqueradeChange cterm=reverse gui=reverse
	endif
endfunction
call s:default_highlight()

augroup masquerade-highlgiht
	autocmd!
	autocmd ColorScheme * call s:default_highlight()
augroup END
"}}}
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set noet ts=4 sw=4 sts=4:
