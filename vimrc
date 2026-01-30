
call plug#begin('~/.vim/plugged')

" --- Add plugins here ---
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Use Enter to confirm completion (Coc)
" inoremap <silent><expr> <CR> pumvisible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <CR> pumvisible() ? coc#pum#confirm() . "\<Right>" . " ": "\<CR>"

" Use Tab to navigate the completion menu
inoremap <silent><expr> <TAB> pumvisible() ? coc#pum#next(1) : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? coc#pum#prev(1) : "\<C-h>"

" Tell coc not to suggest things in Python
autocmd FileType python let b:coc_suggest_disable = 1


" Enable vimtex for LaTeX
filetype plugin indent on
syntax enable
set belloff=all
syntax on
" Safe tab-title for macOS Terminal.app
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'medium'
set number
set numberwidth=2
set hlsearch
set tabstop=2
set expandtab
set shiftwidth=2

set autoindent
set showmatch

nnoremap <CR> :noh<CR><CR>
" nnoremap <C-l> $
set ruler
set textwidth=120
set nowrap
set textwidth=0 wrapmargin=0

" Don't show compiler messages unless errors
" let g:vimtex_quickfix_mode = 0

""---------------------------------------------------------------------------------------------------------------------
" Latex vimtex configuration, more in/.vim/ftplugin/tex.vim
" Automatically open pdf when compiling

" Use latexmk for continuous compilation
let g:vimtex_compiler_method = 'latexmk'

" Automatically open PDF viewer when compiled
let g:vimtex_view_method = 'skim'
let g:vimtex_view_automatic = 1
let g:vimtex_view_skim_sync = 1
let g:vimtex_view_skim_activate = 1

augroup latex_wrapping
  autocmd!
  autocmd FileType tex setlocal textwidth=120 formatoptions+=t linebreak
augroup END

command! Md execute '!open -a "MacDown" ' . shellescape(expand('%:p'))

""---------------------------------------------------------------------------------------------------------------------
" Insert line of dashes in comment depending on filetype
"
function! InsertDashComment() abort
  " Choose comment prefix based on filetype
  if &filetype ==# 'cpp' || &filetype ==# 'c' || &filetype ==# 'h'
    let l:prefix = '//'
  elseif &filetype ==# 'tex'
    let l:prefix = '%'
  elseif &filetype ==# 'python'
    let l:prefix = '#'
  else
    " Fallback for unknown filetypes
    let l:prefix = '//'
  endif

  " Insert below current line
  call append(line('.'), l:prefix . repeat('-', 118))
endfunction

" Normal-mode shortcut
nnoremap ,l :call InsertDashComment()<CR>

