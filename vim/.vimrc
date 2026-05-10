" ============================================================
"  General
" ============================================================
set nocompatible
filetype plugin indent on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set hidden                      " allow unsaved buffers in background
set history=500
set updatetime=300

" ============================================================
"  Appearance
" ============================================================
set number
set relativenumber
set cursorline
set colorcolumn=80,120
set signcolumn=yes
set scrolloff=8
set sidescrolloff=8
set showmatch                   " briefly jump to matching bracket
set laststatus=2                " always show statusline
set noshowmode                  " mode shown in statusline instead

" ============================================================
"  Indentation  (C style: 4-space hard tabs)
" ============================================================
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab                 " real tabs — typical C convention
set autoindent
set smartindent
set cinoptions=:0,l1,g0,N-s    " sane C indent rules

" ============================================================
"  Search
" ============================================================
set hlsearch
set incsearch
set ignorecase
set smartcase

" ============================================================
"  Splits & windows
" ============================================================
set splitbelow
set splitright

" ============================================================
"  Completion
" ============================================================
set complete=.,b,u,]            " current buf, other bufs, unloaded bufs, tags
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.obj,*.a,*.so,*.out,*.d,*.swp

" ============================================================
"  Tags  (ctags)
" ============================================================
set tags=./tags,tags;/          " walk up to root looking for tags file

" ============================================================
"  Make / build
" ============================================================
set errorformat=%f:%l:%c:\ %t%*[^:]:\ %m
set makeprg=make

" ============================================================
"  Statusline (no plugin needed)
" ============================================================
set statusline=
set statusline+=\ %f            " relative path
set statusline+=\ %m%r%h%w      " modified / readonly / help / preview flags
set statusline+=%=              " right-align from here
set statusline+=\ %{&filetype}
set statusline+=\ \|\ %{&fileencoding}
set statusline+=\ \|\ %l:%c
set statusline+=\ \|\ %p%%\ 

" ============================================================
"  Netrw (built-in file explorer)
" ============================================================
let g:netrw_banner    = 0
let g:netrw_liststyle = 3       " tree view
let g:netrw_winsize   = 25

" ============================================================
"  Key mappings
" ============================================================
let mapleader = " "

" --- navigation ---
nnoremap <leader>e :Lexplore<CR>            " toggle netrw sidebar
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" --- search ---
nnoremap <leader>h :nohlsearch<CR>          " clear search highlight

" --- build ---
nnoremap <leader>m :make<CR>                " run make
nnoremap <leader>n :cnext<CR>              " next error
nnoremap <leader>p :cprev<CR>              " prev error
nnoremap <leader>q :copen<CR>              " open quickfix

" --- tags ---
nnoremap <leader>] <C-]>                    " jump to definition
nnoremap <leader>[ <C-t>                    " jump back
nnoremap <leader>* :tjump <C-r><C-w><CR>   " list all matches for word

" --- buffers ---
nnoremap <leader>b :buffers<CR>:b<Space>
nnoremap <Tab>     :bnext<CR>
nnoremap <S-Tab>   :bprev<CR>

" --- misc ---
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wa<CR>

" ============================================================
"  Filetype-specific
" ============================================================
augroup c_cpp
    autocmd!
    " switch between .c/.cpp and .h
    autocmd FileType c,cpp nnoremap <buffer> <leader>a
        \ :e %:p:s,.h$,.X123X,:s,.c\(pp\)\=$,.h,:s,.X123X$,.c,<CR>
    " auto-insert include guard on new .h files
    autocmd BufNewFile *.h
        \ let s:guard = toupper(expand('%:t:r')) . '_H' |
        \ call setline(1, ['#ifndef ' . s:guard,
        \                  '#define ' . s:guard, '', '', '',
        \                  '#endif /* ' . s:guard . ' */']) |
        \ normal! 4G
augroup END

" ============================================================
"  Persistent undo
" ============================================================
if has('persistent_undo')
    let &undodir = expand('~/.vim/undodir')
    silent! call mkdir(&undodir, 'p')
    set undofile
    set undolevels=1000
endif

