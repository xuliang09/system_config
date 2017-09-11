set nocompatible
set number
set relativenumber
set guioptions-=r
set guioptions-=L
set guioptions-=b
set showtabline=0
syntax on
set background=dark
set wrap
set fileformat=unix
set tabstop=4
set shiftwidth=4
set showmatch
set scrolloff=5
set laststatus=2
set fenc=utf-8
set backspace=2
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set matchtime=5
set ignorecase
set incsearch
set hlsearch
set noexpandtab
set whichwrap+=<,>,h,l
set autoread
set cursorline
hi CursorLine  cterm=NONE   ctermfg=green
set showcmd

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
nnoremap <F3> :exe "let HlUnderCursor=exists(\"HlUnderCursor\")?HlUnderCursor*-1+1:1"<CR>

"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype plugin indent on

"fast and correct paste
function! PasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
endfunction
inoremap <special> <expr> <Esc>[200~ PasteBegin()
