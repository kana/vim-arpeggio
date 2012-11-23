runtime! plugin/arpeggio.vim

function! CheckMapModes(lhs)
  let _ = ['n', 'x', 's', 'o', 'i', 'c', 'l']
  call map(_, 'maparg(' . string(a:lhs) . ', v:val)')
  call map(_, 'v:val != ""')
  return _
endfunction

describe ':Arpeggio'
  before
    tabnew
  end

  after
    tabclose!
  end

  it 'defines key mappings properly'
    silent! execute 'Arpeggio inoremap lhs1  rhs1"rhs2'
    silent! execute 'Arpeggio inoremap lhs2  rhs1<Bar>rhs2'
    silent! execute 'Arpeggio inoremap lhs3  rhs1|rhs2'
    Expect CheckMapModes('o') ==# [0, 0, 0, 0, 0, 0, 0]
    Expect CheckMapModes('l') ==# [0, 0, 0, 0, 1, 0, 0]
    Expect CheckMapModes('h') ==# [0, 0, 0, 0, 1, 0, 0]
    Expect CheckMapModes('s') ==# [0, 0, 0, 0, 1, 0, 0]
    Expect CheckMapModes('1') ==# [0, 0, 0, 0, 1, 0, 0]
    Expect CheckMapModes('2') ==# [0, 0, 0, 0, 1, 0, 0]
    Expect CheckMapModes('3') ==# [0, 0, 0, 0, 1, 0, 0]

    normal olhs0
    Expect getline('.') ==# 'lhs0'
    normal olhs1
    Expect getline('.') ==# 'rhs1"rhs2'
    normal olhs2
    Expect getline('.') ==# 'rhs1|rhs2'
    normal olhs3
    Expect getline('.') ==# 'rhs1'
  end
end
