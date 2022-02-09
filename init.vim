" _   _ _                 ___ _____
"| \ | | |__   __ _ _ __ |_ _|_   _|
"|  \| | '_ \ / _` | '_ \ | |  | |
"| |\  | | | | (_| | | | || |  | |
"|_| \_|_| |_|\__,_|_| |_|___| |_|
"
"
""""""""""""""""""""""""""""""""""""""""""""

call plug#begin("~/AppData/Local/nvim/plugged")

"{ Theme }"
	Plug 'overcache/NeoSolarized'									" Vim theme

"{ Status bar }"
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

"{ Transparent Background }"
	Plug 'xiyaowong/nvim-transparent'

"{ File browser }"
	Plug 'preservim/nerdTree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'unkiwii/vim-nerdtree-sync' 

"{ Code intellegence }"
	Plug 'neoclide/coc.nvim', {'branch': 'release'} 			" Language server 
	Plug 'jiangmiao/auto-pairs' 								" Parenthesis auto 
	Plug 'alvan/vim-closetag'									" Vim auto close tag
	Plug 'mattn/emmet-vim' 										" Nerd commenter
	Plug 'preservim/nerdcommenter' 								" Comment code 
	Plug 'liuchengxu/vista.vim' 								" Function tag bar 
	Plug 'alvan/vim-closetag' 									" Auto close HTML/XML tag 
	Plug 'kiteco/vim-plugin'

"{ Finder }"
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

"{ Syntax Highlight }"
	Plug 'yuezk/vim-js' 										" Javascript
	Plug 'MaxMEllon/vim-jsx-pretty' 							" JSX/React
	Plug 'vim-python/python-syntax'
	Plug 'jackguo380/vim-lsp-cxx-highlight'						" C++ syntax

"{ Terminal }"
	Plug 'voldikss/vim-floaterm'

"{ Debugging }"
	Plug 'puremourning/vimspector' 					" Vimspector

"{ Source code version control }"
	Plug 'tpope/vim-fugitive' 						" Git

"{ Extensions }"
"...

call plug#end()


"{ Vim-Pluggin settings }"


"{ Vim-Airline Pluggin Settings }"
let g:airline_powerline_fonts=1 							" Enable font for status bar
let g:airline_theme='onedark' 								" Theme OneDark
let g:airline#extensions#tabline#enabled=1 				" Enable Tab bar
let g:airline#extensions#tabline#left_sep=' ' 			" Enabl Tab seperator 
let g:airline#extensions#tabline#left_alt_sep=' ' 		" Enable Tab seperator
let g:airline#extensions#tabline#formatter='default'
let g:airline#extensions#tabline#fnamemod=':t' 			" Set Tab name as file name
let g:airline#extensions#whitespace#enabled=0
let g:transparent_enabled=v:true
"{ End Vim-Airline Plugin Settings }"


"{ General Settings }"
set mouse=a
"Indent
	set tabstop=3  
	set softtabstop=3
	set shiftwidth=3
	set autoindent
	set smartindent
"Neovim config
	set number
	set ignorecase
	set termguicolors
	set laststatus=2
	set cursorline
	set noshowmode
	set encoding=utf-8
	set showmatch
	set wildmenu
	set showtabline=1
"Backup options
	set nobackup
	set nowb
	set noswapfile
"Folding 
	set foldenable
	set foldlevelstart=10
	set foldmethod=indent

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "Disable automatically comment in new line

au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime 
		\ | endif
autocmd FileChangedShellPost *
		\ echohl WarningMsg 
		\ | echo "File changed on disk. Buffer reloaded."
		\ | echohl None

for setting_file in split(glob(stdpath('config').'/settings/*.vim'))
	execute 'source' setting_file
endfor
"{ End General Settings }"


"{ Mapping Key Binding }"
map <silent> <C-k> :bp<CR>
map <silent> <C-l> :bn<CR>
"{ End Mapping Key Binding }"


