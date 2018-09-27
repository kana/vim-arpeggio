runtime! plugin/arpeggio.vim

describe ':Arpeggio'
  before
    tabnew
  end

  after
    tabclose!
  end

  it 'does not warn to redefine arpeggio key mapping with <Bar>'
    let v:errmsg = ''
    redir => warnmsg
    silent! execute 'Arpeggio inoremap <buffer> <Bar>1  xyzzy'
    redir END
    Expect strtrans(warnmsg) !~# 'is already mapped in mode'
    Expect v:errmsg ==# ''

    let v:errmsg = ''
    redir => warnmsg
    silent! execute 'Arpeggio inoremap <buffer> <Bar>1  xyzzy'
    redir END
    Expect strtrans(warnmsg) !~# 'is already mapped in mode'
    Expect v:errmsg !~# 'is already mapped in mode'
  end

  it 'does not warn to redefine arpeggio key mapping with <Bslash>'
    let v:errmsg = ''
    redir => warnmsg
    silent! execute 'Arpeggio inoremap <buffer> <Bslash>2  xyzzy'
    redir END
    Expect strtrans(warnmsg) !~# 'is already mapped in mode'
    Expect v:errmsg !~# 'is already mapped in mode'

    redir => warnmsg
    silent! execute 'Arpeggio inoremap <buffer> <Bslash>2  xyzzy'
    redir END
    Expect strtrans(warnmsg) !~# 'is already mapped in mode'
    Expect v:errmsg !~# 'is already mapped in mode'
  end

  it 'does not warn to redefine arpeggio key mapping with <lt>'
    let v:errmsg = ''
    redir => warnmsg
    silent! execute 'Arpeggio inoremap <buffer> <lt>3  xyzzy'
    redir END
    Expect strtrans(warnmsg) !~# 'is already mapped in mode'
    Expect v:errmsg !~# 'is already mapped in mode'

    redir => warnmsg
    silent! execute 'Arpeggio inoremap <buffer> <lt>3  xyzzy'
    redir END
    Expect strtrans(warnmsg) !~# 'is already mapped in mode'
    Expect v:errmsg ==# ''
  end
end
