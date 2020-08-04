"neovim general configuration
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
set showmatch				" Turn on paren highlighting"
set splitright				" When split - split right
set splitbelow				" When split horizontal - split lower
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let mapleader = " "
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey



"" Move between windows
"nnoremap <leader>h :wincmd h<CR>
"nnoremap <leader>j :wincmd j<CR>
"nnoremap <leader>k :wincmd k<CR>
"nnoremap <leader>l :wincmd l<CR>
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
inoremap <C-l> <C-o>$;<CR>


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
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-rooter'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()


" fzf Config
nnoremap <C-p> <Esc><Esc>:Files<CR>
nnoremap <C-f> <Esc><Esc>:BLines<CR>
nnoremap <C-g> :Rg<CR> 
nnoremap <C-b> :Buffers<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let $FZF_DEFAULT_OPS='--layout=reverse --info=inline'
" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


nnoremap <leader>f <Esc><Esc>:BLines <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>rg <Esc><Esc>:Rg <C-R>=expand("<cword>")<CR><CR>

"coc configuration
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


let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-e> :TmuxNavigatePrevious<cr>

""" Code Navigation
"nmap <leader>gd <Plug>(coc-definition)
"nmap <leader>gy <Plug>(coc-type-definition)
"nmap <leader>gi <Plug>(coc-implementation)
"nmap <leader>gr <Plug>(coc-references)
"nmap <leader>rr <Plug>(coc-rename)
"nmap <leader>g[ <Plug>(coc-diagnostic-prev)
"nmap <leader>g] <Plug>(coc-diagnostic-next)
"nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
"nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
"nnoremap <leader>cr :CocRestart


" Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'

" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

" NerdTree Setup
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
nnoremap <silent> <C-n> :NERDTreeToggle<CR>



" Jeff's cscope settings
if has("cscope")
   " gtags cscope:
   set csprg=gtags-cscope
   set csto=1
   set cst

   " Turn off cscope notification messages so you don't get warnings during
   " vim startup
   set nocsverb

   " Load cscope/gtags.
   " First thing we look for is the GTAGS file in current directory,
   " or parent, or grand parent, ... and include that if found.

   " relies on existence of "findup" script.
   let g:gtagsdir = system("findup GTAGS")
   if !v:shell_error
      execute "cs add ".g:gtagsdir."/GTAGS"
   else
      " Didn't find gtags, do the same search for cscope.out and add if found.
      let g:cscopedir = system("findup cscope.out")
      if !v:shell_error
         set csprg=cscope
         execute "cs add ".g:cscopedir."/cscope.out"
      endif
   endif

   " Turn cscope notification messages back on now that startup is done
   set csverb "is needed?

   " Using 'CTRL-\' then a search type makes the vim window
   " "shell-out", with search results displayed on the bottom

   "nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
   "nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   "nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	
   nmap <leader>gs :cs find s <C-R>=expand("<cword>")<CR><CR> " find C symbol "
   nmap <leader>gg :cs find g <C-R>=expand("<cword>")<CR><CR> " find defintion "
   nmap <leader>gc :cs find c <C-R>=expand("<cword>")<CR><CR> " find functions calling this "
   nmap <leader>gt :cs find t <C-R>=expand("<cword>")<CR><CR> " find this text "
   nmap <leader>ge :cs find e <C-R>=expand("<cword>")<CR><CR> " find this egrep pattern "
   nmap <leader>gf :cs find f <C-R>=expand("<cfile>")<CR><CR> " find this file"
   nmap <leader>gi :cs find i ^<C-R>=expand("<cfile>")<CR><CR> " find files including this one"
   nmap <leader>gd :cs find d <C-R>=expand("<cword>")<CR><CR> " find functions called by this one"


   "" Using 'CTRL-spacebar' then a search type makes the vim window
   "" split horizontally, with search result displayed in
   "" the new window.

   "nmap <C-[>s :scs find s <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[>g :scs find g <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[>c :scs find c <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[>t :scs find t <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[>e :scs find e <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
   "nmap <C-[>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   "nmap <C-[>d :scs find d <C-R>=expand("<cword>")<CR><CR>

   "" Hitting CTRL-space *twice* before the search type does a vertical
   "" split instead of a horizontal one

   "nmap <C-[><C-[>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[><C-[>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[><C-[>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[><C-[>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[><C-[>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-[><C-[>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   "nmap <C-[><C-[>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

   "" Once you've done a cs (cscope) query, if there are multiple tags, F9 goes
   "" to previous, F10 goes to the next one
   nmap <C-[> :tp<CR>
   nmap <C-]> :tn<CR>
endif

function UpdateGtags()
   " See fish_scripts_referenced/gtags_update.fish
   " I have a fish wrapper script to decide exactly how to update gtags.
   " You may want to port that to a bash script and call that here instead
   " of a fish script. Alternatively you can embed the bash script on one
   " line here.
   !bash -c 'gtags_update'
   set nocsverb
   cs reset
   set csverb
endfunction
command Gup call UpdateGtags()


func! DateTag()
    return strftime("*** %Y-%m-%d (%A, %B %e, %Y)\r****")
endfunc
iabbr <expr> dateme DateTag()


func! FixMeTag()
    return "FIXME: [yfogel ".strftime("%Y-%m-%d")."]"
endfunc
iabbr <expr> fixme FixMeTag()



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

