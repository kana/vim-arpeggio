" arpeggio - Mappings for simultaneously pressed keys
" Version: 0.0.0
" Copyright (C) 2008 kana <http://whileimautomaton.net/>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Notes  "{{{1
"
" CONVENTIONS FOR INTERNAL MAPPINGS
"
" <SID>work:...
"               Use to set 'timeoutlen', to restore 'timeoutlen', and to
"               determine whether keys are simultaneously pressed or not.
"
" <SID>success:...
"               Use to restore 'timeoutlen' and to do user-defined action for
"               the simultaneously pressed keys "...".
"
"
" MAPPING FLOWCHART
"
"                        {X}            (user types a key {X})
"                         |
"                         v
"                  <SID>work:{X}
"                         |  (are {Y}... simultaneously typed with {X}?)
"                  [yes]  |  [no]
"         .---------------*-------------------.
"         |                                   |
"         v                                   v
"  <SID>work:{X}{Y}...          <Plug>(arpeggio-default:{X})
"         |
"         v
" <SID>success:{X}{Y}...
"         |
"         v
"       {rhs}








" Variables  "{{{1

if !exists('g:arpeggio_timeoutlen')
  let g:arpeggio_timeoutlen = 40
endif

" See s:set_up_options() and s:restore_options().
let s:original_showcmd = &showcmd
let s:original_timeoutlen = &timeoutlen








" Commands  "{{{1

command! -bang -nargs=* Arpeggiomap
\        call s:cmd_map_or_list(<bang>0 ? 'ic' : 'nvo', 1, <q-args>)
command! -nargs=* Arpeggiocmap  call s:cmd_map_or_list('c', 1, <q-args>)
command! -nargs=* Arpeggioimap  call s:cmd_map_or_list('i', 1, <q-args>)
command! -nargs=* Arpeggiolmap  call s:cmd_map_or_list('l', 1, <q-args>)
command! -nargs=* Arpeggionmap  call s:cmd_map_or_list('n', 1, <q-args>)
command! -nargs=* Arpeggioomap  call s:cmd_map_or_list('o', 1, <q-args>)
command! -nargs=* Arpeggiosmap  call s:cmd_map_or_list('s', 1, <q-args>)
command! -nargs=* Arpeggiovmap  call s:cmd_map_or_list('v', 1, <q-args>)
command! -nargs=* Arpeggioxmap  call s:cmd_map_or_list('x', 1, <q-args>)

command! -bang -nargs=* Arpeggionoremap
\        call s:cmd_map(<bang>0 ? 'ic' : 'nvo', 1, <q-args>)
command! -nargs=* Arpeggiocnoremap  call s:cmd_map('c', 0, <q-args>)
command! -nargs=* Arpeggioinoremap  call s:cmd_map('i', 0, <q-args>)
command! -nargs=* Arpeggiolnoremap  call s:cmd_map('l', 0, <q-args>)
command! -nargs=* Arpeggionnoremap  call s:cmd_map('n', 0, <q-args>)
command! -nargs=* Arpeggioonoremap  call s:cmd_map('o', 0, <q-args>)
command! -nargs=* Arpeggiosnoremap  call s:cmd_map('s', 0, <q-args>)
command! -nargs=* Arpeggiovnoremap  call s:cmd_map('v', 0, <q-args>)
command! -nargs=* Arpeggioxnoremap  call s:cmd_map('x', 0, <q-args>)

command! -bang -nargs=* Arpeggiounmap
\        call s:cmd_unmap(<bang>0 ? 'ic' : 'nvo', <q-args>)
command! -nargs=* Arpeggiocunmap  call s:cmd_unmap('c', <q-args>)
command! -nargs=* Arpeggioiunmap  call s:cmd_unmap('i', <q-args>)
command! -nargs=* Arpeggiolunmap  call s:cmd_unmap('l', <q-args>)
command! -nargs=* Arpeggionunmap  call s:cmd_unmap('n', <q-args>)
command! -nargs=* Arpeggioounmap  call s:cmd_unmap('o', <q-args>)
command! -nargs=* Arpeggiosunmap  call s:cmd_unmap('s', <q-args>)
command! -nargs=* Arpeggiovunmap  call s:cmd_unmap('v', <q-args>)
command! -nargs=* Arpeggioxunmap  call s:cmd_unmap('x', <q-args>)








" Mappings  "{{{1

noremap <SID>  <Nop>
noremap! <SID>  <Nop>
lnoremap <SID>  <Nop>








" Functions  "{{{1
function! arpeggio#load()  "{{{2
  " Does nothing - calling this function does source this script file.
endfunction




function! arpeggio#map(modes, options, remap_p, lhs, rhs)  "{{{2
  for mode in s:each_char(a:modes)
    call s:map(mode, a:options, a:remap_p, s:split_to_keys(a:lhs), a:rhs)
  endfor
  return
endfunction




function! arpeggio#unmap(modes, options, lhs)  "{{{2
  for mode in s:each_char(a:modes)
    call s:unmap(mode, a:options, s:split_to_keys(a:lhs))
  endfor
endfunction








" Misc.  "{{ {1
function! s:chord_cancel(key)  "{{{2
  call s:restore_options()
  return "\<Plug>(arpeggio-default:" . a:key . ')'
endfunction




function! s:chord_key(key)  "{{{2
  call s:set_up_options()
  return s:SID . 'work:' . a:key  " <SID>work:...
endfunction




function! s:chord_success(keys)  "{{{2
  call s:restore_options()
  return s:SID . 'success:' . a:keys  " <SID>success:...
endfunction




function! s:cmd_list(modes, options, lhs)  "{{{2
  throw 'NIY'
endfunction




function! s:cmd_map(modes, remap_p, q_args)  "{{{2
  let [options, lhs, rhs] = s:parse_args(a:q_args)
  return arpeggio#map(a:modes, options, a:remap_p, lhs, rhs)
endfunction




function! s:cmd_map_or_list(modes, remap_p, q_args)  "{{{2
  let [options, lhs, rhs] = s:parse_args(a:q_args)
  if rhs is not 0
    return arpeggio#map(a:modes, options, a:remap_p, lhs, rhs)
  else
    return s:cmd_list(a:modes, options, lhs)
  endif
endfunction




function! s:cmd_unmap(modes, q_args)  "{{{2
  throw 'NIY'
endfunction




function! s:map(mode, options, remap_p, keys, rhs)  "{{{2
  " Assumption: Values in a:keys are <>-escaped, e.g., "<Tab>" not "\<Tab>".
  let opt_buffer = a:options =~# 'b' ? '<buffer>' : ''

  for key in a:keys
    execute printf('%smap <expr> %s %s  <SID>chord_key(%s)',
    \              a:mode, opt_buffer, key, string(key))
  endfor

  let combos = []
  for i in range(1, len(a:keys) - 1)
    call extend(combos, s:permutations(a:keys, i))
  endfor
  for combo in combos
    execute printf('%smap <expr> <SID>work:%s  <SID>chord_cancel(%s)',
    \              a:mode, combo, string(combo))
    execute printf('silent! %snoremap <unique> <Plug>(arpeggio-default:%s) %s',
    \              a:mode, combo, combo)
  endfor

  for combo in s:permutations(a:keys, len(a:keys))
    execute printf('%smap <expr> <SID>work:%s  <SID>chord_success(%s)',
    \              a:mode, combo, string(combo))
    execute printf('%s%smap %s <SID>success:%s  %s',
    \              a:mode,
    \              a:remap_p ? '' : 'nore',
    \              s:to_map_arguments(a:options),
    \              combo,
    \              a:rhs)
  endfor
  return
endfunction




function! s:parse_args(q_args)  "{{{2
  throw 'NIY'
endfunction




function! s:permutations(ss, r)  "{{{2
  " This function is translated one of itertools.permutations() of Python 2.6:
  " http://www.python.org/doc/2.6/library/itertools.html#itertools.permutations
  let result = []
  let n = len(a:ss)
  let r = a:r
  let indices = range(n)
  let cycles = range(n, n-r+1, -1)
  let rest = n
  for _ in range(n-1, n-r+1, -1)
    let rest = rest * _
  endfor

  call add(result, join(map(indices[:r-1], 'a:ss[v:val]'), ''))
  for _ in range(rest - 1)
    for i in range(r-1, 0, -1)
      let cycles[i] -= 1
      if cycles[i] == 0
        let indices[(i):] = indices[(i+1):] + indices[(i):(i)]
        let cycles[i] = n - i
      else
        let j = cycles[i]
        let [indices[i], indices[-j]] = [indices[-j], indices[i]]
        call add(result, join(map(indices[:r-1], 'a:ss[v:val]'), ''))
        break
      endif
    endfor
  endfor
  return result
endfunction




function! s:unmap(mode, options, keys)  "{{{2
  let opt_buffer = a:options =~# 'b' ? '<buffer>' : ''

  for key in a:keys
    execute printf('%sunmap %s %s',
    \              a:mode, opt_buffer, key)
  endfor

  for combo in s:permutations(a:keys, len(a:keys))
    execute printf('%sunmap %s <SID>success:%s',
    \              a:mode,
    \              s:to_map_arguments(a:options),
    \              combo)
  endfor
  return
endfunction




" Misc.  "{{{2
function! s:SID()  "{{{3
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_')
endfunction
let s:SID = "\<SNR>" . s:SID() . '_'


function! s:each_char(s)  "{{{3
  return split(a:s, '.\zs')
endfunction


function! s:restore_options()  "{{{3
  let &showcmd = s:original_showcmd
  let &timeoutlen = s:original_timeoutlen
  return
endfunction


function! s:set_up_options()  "{{{3
  let s:original_showcmd = &showcmd
  let s:original_timeoutlen = &timeoutlen

  set noshowcmd  " To avoid flickering in the bottom line.
  let &timeoutlen = g:arpeggio_timeoutlen
  return
endfunction


function! s:split_to_keys(lhs)  "{{{3
  " Assumption: Special keys such as <C-u> are escaped with < and >, i.e.,
  "             a:lhs doesn't directly contain any escape sequences.
  return split(a:lhs, '\(<[^<>]\+>\|.\)\zs')
endfunction


function! s:to_map_arguments(options)  "{{{3
  let _ = {'b': '<buffer>', 'e': '<expr>', 's': '<silent>'}
  return join(map(s:each_char(a:options), '_[v:val]'))
endfunction


function! s:without(list, i)  "{{{3
  if 0 < a:i
    return a:list[0 : (a:i-1)] + a:list[(a:i+1) : -1]
  else
    return a:list[1:]
  endif
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
