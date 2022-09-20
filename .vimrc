" enable syntax highlight
syntax on

" enable line number
set number

" disable softtabstop
set softtabstop=0

" set ignorecase and smartcase
set ignorecase
set smartcase

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'frazrepo/vim-rainbow'
" Plug 'majutsushi/tagbar'
" Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
" Plug 'othree/html5.vim'
Plug 'kien/ctrlp.vim'
Plug 'ap/vim-css-color'
" Plug 'posva/vim-vue'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'flw-cn/vim-nerdtree-l-open-h-close'
" Plug 'liuchengxu/vista.vim'

Plug 'haishanh/night-owl.vim'
Plug 'lilydjwg/colorizer'
" Plug 'ParamagicDev/vim-medic_chalk'
" Plug 'liuchengxu/space-vim-dark'

call plug#end()

" vista
" ======================================================================
" function! NearestMethodOrFunction() abort
  " return get(b:, 'vista_nearest_method_or_function', '')
" endfunction

" set statusline+=%{NearestMethodOrFunction()}

  " By default vista.vim never run if you don't call it explicitly.
  " "
  " " If you want to show the nearest function in your statusline
  " automatically,
  " " you can add the following line to your vimrc
  " autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" tagbar
" ======================================================================
" nmap <F8> :TagbarToggle<CR>
" let g:tagbar_type_json = {
    " \ 'ctagstype' : 'json',
    " \ 'kinds' : [
      " \ 'o:objects',
      " \ 'a:arrays',
      " \ 'n:numbers',
      " \ 's:strings',
      " \ 'b:booleans',
      " \ 'z:nulls'
    " \ ],
  " \ 'sro' : '.',
    " \ 'scope2kind': {
    " \ 'object': 'o',
      " \ 'array': 'a',
      " \ 'number': 'n',
      " \ 'string': 's',
      " \ 'boolean': 'b',
      " \ 'null': 'z'
    " \ },
    " \ 'kind2scope': {
    " \ 'o': 'object',
      " \ 'a': 'array',
      " \ 'n': 'number',
      " \ 's': 'string',
      " \ 'b': 'boolean',
      " \ 'z': 'null'
    " \ },
    " \ 'sort' : 0
    " \ }

" vim-rainbow
" ======================================================================
let g:rainbow_active = 1

" CtrlSF
" ======================================================================
" nmap <C-f> <Plug>CtrlSFPrompt

" airline
" ======================================================================
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols_ascii = 1

" space-vim-dark config
" ======================================================================
colorscheme night-owl
syntax enable
set t_ut=""
hi Comment    guifg=#5C6370 ctermfg=59
if (has("termguicolors"))
  set termguicolors
endif

" vim-commentary config
" ======================================================================
if has('win32')
  nmap <C-/> gc
  vmap <C-/> gc
else
  nmap <C-_> gc
  vmap <C-_> gc
endif

" NERDTree config
" ======================================================================
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules']
let NERDTreeMapOpenInTab='<C-o>'
let g:NERDTreeMapOpenDirNode = 'l'
let g:NERDTreeMapCloseDirNode = 'h'

" ctrlp config
" ======================================================================
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Coc config
" ======================================================================
" Language servers
" let g:LanguageClient_serverCommands = {
  " \ 'vue': ['vls']
  " \ }

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" if has('patch8.1.1068')
  " " Use `complete_info` if your (Neo)Vim version supports it.
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
  " imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Move line up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Keep center when search
nnoremap n nzzzv
nnoremap N Nzzzv


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
"
"
" Fix vim start in replace mode
nnoremap <esc>^[ <esc>^[

