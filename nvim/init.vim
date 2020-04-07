call plug#begin()

" Filebrowsing
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' " Dependency of ranger.vim

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" TypeScript
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'

" Editing
Plug 'kshenoy/vim-signature'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/limelight.vim'
Plug 'Asheq/close-buffers.vim'
Plug 'tpope/vim-surround'

" Color themes
Plug 'gruvbox-community/gruvbox'

" Other stuff
Plug 'mhinz/vim-startify'

call plug#end()

colorscheme gruvbox

" Enable real colors in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Set leader
let mapleader = ","

" Some global configuration stuff
set shell=zsh
set nobackup
set nowritebackup
set noswapfile
set backspace=2   " Backspace deletes like most programs in insert mode
set number
set relativenumber
set cursorline
set list
set listchars=tab:▸\ ,trail:\· " ,space:·
set laststatus=2
set updatetime=250
set tabstop=2
set shiftwidth=2
set expandtab
set nocompatible
set hidden
set hlsearch
set autoread
set scrolloff=8
set smartindent
set cindent
set shortmess+=c
set signcolumn=yes
set mouse=a " enable mouse

filetype plugin on

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Disable case sensitive search
set ignorecase

" Show invisivles
set list
set listchars=tab:»-,trail:·,eol:¬

" Automatically clean trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e


"""" Global keybindings
" Redo with U instead of Ctrl+R
noremap U <C-R>

" invert tab
inoremap <S-Tab> <C-d>

" Save file
nnoremap <leader>w :w<cr>

" jump between buffers
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>

map <Leader>fn :let @+ = expand("%:t") \| echo 'cb> ' . @+<CR>
map <Leader>fp :let @+ = expand("%:p") \| echo 'cb> ' . @+<CR>



"""" FZF config

" Configure grep to use The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Search for tasks across the current project
nnoremap <C-b> :Buffers<cr>

" ignore all from .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'



"""" Grepper
let g:grepper = {
  \ 'tools': ['rg', 'git', 'ag'],
  \ }

command! -nargs=* -complete=file Rg Grepper -noprompt -tool rg -query <args>

nnoremap <leader>g :Grepper<cr>
nnoremap <leader>G :Grepper -tool rg -buffers<cr>
nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>

command! Todo :Grepper -noprompt -tool git -grepprg git grep -nIi '\(TODO\)'
command! Fixme :Grepper -noprompt -tool git -grepprg git grep -nIi '\(FIXME\)'
command! Tofix :Grepper -noprompt -tool git -grepprg git grep -nIi '\(TODO\|FIXME\)'



"""" Ranger
let g:ranger_map_keys = 0
nnoremap <leader>r :Ranger<cr>



"""" Signify
let g:signify_vcs_list = [ 'git' ]



"""" Limelight
let g:limelight_conceal_ctermfg = 240

nmap <leader>L :Limelight!!<cr>



"""" Startify
let g:startify_relative_path = 1
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
let g:startify_update_oldfiles = 1
let g:startify_use_env = 1



"""" COC
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap for rename current word
omap <leader>rn <Plug>(coc-rename)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Jump to diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use Tab to navigate in the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"

" Make codeAction more accessible
command! CodeAction :call CocActionAsync('codeAction', '')

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-stylelint',
  \ ]
