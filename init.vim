syntax on
set noerrorbells			"Turns off error sounds
set tabstop=4 softtabstop=4 " Sets the tab size to 4 spaces
set shiftwidth=4 
set smartindent				" smart indenting when possible
set nu						" sets numbers on line to be on
set nowrap					" turns off line wrapping
set smartcase				" if search is all lowercase then ignore case until use upper case letter
set noswapfile				" don't create swap files
set nobackup				" Don't create backup files
set undodir=~/.config/nvim/undodir
set undofile				" use undo files
set incsearch				" Use incremental search
set relativenumber			" relative line numbes
set nohlsearch				" no highlight on search
set mouse=a


" neovim general configuration
set splitright
set splitbelow
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let mapleader = " "

"" Move between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>v :wincmd v<CR>
nnoremap <leader>s :wincmd s<CR>
" terminal navigation
nnoremap <leader>t :split<CR>:res 10<CR>:terminal<CR>
tnoremap <ESC> <C-\><C-n> <CR>
"tnoremap <A-h> <C-\><C-n>  :wincmd h<CR>
"tnoremap <A-j> <C-\><C-n>  :wincmd j<CR>
"tnoremap <A-k>  <C-\><C-n> :wincmd k<CR>
"tnoremap <A-l>  <C-\><C-n>  :wincmd l<CR>

imap jj <ESC>
let loaded_matchparen = 1

"" Move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <silent><S-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><S-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

"" Pane resize
noremap <leader>+ :resize +5<CR>
noremap <leader>- :resize -5<CR>
noremap <leader>< :vertical:resize -5<CR>
noremap <leader>> :vertical:resize +5<CR>

""Buffer control
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

""" set semicolin at end of line
inoremap <C-l> <C-o>$;


"Plugin installation
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-utils/vim-man'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'clangd/coc-clangd'
Plug 'airblade/vim-rooter'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()


" ripgrep configuration
"let g:rg_command = 'rg --vimgrep -S' " enables smartcasing in ripgrep
"if executable('rg')
"	let g:rg_derive_root='true'
"endif


" fzf Config
nnoremap <C-p> <Esc><Esc>:Files!<CR>
nnoremap <C-f> <Esc><Esc>:BLines<CR>
nnoremap <C-g> :Rg<CR> 
nnoremap <C-b> :Buffers<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" coc configuration
"" Tab Completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"" Code Navigation
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart


" Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'


"One dark setup
" g:onedark_terminal_italics=1
" colorscheme onedark

" Gruvbox setup
"let g:gruvbox_italic=1
"let g:gruvbox_bold=1
"let g:gruvbox_contrast_dark='medium' "soft medium hard
"set background=dark
"colorscheme gruvbox

"set background=light
"let g:one_allow_italics=1
"colorscheme one


"set termguicolors
"let ayucolor="dark"
"colorscheme ayu
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

let g:palenight_terminal_italics=1
set background=dark
colorscheme palenight


" NerdTree Setup
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
