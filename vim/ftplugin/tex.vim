" ================================
" File: ~/.vim/ftplugin/tex.vim
" Purpose: LaTeX settings for Vim + VimTeX + pgfplots workflows
" ================================

" --- Theme ---
colorscheme gruvbox
set background=dark

" --- Disable red underscore highlights for '_' outside math mode ---
autocmd FileType tex syntax clear texError

" --- Basic text layout ---
setlocal wrap
setlocal linebreak
setlocal breakat=\ \;,!?()
setlocal colorcolumn=120
setlocal textwidth=0
setlocal formatoptions+=t

" --- Enable spellcheck (optional) ---
setlocal spell spelllang=en

" ============================
" Latexmk compiler configuration
" ============================
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-pdf',
      \   '-interaction=nonstopmode',
      \   '-synctex=1',
      \   '-outdir=../out',
      \   '-auxdir=.build'
      \ ],
      \}

" For plotting subprojects: always force rebuilds (ignore cached aux files)
if expand('%:p') =~ '/plotting/'
  let g:vimtex_compiler_latexmk.options += ['-g']
endif

" ============================
" Auto-copy plot PDFs for plotting subprojects
" ============================

function! CopyPlotPdfOnCompile() abort
  let l:srcdir = expand('%:p:h')
  let l:texname = expand('%:t:r')

  if l:srcdir =~# '/plotting/.*/src$'
    let l:project_name = fnamemodify(l:srcdir, ':h:t')
    let l:build_pdf = l:srcdir . '/../out/' . l:texname . '.pdf'
    let l:dest_pdf = l:srcdir . '/../../../src/plotpdfs/' . l:project_name . '.pdf'

    echom "Plot project detected: " . l:project_name
    echom "Copying from: " . l:build_pdf
    echom "To: " . l:dest_pdf

    if filereadable(l:build_pdf)
      call mkdir(fnamemodify(l:dest_pdf, ':h'), 'p')
      silent execute '!cp ' . shellescape(l:build_pdf) . ' ' . shellescape(l:dest_pdf)
      echom "Copied plot PDF -> " . l:dest_pdf
    else
      echom "PDF not found at: " . l:build_pdf
    endif
  endif
endfunction

augroup VimtexPlotMover
  autocmd!
  autocmd User VimtexEventCompileSuccess call CopyPlotPdfOnCompile()
augroup END

" Insert an equation environment: type ;eq in insert or normal mode
inoremap <buffer> ;eq \begin{equation}<CR><Tab><CR>\label{eqn:}<CR>\end{equation}<Esc>kA
nnoremap <buffer> ;eq o\begin{equation}<CR><Tab><CR>\label{eqn:}<CR>\end{equation}<Esc>kA
" Insert a section environment: type ;sec in insert or normal mode
inoremap <buffer> ;sec \section{}<Esc>hi
nnoremap <buffer> ;sec o\section{}<Esc>ha
" Insert a figure environment: type ;sec in insert or normal mode
inoremap <buffer> ;fig \figure{}[]<CR><Tab><CR>\label{fig:}<CR>\end{figure}kk$i
nnoremap <buffer> ;fig o\figure{}[]<CR><Tab><CR>\end{figure}kk$i
" Insert a hyperref
inoremap <buffer> ;r ~\ref{}<Esc>ha
" Insert a citation
inoremap <buffer> ;c ~\cite{}<Esc>ha
" Insert $$ and insert between them
inoremap <buffer> ;m $$<Esc>ha
