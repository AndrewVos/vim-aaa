if exists("g:loaded_aaa")
  finish
endif
let g:loaded_aaa = 1

let s:alternates = []
call add(s:alternates, [["app/", "spec/"], [".rb", "_spec.rb"]])
call add(s:alternates, [[".feature", "_steps.rb"], ["features/", "features/step_definitions/"]])
call add(s:alternates, [[".go", "_test.go"]])

function! Alternate()
  for alternate in s:alternates
    let a = expand('%')
    let b = expand('%')
    for replacement in alternate
      let a = substitute(a, replacement[0], replacement[1], "")
      let b = substitute(b, replacement[1], replacement[0], "")
    endfor
    if a != expand('%') && filereadable(a)
      execute ":edit " . a
      return
    endif
    if b != expand('%') && filereadable(b)
      execute ":edit " . b
    endif
  endfor
endfunction

comm! -nargs=? -bang A call Alternate()
