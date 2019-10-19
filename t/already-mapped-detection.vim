runtime! plugin/arpeggio.vim

function! s:test(user_config, lhs, should_be_warned)
  execute a:user_config

  let v:errmsg = ''
  redir => warnmsg
  silent! execute 'Arpeggio inoremap <buffer>' a:lhs 'xyzzy'
  redir END

  if a:should_be_warned
    Expect strtrans(warnmsg) =~# 'is already mapped in mode'
  else
    Expect strtrans(warnmsg) !~# 'is already mapped in mode'
  endif
endfunction

describe ':Arpeggio'
  before
    tabnew
  end

  after
    tabclose!
  end

  it 'does not warn to redefine arpeggio key mapping with <Bar>'
    call s:test('', '<Bar>1', v:false)
    call s:test('', '<Bar>1', v:false)
  end

  it 'does not warn to redefine arpeggio key mapping with <Bslash>'
    call s:test('', '<Bslash>1', v:false)
    call s:test('', '<Bslash>1', v:false)
  end

  it 'does not warn to redefine arpeggio key mapping with <lt>'
    call s:test('', '<lt>1', v:false)
    call s:test('', '<lt>1', v:false)
  end
end
