
" default state
set nocompatible
set modelines=0 enc=utf-8 ffs=unix
set ts=4 sw=4 sts=4 shiftround
set autoindent smartindent
set showmode showcmd laststatus=2
set hidden nowrap number ruler cursorline
set ignorecase smartcase hlsearch incsearch showmatch scrolloff=3
set backspace=indent,eol,start
set ttyfast lazyredraw vb
set wildmenu wildmode=list:longest
set foldmethod=syntax foldlevelstart=20
set nobackup noswapfile
silent! set undodir=$HOME/.vim/undo undolevels=1000 undoreload=10000 undofile

" set color scheme
set background=dark
silent! colorscheme vividchalk

" set leader-key to comma
let mapleader=","

" clear search
nnoremap <leader><space> :noh<cr>

" remap inconvenient keys
inoremap <f1> <esc>
nnoremap <f1> <esc>
vnoremap <f1> <esc>

" shortcut ; to : for less keys
nnoremap ; :

" toggle paste mode with F2
set pastetoggle=<leader>p

" quickly edit/reload the vimrc file (,ev or ,sv)
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" shortcut to force permissions
cmap w!! w !sudo tee > /dev/null %

" disable noise makers
set noeb vb t_vb=

" auto syntax highlighting and fold-settings
filetype on
syntax on
filetype indent on
filetype plugin on
set foldmethod=syntax

" define highlight for bad formatting
highlight BadWhitespace ctermbg=red guibg=red

" define au-group to prevent stacking execution
augroup cureall
	" clear group
	au!

	" add markdown file recognition
	au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=markdown

	" missing syntax recognition
	au BufRead,BufNewFile *.py match BadWhitespace /*\t\*/
	au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/

	" remove trailing whitespace automatically on save
	au BufWritePre * :%s/\s\+$//e

	" remove windows carriage returns automatically
	au BufWritePre * :%s/\r//e
augroup END

" tab autocompletion
function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<c-n>"
	else
		return "\<tab>"
	endif
endfunction
inoremap <tab> <c-r>=Tab_Or_Complete()<cr>
set dictionary="/usr/share/dict/words"

" load plugins
silent! set runtimepath^=$HOME/.vim/bundle/ctrlp.vim
silent! helptags $HOME/.vim/doc
