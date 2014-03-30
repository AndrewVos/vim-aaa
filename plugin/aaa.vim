if exists("g:loaded_aaa")
  finish
endif
let g:loaded_aaa = 1

let s:alternates = []
call add(s:alternates, [["app/", "spec/"], [".rb", "_spec.rb"]])
call add(s:alternates, [["lib/", "spec/lib/"], [".rb", "_spec.rb"]])
call add(s:alternates, [[".feature", "_steps.rb"], ["features/", "features/step_definitions/"]])
call add(s:alternates, [[".go", "_test.go"]])

function! s:Alternate(how)
  for alternate in s:alternates
    let a = expand('%')
    let b = expand('%')
    for replacement in alternate
      let a = substitute(a, replacement[0], replacement[1], "")
      let b = substitute(b, replacement[1], replacement[0], "")
    endfor
    if a != expand('%') && filereadable(a)
      call s:OpenFile(a, a:how)
      return
    endif
    if b != expand('%') && filereadable(b)
      call s:OpenFile(b, a:how)
      return
    endif
  endfor
endfunction

function! s:OpenFile(file, how)
  if a:how == "split"
    execute ":split " . a:file
  elseif a:how == "vsplit"
    execute ":vsplit " . a:file
  else
    execute ":edit " . a:file
  endif
endfunction

command! -nargs=? -bang Alternate call s:Alternate(<q-args>)
