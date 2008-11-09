" arpeggio - Mappings for simultaneously pressed keys
" Version: 0.0.2
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

if exists('g:loaded_arpeggio')
  finish
endif




if !exists('g:arpeggio_timeoutlen')
  let g:arpeggio_timeoutlen = 40
endif
if !exists('g:arpeggio_timeoutlens')
  let g:arpeggio_timeoutlens = {}
endif




command! -nargs=+ Arpeggio  call arpeggio#_do(<q-args>)

command! -bang -nargs=* Arpeggiomap
\        call arpeggio#_map_or_list(<bang>0 ? 'ic' : 'nvo', 1, <q-args>)
command! -nargs=* Arpeggiocmap  call arpeggio#_map_or_list('c', 1, <q-args>)
command! -nargs=* Arpeggioimap  call arpeggio#_map_or_list('i', 1, <q-args>)
command! -nargs=* Arpeggiolmap  call arpeggio#_map_or_list('l', 1, <q-args>)
command! -nargs=* Arpeggionmap  call arpeggio#_map_or_list('n', 1, <q-args>)
command! -nargs=* Arpeggioomap  call arpeggio#_map_or_list('o', 1, <q-args>)
command! -nargs=* Arpeggiosmap  call arpeggio#_map_or_list('s', 1, <q-args>)
command! -nargs=* Arpeggiovmap  call arpeggio#_map_or_list('v', 1, <q-args>)
command! -nargs=* Arpeggioxmap  call arpeggio#_map_or_list('x', 1, <q-args>)

command! -bang -nargs=* Arpeggionoremap
\        call arpeggio#_map_or_list(<bang>0 ? 'ic' : 'nvo',0,<q-args>)
command! -nargs=* Arpeggiocnoremap  call arpeggio#_map_or_list('c',0,<q-args>)
command! -nargs=* Arpeggioinoremap  call arpeggio#_map_or_list('i',0,<q-args>)
command! -nargs=* Arpeggiolnoremap  call arpeggio#_map_or_list('l',0,<q-args>)
command! -nargs=* Arpeggionnoremap  call arpeggio#_map_or_list('n',0,<q-args>)
command! -nargs=* Arpeggioonoremap  call arpeggio#_map_or_list('o',0,<q-args>)
command! -nargs=* Arpeggiosnoremap  call arpeggio#_map_or_list('s',0,<q-args>)
command! -nargs=* Arpeggiovnoremap  call arpeggio#_map_or_list('v',0,<q-args>)
command! -nargs=* Arpeggioxnoremap  call arpeggio#_map_or_list('x',0,<q-args>)

command! -bang -nargs=* Arpeggiounmap
\        call arpeggio#_unmap(<bang>0 ? 'ic' : 'nvo', <q-args>)
command! -nargs=* Arpeggiocunmap  call arpeggio#_unmap('c', <q-args>)
command! -nargs=* Arpeggioiunmap  call arpeggio#_unmap('i', <q-args>)
command! -nargs=* Arpeggiolunmap  call arpeggio#_unmap('l', <q-args>)
command! -nargs=* Arpeggionunmap  call arpeggio#_unmap('n', <q-args>)
command! -nargs=* Arpeggioounmap  call arpeggio#_unmap('o', <q-args>)
command! -nargs=* Arpeggiosunmap  call arpeggio#_unmap('s', <q-args>)
command! -nargs=* Arpeggiovunmap  call arpeggio#_unmap('v', <q-args>)
command! -nargs=* Arpeggioxunmap  call arpeggio#_unmap('x', <q-args>)




let g:loaded_arpeggio = 1

" __END__
" vim: foldmethod=marker
