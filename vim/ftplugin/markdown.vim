" Example Markdown-only mappings
nnoremap <buffer> ,i <ESC>o- [ ] 

" Maybe your diary command
nnoremap <buffer> ,e :call DiaryNewEntry()<CR>

""Functions for creating diary entries for notes markdown files
""For single project README
function! DiaryNewEntry() abort
  " Format today's date as Day — YYYY-MM-DD
  let l:date = strftime("%A — %Y-%m-%d")

  " Current cursor line
  let l:lnum = line('.')

  " Build the whole entry as a list of lines (keeps original structure)
  let l:block = [
        \ '## ' . l:date,
        \ '',
        \ '### Notes:',
        \ '',
        \ '### Experiment Notes:',
        \ '- Experiments finished:',
        \ '- Experiments failed:',
        \ '- Experiments run:',
        \ '- Code changes made:',
        \ '',
        \ '---',
        \ '' ]

  " Insert the whole block so the first line becomes the current line
  " (append after lnum-1 is equivalent to "insert at cursor position")
  call append(l:lnum - 1, l:block)

  " Move cursor to the 'Notes' line and enter insert mode
  " 'Notes' is the 3rd element in the block, so its absolute line is lnum + 1
  call cursor(l:lnum + 1, 1)
  startinsert
endfunction

command! E call DiaryNewEntry()

""For global diary file
function! GeneralDiaryEntry() abort
  " Date with weekday — YYYY-MM-DD
  let l:date = strftime("%A — %Y-%m-%d")

  " Current cursor line (we will insert after this line)
  let l:lnum = line('.')

  " Build the whole entry as a list of lines
  let l:block = [
        \ '## ' . l:date,
        \ '',
        \ '### Notes:',
        \ '',
        \ '### Projects Worked On:',
        \ '-',
        \ '### Papers Found:',
        \ '-',
        \ '### Experiment Notes:',
        \ '- Experiments finished:',
        \ '- Experiments failed:',
        \ '- Experiments run:',
        \ '- Code changes made:',
        \ '',
        \ '---',
        \ '' ]

  " Insert the whole block below the current line
  call append(l:lnum, l:block)

  " Move cursor to the 'Notes' line (which is lnum + 2) and enter insert mode
  call cursor(l:lnum + 2, 1)
  startinsert
endfunction

" optional command
command! GE call GeneralDiaryEntry()

