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
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
call vundle#end()
filetype plugin indent on

map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
let NERDTreeShowBookmarks=1
let NERDTreeMapToggleHidden=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeWinSize=25

let g:indentLine_char='┆'
let g:indentLine_enabled = 1

let mapleader='SPC'
nmap <F4> <leader>ci

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linu
let g:ctrlp_custom_ignore = 'v[/].(git|hg|svn|pyc|so|swp|zip)$'

let g:EasyMotion_smartcase = 1
map <Leader>jj <Plug>(easymotion-s)
map <leader>. <Plug>(easymotion-repeat)

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


"fast and correct paste
function! PasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
endfunction
inoremap <special> <expr> <Esc>[200~ PasteBegin()


" use 256 colors in terminal
if !has("gui_running")
    set t_Co=256
    set term=screen-256color
endif

" fix cursor display in cygwin
if has("win32unix")
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endif
