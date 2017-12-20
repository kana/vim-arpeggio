runtime! plugin/arpeggio.vim

describe ':Arpeggio'
  before
    tabnew
  end

  after
    tabclose!
  end

  it 'defines key mappings which contains <Bar> in their {lhs}'
    let v:errmsg = ''
    silent! execute 'Arpeggio nnoremap }<Bar>  Ifoo<Esc>'
    Expect v:errmsg ==# ''

    put ='xyz'
    Expect getline('.') ==# 'xyz'
    execute 'normal }|'
    Expect getline('.') ==# 'fooxyz'

    put ='zzy'
    Expect getline('.') ==# 'zzy'
    execute 'normal }|'
    Expect getline('.') ==# 'foozzy'

    normal! gg
    Expect [line('.'), col('.'), getline('.')] ==# [1, 1, '']
    execute 'normal }'
    Expect [line('.'), col('.'), getline('.')] ==# [3, 6, 'foozzy']
    execute 'normal 3|'
    Expect [line('.'), col('.'), getline('.')] ==# [3, 3, 'foozzy']
  end
end
