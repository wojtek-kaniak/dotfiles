set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'itchyny/lightline.vim'
Plug 'pacha/vem-tabline'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-fugitive'
Plug 'OmniSharp/Omnisharp-vim'
Plug 'nickspoons/vim-sharpenup'
call plug#end()

set hidden
set encoding=utf-8 nobomb

let g:python_recommended_style = 0

set noexpandtab
set tabstop=4
set shiftwidth=4
set smartindent
set pastetoggle=<leader>p

colorscheme codedark
set number
highlight LineNr ctermfg=darkgrey
highlight EndOfBuffer ctermfg=bg ctermbg=bg
set scrolloff=1
set laststatus=2
set fillchars+=vert:\│
set noshowmode
set title

set history=100
set mouse=a

set splitbelow
set termsize=12x0

let NERDTreeMinimalUI=1

autocmd VimEnter * silent NERDTree | wincmd p
autocmd TabEnter * silent exe MirrorNerdTreeIfOneWindow()
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


function MirrorNerdTreeIfOneWindow()
	if winnr("$") < 2
		NERDTreeMirror
		wincmd p
		wincmd l
	endif
endfunction

augroup filetype_nerdtree
	au!
	au FileType nerdtree call s:disable_lightline_on_nerdtree()
	au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END
fu s:disable_lightline_on_nerdtree() abort
	let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
	call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu

