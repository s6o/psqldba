" Ignore vi compatibility
set nocompatible

filetype plugin on

" Basic look&feel
set background=dark
set t_Co=256
let g:solarized_termcolors=256

" Show filename
set title

" Don't wrap lines
set nowrap

" Show line numbers
set number

" Always show status line
set ls=2

" Allow crosshair cursor highlighting.
hi CursorLine   cterm=NONE ctermbg=0
hi CursorColumn cterm=NONE ctermbg=0
set cursorline
set cursorcolumn

" Allow <leader key>c to toggle cursor crosshair
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Searching
set ignorecase
set smartcase
set wrapscan

" Basic autocomplete e.g. filenames
set wildmenu
set wildmode=list:longest,full

" Redraw less, e.g. macros
set lazyredraw

" Highlight matching [({})]
set showmatch

" Show editor mode
set showmode

