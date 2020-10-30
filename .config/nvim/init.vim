" https://www.reddit.com/r/neovim/comments/3z6c2i/how_does_one_install_vimplug_for_neovim/
" https://github.com/junegunn/vim-plug
" https://devhints.io/vimscript
"" https://learnvimscriptthehardway.stevelosh.com/

function! Isvimpluginstalled() 
    if empty(glob("~/.config/nvim/autolaod/plug.vim"))
        return v:false
    endif
    return v:true
endfunction 


"if isvimpluginstalled()
if v:true
    call plug#begin('~/.config/nvim/plugged/')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'dense-analysis/ale'
    Plug 'nanotech/jellybeans.vim'
    Plug 'vifm/vifm.vim'
    Plug 'ap/vim-buftabline'
    Plug 'raimondi/delimitmate'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'junegunn/vim-peekaboo'
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'edkolev/promptline.vim'
    Plug 'tpope/vim-dispatch'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'mhinz/vim-rfc'

    if has('nvim')
		"plug 'shougo/deoplete.nvim', { 'do': ':updateremoteplugins' }
		Plug 'radenling/vim-dispatch-neovim'
		Plug 'radenling/vim-dispatch-neovim'
    else
		Plug 'shougo/deoplete.nvim'
		Plug 'roxma/vim-hug-neovim-rpc'
    endif

    call plug#end()
endif

" enable provider
if !has('python3')
    :! python3 -m pip install --user --upgrade pynvim
endif

let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_python_provider = 0	" disable python2 support

" ALE
" TODO: Fix Python gotodef: https://github.com/dense-analysis/ale/issues/2231
let g:ale_cpp_ccls_init_options = {
	    \   'cache': {
	    \       'directory': '/tmp/ccls/cache'
	    \   }
	    \ }

" ALE keybindings
nn <silent> <C-d> :ALEGoToDefinition<cr>
nn <silent> <C-r> :ALEFindReferences<cr>
nn <silent> <C-a> :ALESymbolSearch<cr>
nn <silent> <C-h> :ALEHover<cr>

" deoplete
"call deoplete#custom#option('sources', {'_': ['ale'],})
let g:ale_completion_enabled = 1
let g:deoplete#enable_at_startup = 1


" autocomplete using ALE: https://vimawesome.com/plugin/ale
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_autoimport = 1
nnoremap gd :ALEGoToDefinition<cr>


" colorscheme
colorscheme jellybeans
let g:jellybeans_overrides = {
			\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
			\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
			\              'attr': 'bold' },
			\    'Comment': { 'guifg': 'cccccc' },
			\}

" airline themeing
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'


" vim-peekaboo
" register: https://medium.com/vim-drops/vim-registers-the-powerful-native-clipboard-19b1c97891bd
let g:peekaboo_window = 'vert bo 60new'


" vim latex: https://vimawesome.com/plugin/vim-latex-live-preview
" issue TODO: https://github.com/xuhdev/vim-latex-live-preview/issues/105
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'texlive' 
let g:livepreview_cursorhold_recompile = 0

autocmd Filetype tex setl updatetime=1
nnoremap <C-P> :LLPStartPreview

" vim RFC
nnoremap <C-R> :RFC

" vim settings
filetype indent on
syntax on

set history=1000
set encoding=UTF-8
set shiftwidth=4
set backspace=indent,eol,start
set fileformats=unix,dos,mac
set conceallevel=0		"do not hide markdwon

set ruler
set relativenumber
set noerrorbells
set title
set autowrite 			"autosave bevore other actions
set noshowmode
set incsearch                   ""
set hlsearch                    " search options
set ignorecase                  "
set smartcase			""

if has('mouse')
  set mouse=a
endif


" key bindings
set hidden
inoremap jk <esc>
nnoremap <C-N> :bnext<CR>
nnoremap <C-B> :bprev<CR>


" compile and run code support for
" { c, c++, python, sh, bash }
function Compile()
	if (!filereadable(".ccls-root"))
	    silent :!touch ".ccls-root"
	endif

	if (filereadable("Makefile") || filereadable("makefile"))
	    silent :! make
	elseif (filereadable("CmakeLists.txt"))
	   if (isdirectory("build"))
	       :! cmake . && cmake --build . && ./build/*
	    endif
	elseif(&ft == 'c' || &ft == 'cpp' || &ft == 'cc')
	    "let l:tmp=system(")
	    "":! gcc % -o $("date +\"vim_autoc_%d_%m_%Y_%s\"") && ./$("date +\"vim_autoc_%d_%m_%Y_%s\"")
	    silent :! g++ % -o gcc_vimauto && ./gcc_vimauto	    
	elseif(&ft == 'python')
	    :% w ! python
	elseif(&ft == 'sh' || &ft == 'bash' || ft == 'zsh')
	    :% w ! sh
	else
	    ! echo "[+] Makefile not found"
	endif
endfunction


nnoremap <C-C> :call Compile()