"{ Colorscheme }"
	let g:neosolarized_contrast="normal"
	let g:neosolarized_visibility="normal"
	let g:neosolarized_vertSplitBgTrans=1
	let g:neosolarized_bold=1
	let g:neosolarized_underline=1
	let g:neosolarized_italic=0
	let g:neosolarized_termBoldAsBright=1
	let g:solarized_termcolors=256
	let g:neosolarized_termtrans=1
	colorscheme NeoSolarized
"{ End ColorScheme }"


"{ Transparent Background Settings }"
if exists('g:loaded_transparent') | finish | endif
let g:loaded_transparent = 1
augroup transparent
    autocmd!
    autocmd VimEnter,ColorScheme * lua require('transparent').clear_bg()
    command -bar -nargs=0 TransparentEnable lua require('transparent').toggle_transparent(true)
    command -bar -nargs=0 TransparentDisable lua require('transparent').toggle_transparent(false)
    command -bar -nargs=0 TransparentToggle lua require('transparent').toggle_transparent()
augroup END
"{ End Transparent Background Settings }"


"{ Python Syntax }"
let g:python_highlight_all = 1
syntax on
"{ End Python Syntax }"


"{ Enable copy from outer source }"
if has('win32')
	set clipboard=unnamed
else
	set clipboard=unnamedplus
endif
"{ End Copying }"


"{ NerdTree Pluggin Settings }"
map <silent> <F6> :NERDTreeToggle<CR>
autocmd BufEnter if tabpagenr('$') == 1 && winnr('$' == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"let NERDTreeMapOpenInTab='<ENTER>'
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
				\ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let g:nerdtree_sync_cursorline = 1
"{ End NerdTree Pluggin Settings }"


"{ Coc Plugin Settings }"
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"{ End Coc Plugin Settings }"


"{ Terminal Plugin Settings}"
"let g:floaterm_keymap_new    = '<F8>'
"let g:floaterm_keymap_prev   = '<F9>'
"let g:floaterm_keymap_next   = '<F10>'
"let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_position = 'topright'
let g:floaterm_width = 0.6
let g:floaterm_height = 0.6
let g:floaterm_title = 'Terminal $1/$2'
let g:floaterm_wintype = 'float'
let g:floaterm_rootmarkers = ['.pro']
if has('win32')
	let g:floaterm_shell = 'powershell -nologo'
endif

" Set color
hi Floaterm guibg=Grey15
hi FloatermBorder guifg=Orange guibg=DarkGreen
"hi FloatermNC guibg=darkred


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hotkey to manage terminals
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open a new terminal 
nnoremap <silent>  <F7>      :FloatermNew<CR>
tnoremap <silent>  <F7>      <C-\><C-n>:FloatermNew<CR>

" Kill current terminal 
nnoremap <silent> 	<F12> 		:FloatermKill<CR>:FloatermPrev<CR>
tnoremap <silent> 	<F12> 		<C-\><C-n>:FloatermKill<CR>:FloatermPrev<CR>

" Navigation next and previous terminal 
nnoremap <silent> 	<F9> 		:FloatermNext<CR>
tnoremap <silent> 	<F9> 		<C-\><C-n>:FloatermNext<CR>
nnoremap <silent> 	<F10> 		:FloatermPrev<CR>
tnoremap <silent> 	<F10> 		<C-\><C-n>:FloatermPrev<CR>

" Toggle terminal
nnoremap <silent> 	<leader>tt 		:FloatermToggle<CR>
tnoremap <silent> 	<leader>tt 		<C-\><C-n>:FloatermToggle<CR>

" Focus terminal 
nnoremap <silent> 	<leader>tf 		<C-\><C-n><C-W><Left>
tnoremap <silent> 	<leader>tf 		<C-\><C-n><C-W><Left>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hotkey to run other console apps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git 
nnoremap   <F8>    :FloatermNew --position=bottomleft --height=0.8 --width=0.6 --title='Git' lazygit<CR>
"{ End Terminals Plugin Settings }"
