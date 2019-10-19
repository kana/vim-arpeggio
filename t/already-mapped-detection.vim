runtime! plugin/arpeggio.vim

function! s:test(user_config, lhs, should_be_warned)
  execute a:user_config

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

  it 'warns about overriding user configuration'
    call s:test('inoremap <buffer> X X', 'XY', v:true)
  end

  context 'overriding internal key mappings'
    it 'does not warn for ordinary key'
      call s:test('', 'XY', v:false)
      call s:test('', 'XY', v:false)
    end

    it 'does not warn for <Bar>'
      call s:test('', '<Bar>1', v:false)
      call s:test('', '<Bar>1', v:false)
    end

    it 'does not warn for <Bslash>'
      call s:test('', '<Bslash>1', v:false)
      call s:test('', '<Bslash>1', v:false)
    end

    it 'does not warn for <lt>'
      call s:test('', '<lt>1', v:false)
      call s:test('', '<lt>1', v:false)
    end

    it 'does not warn for <Leader>'
      call s:test('', '<Leader>1', v:false)
      call s:test('', '<Leader>1', v:false)
    end

    it 'does not warn for <LocalLeader>'
      call s:test('', '<LocalLeader>1', v:false)
      call s:test('', '<LocalLeader>1', v:false)
    end

    it 'does not warn for <Space>'
      call s:test('', '<Space>1', v:false)
      call s:test('', '<Space>1', v:false)
    end
  end
end
