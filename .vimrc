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
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'pprovost/vim-ps1'
Plug 'vim-scripts/cmdalias.vim'
call plug#end()

packloadall

set hidden
set encoding=utf-8 nobomb

"let g:python_recommended_style = 0

set noexpandtab
set tabstop=4
set shiftwidth=4
set smartindent
set pastetoggle=<leader>p

"
" Visual
"

colorscheme codedark
set number
set background=dark
highlight LineNr ctermfg=darkgrey
highlight EndOfBuffer ctermfg=bg ctermbg=bg
set scrolloff=1
set laststatus=2
set fillchars+=vert:\│
set noshowmode
set title
" thin cursor in insert mode, doesn't work in some terminals, taken from https://stackoverflow.com/a/33284744/
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode

set history=100
set mouse=a

set splitbelow
if exists('&termwinsize')
	set termwinsize=12x0
elseif exists('&termsize')
	set termsize=12x0
else
	" Neovim
	command Terminal new +resize12 term://$SHELL
	au VimEnter * call CmdAlias('terminal', 'Terminal')
	au VimEnter * call CmdAlias('term', 'Terminal')
	au TermOpen * setlocal nonumber norelativenumber
	au BufWinEnter,WinEnter term://* startinsert
	tnoremap <Esc> <C-\><C-n>
endif

"
" Autocompletion
"

let g:asyncomplete_auto_popup = 1
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

"
" NERDTree
"

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

set t_u7=  " Fix starting in replace mode in wsl, https://superuser.com/a/1525060/

