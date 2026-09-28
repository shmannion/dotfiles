" ================================
" File: ~/.vim/ftplugin/tex.vim
" Purpose: LaTeX settings for Vim + VimTeX + pgfplots workflows
" ================================

" --- Theme ---
colorscheme gruvbox
set background=dark

" --- Disable red underscore highlights for '_' outside math mode ---
" --- Silence false '_' errors only inside \datadir paths ---
function! s:TexDataPath() abort
  syntax match texDataFile /{\\datadir[^}]*}/ containedin=ALL contains=@NoSpell
endfunction
call timer_start(0, {-> s:TexDataPath()})

" --- Basic text layout ---
setlocal wrap
setlocal linebreak
setlocal breakat=\ \;,!?()
setlocal colorcolumn=120
setlocal textwidth=120
setlocal formatoptions+=t
nnoremap <buffer> j gj
nnoremap <buffer> k gk
" setlocal textwidth=0
" setlocal formatoptions-=t

" --- Enable spellcheck (optional) ---
setlocal spell spelllang=en

" ============================
" Latexmk compiler configuration
" ============================
let s:latexmk_options = ['-pdf', '-interaction=nonstopmode', '-synctex=1']
if expand('%:p') =~ '/plotting/'
  call add(s:latexmk_options, '-g')
endif

let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : '.build',
      \ 'options' : s:latexmk_options,
      \}

" let g:vimtex_compiler_latexmk = {
"       \ 'build_dir' : '.build',
"       \ 'options' : [
"       \   '-pdf',
"       \   '-interaction=nonstopmode',
"       \   '-synctex=1',
"       \ ],
"       \}

" " For plotting subprojects: always force rebuilds (ignore cached aux files)
" if expand('%:p') =~ '/plotting/'
"   let g:vimtex_compiler_latexmk.options += ['-g']
" endif
" let g:vimtex_compiler_ignore_warnings = 1
let g:vimtex_quickfix_mode = 0

" ============================
" Auto-copy plot PDFs for plotting subprojects
" ============================

function! CopyPlotPdfOnCompile() abort
  let l:srcdir = expand('%:p:h')
  let l:texname = expand('%:t:r')

  if l:srcdir =~# '/plotting/.*/src$'
    let l:project_name = fnamemodify(l:srcdir, ':h:t')
    let l:build_pdf = l:srcdir . '/.build/' . l:texname . '.pdf'
    let l:dest_pdf = l:srcdir . '/../../../src/plotpdfs/' . l:project_name . '.pdf'

    echom "Plot project detected: " . l:project_name
    echom "Copying from: " . l:build_pdf
    echom "To: " . l:dest_pdf

    if filereadable(l:build_pdf)
      call mkdir(fnamemodify(l:dest_pdf, ':h'), 'p')
      silent execute '!cp ' . shellescape(l:build_pdf) . ' ' . shellescape(l:dest_pdf)
      echom "Copied plot PDF " . l:dest_pdf
    else
      echom "PDF not found at: " . l:build_pdf
    endif
  endif
endfunction

augroup VimtexPlotMover
  autocmd!
  autocmd User VimtexEventCompileSuccess call CopyPlotPdfOnCompile()
augroup END

" ============================
" Auto-copy the main PDF to out/ on successful compile
" ============================

function! CopyMainPdfOnCompile() abort
  " Plotting subprojects are handled by CopyPlotPdfOnCompile()
  if expand('%:p') =~# '/plotting/'
    return
  endif
  let l:bdir = b:vimtex.compiler.build_dir
  if l:bdir !~# '^/'
    let l:bdir = b:vimtex.root . '/' . l:bdir   " anchor relative build_dir to project root
  endif
  let l:pdf  = l:bdir . '/' . fnamemodify(b:vimtex.tex, ':t:r') . '.pdf'
  let l:dest = fnamemodify(b:vimtex.root, ':h') . '/out/'
  if filereadable(l:pdf)
    call mkdir(l:dest, 'p')
    call system('cp ' . shellescape(l:pdf) . ' ' . shellescape(l:dest))
    echom 'Copied main PDF to ' . l:dest
  else
    echom 'Main PDF not found at: ' . l:pdf
  endif
endfunction

augroup VimtexMainMover
  autocmd!
  autocmd User VimtexEventCompileSuccess call CopyMainPdfOnCompile()
augroup END

" Insert an equation environment: type ;eq in insert or normal mode
inoremap <buffer> ,eq \begin{equation}<CR><Tab><CR>\label{eqn:}<CR>\end{equation}<Esc>kkxi
nnoremap <buffer> ,eq o\begin{equation}<CR><Tab><CR>\label{eqn:}<CR>\end{equation}<Esc>kkxi
" Insert a section environment: type ;sec in insert or normal mode
inoremap <buffer> ,sec \section{}<Esc>hi
nnoremap <buffer> ,sec o\section{}<Esc>ha
" Insert a figure environment: type ;sec in insert or normal mode
inoremap <buffer> ,fig \begin{figure}[]<CR><Tab><CR>\label{fig:}<CR>\end{figure}<Esc>kk$i
nnoremap <buffer> ,fig o\begin{figure}[]<CR><Tab><CR>\end{figure}<Esc>kk$i
" Insert a hyperref
inoremap <buffer> ,r ~\ref{}<Esc>ha
" Insert a citation
inoremap <buffer> ,c ~\cite{}<Esc>ha
" Insert $$ and insert between them
inoremap <buffer> ,m $$<Esc>ha
" Insert italics
inoremap <buffer> ,i \textit{}<Esc>ha
" Insert bold
inoremap <buffer> ,b \textbf{}<Esc>ha
" Insert yanked text in between dollar signs
nnoremap <buffer> mp i$$<Esc>hp
