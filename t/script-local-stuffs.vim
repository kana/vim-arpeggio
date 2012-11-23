runtime! plugin/arpeggio.vim

" Usually it is not necessary to load autoload scripts by hand.
" But we have to ensure that the core script is loaded before all tests,
" to settle :scriptnames output.
runtime! autoload/arpeggio.vim

function! s:Foo()
  return 'bar'
endfunction

describe ':Arpeggio'
  before
    tabnew
  end

  after
    tabclose!
  end

  it 'currently does not support <SID> in {rhs}'
    inoremap <buffer> <SID>  <SID>
    let test_script_id = maparg('<SID>', 'i')
    redir => s
    silent scriptnames
    redir END
    let lines = split(s, '\n')
    let pairs = map(lines, 'matchlist(v:val, ''\v^\s*(\d+): (.*)$'')')
    let core_pair = filter(pairs, 'v:val[2] =~# "autoload/arpeggio.vim$"')[0]
    let core_sid = '<SNR>' . core_pair[1] . '_'

    " These commands are executed in the context of this test script.
    " So that <SID> is converted into this test script's SID.
    inoremap <buffer> <SID>local-s  FOO
    imap <buffer> <Plug>global-s  <SID>local-s
    inoremap <buffer> <Plug>indirect-f  <C-r>=<SID>Foo()<CR>

    " :Arpeggio executes many :map family in the context of its core script.
    " So that <SID> is converted into the core script's SID.
    Arpeggio imap <buffer> tl  <SID>local-s
    Arpeggio imap <buffer> tg  <Plug>global-s
    Arpeggio inoremap <buffer> td  <C-r>=<SID>Foo()<CR>
    Arpeggio imap <buffer> ti  <Plug>indirect-f

    " tl => <SID>local-s == <Core's-SID>local-s
    " `--------------'      => (no more mappings; {lhs} is inserted as is)
    "   by arpeggio
    normal otl
    Expect getline('.') ==# core_sid . 'local-s'

    " tg => <Plug>global-s => <SID>local-s
    " `----------------'      == <Test's-SID>local-s
    "    by arpeggio          => FOO
    normal otg
    Expect getline('.') ==# 'FOO'

    " td => <C-r>=<SID>Foo()<CR> == <C-r>=<Core's-SID>Foo()<CR>
    " `------------------------'    => (no such function; error)
    "        by arpeggio
    let v:errmsg = ''
    silent! normal otd
    Expect getline('.') ==# ''
    Expect v:errmsg ==# 'E15: Invalid expression: ' . core_sid . 'Foo()'

    " td => <Plug>indirect-f => <C-r>=<SID>Foo()<CR>
    " `--------------------'    == <C-r>=<Test's-SID>Foo()<CR>
    "      by arpeggio          => (no such function; error)
    normal oti
    Expect getline('.') ==# 'bar'
  end
end
