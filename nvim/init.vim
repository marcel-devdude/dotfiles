call plug#begin()

" Filebrowsing
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
"Plug 'francoiscabrol/ranger.vim'
Plug 'kevinhwang91/rnvimr'
Plug 'rbgrouleff/bclose.vim' " Dependency of ranger.vim

" Git
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'mhinz/vim-signify'

" TypeScript
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'evanleck/vim-svelte'

" Editing
Plug 'kshenoy/vim-signature'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/limelight.vim'
Plug 'Asheq/close-buffers.vim'
Plug 'tpope/vim-surround'
Plug 'mustache/vim-mustache-handlebars'
Plug 'sheerun/vim-polyglot'
Plug 'pantharshit00/vim-prisma'
Plug 'jparise/vim-graphql'

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
" let mapleader = ","
let mapleader = "\<Space>"

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

" Do not yank the visual selection when pasting
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>

" Move the selections up and down with corresponding indentation
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv


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

command! PFiles :GFiles --exclude-standard --others --cached
nnoremap <leader>p :PFiles<cr>


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
" let g:ranger_map_keys = 0
" nnoremap <leader>r :Ranger<cr>
nnoremap <leader>r :RnvimrToggle<CR>

" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine

" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-v>': 'NvimEdit vsplit'
            \ }



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
nmap <leader>n <Plug>(coc-rename)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Jump to diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use Tab to navigate in the completion list
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"

" Use Tab to trigger completition
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
  \ 'coc-css',
  \ 'coc-prisma',
  \ 'coc-graphql',
  \ ]
