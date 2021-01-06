" general settings:
filetype plugin indent on
set autoindent smartindent
set backspace=indent,eol,start
set clipboard+=unnamedplus
set cmdheight=2 showcmd showmode
set colorcolumn=80
set cursorline
set encoding=utf-8 fileencoding=utf-8 fileformat=unix
set hlsearch incsearch
set laststatus=2
set list listchars=tab:→\ ,trail:•
set magic
set nowrap scrolloff=5 sidescroll=1 sidescrolloff=7
set number relativenumber numberwidth=4
set path+=**
set ruler
set showmatch
set signcolumn=yes
set splitbelow splitright
set termguicolors
set title
set wildmenu
syntax enable

" auto-complete and popup menu related settings:
set complete=.,w,b,u,],kspell
set completeopt=menuone,noselect
set dictionary+=/usr/share/dict/american-english
set nospell spelllang=en_us
set pumheight=10

" autocmd - delete trailing whitespace:
augroup autocmd_delete_whitespace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup end

" python provider settings:
let g:loaded_python_provider = 0
let g:python3_host_prog = '$HOME/.venv/py38nvim/bin/python'

" load plugins:
call plug#begin(stdpath('data') . '/plugged')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }
  Plug 'deoplete-plugins/deoplete-jedi'
  Plug 'deoplete-plugins/deoplete-tag'
  Plug 'deoplete-plugins/deoplete-dictionary'
  Plug 'vim-python/python-syntax'
  Plug 'Shougo/neco-vim'
  Plug 'Yggdroot/indentline'
  Plug 'iamcco/markdown-preview.nvim', {
    \ 'do': { -> mkdp#util#install() },
    \ 'for': ['markdown', 'vim-plug']
    \ }
  Plug 'sindresorhus/github-markdown-css'  " will be used for md preview
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'tpope/vim-sleuth'  " auto-adjusts et, sw, sta, and sts; ts=8
  Plug 'tpope/vim-surround'
  Plug 'morhetz/gruvbox'
  Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
call plug#end()

" plugin settings - deoplete.nvim:
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'max_menu_width', 60)

" plugin settings - LanguageClient-neovim:
set hidden
let g:LanguageClient_hideVirtualTextsOnInsert = 1
let g:LanguageClient_enableExtensions = {
  \ 'python': v:true,
  \ }
let g:LanguageClient_serverCommands = {
  \ 'python': ['$HOME/.venv/py38nvim/bin/pyls'],
  \ }
let g:LanguageClient_showCompletionDocs = 0

" plugin settings - vim-gitgutter:
set updatetime=100
let g:gitgutter_git_executable = '/usr/bin/git'
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_priority = 10
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  if a > 0 || m > 0 || r > 0
    return printf('[+%d ~%d -%d]', a, m, r)
  else
    return ''
  endif
endfunction

" plugin settings - python-syntax:
let g:python_highlight_all = 1

" plugin settings - indentline:
let g:indentLine_char = '¦'

" plugin settings - markdown-preview.nvim:
let g:mkdp_auto_close = 1
let g:mkdp_markdown_css = expand(stdpath('data') .
  \ '/plugged/github-markdown-css/github-markdown.css')
let g:mkdp_refresh_slow = 1

" plugin settings - vim-hexokinase:
let g:Hexokinase_highlighters = [ 'backgroundfull', 'sign_column' ]
let g:Hexokinase_optInPatterns = [
  \ 'full_hex',
  \ 'triple_hex',
  \ 'rgb',
  \ 'rgba',
  \ 'hsl',
  \ 'hsla',
  \ 'colour_names'
  \ ]

" netrw settings:
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
augroup autocmd_netrw
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
augroup end

" statusline settings:
set statusline=
set statusline+=\[%{SleuthIndicator()}]
set statusline+=\ %Y\ %F\ %r%m
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %{GitStatus()}
set statusline+=%=
set statusline+=\ %c,%l/%L\ %p%%
set statusline+=\ [buf:%n]

" function - colors and highlights:
function SetHighlights()
  highlight Comment gui=italic cterm=italic
  highlight PmenuSel guifg=#ffffff ctermfg=white
  highlight StatusLine guifg=#2b3856 ctermfg=darkblue
    \ guibg=#bcc6cc ctermbg=black
  highlight StatusLineNC guifg=#616d7e ctermfg=darkgray
    \ guibg=#000000 ctermbg=gray
  highlight VertSplit guifg=#bcc6cc ctermfg=gray
    \ guibg=NONE ctermbg=NONE
endfunction

" function - toggle background between dark and light:
function ToggleBackground()
  if &background == "dark"
    set background=light
  else
    set background=dark
    highlight Normal guibg=NONE ctermbg=NONE
  endif
  call SetHighlights()
endfunction

" colors and highlights settings - after plugins are loaded:
colorscheme gruvbox
set background=dark
highlight Normal guibg=NONE ctermbg=NONE
call SetHighlights()

" general key mappings:
let mapleader=";"
set timeoutlen=750
nnoremap                <F2>  :source $MYVIMRC<CR>
inoremap   <expr>      <Tab>  pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap   <expr>    <S-Tab>  pumvisible() ? "\<C-P>" : "\<S-Tab>"
nnoremap                   Q  !!sh<CR>
nnoremap                 sc1  :set signcolumn=yes<CR>
nnoremap                 sc2  :set signcolumn=yes:2<CR>
nnoremap                 sc3  :set signcolumn=yes:3<CR>
nnoremap                 scx  :set signcolumn=yes:
nnoremap                 yob  :call ToggleBackground()<CR>
nnoremap                 yoh  :set hlsearch!<CR>
nnoremap                 yol  :set listl!<CR>
nnoremap                 yos  :set spell!<CR>
inoremap          <leader>fn  <C-R>=expand("%:t")<CR>
nnoremap          <leader>bp  ggO#!/usr/bin/env python3<CR>#<Space><C-R>=expand("%:t")<CR><Space>-<Space>

" plugin key mappings - LanguageClient-neovim:
nmap              <leader>l]  <Plug>(lcn-diagnostics-next)
nmap              <leader>l[  <Plug>(lcn-diagnostics-prev)
nmap              <leader>ld  <Plug>(lcn-definition)
nmap              <leader>lf  <Plug>(lcn-format)
nmap              <leader>lp  <Plug>(lcn-hover)
nmap              <leader>lm  <Plug>(lcn-menu)
nmap              <leader>lr  <Plug>(lcn-rename)

" plugin key mappings - vim-gitgutter:
nmap              <leader>g]  <Plug>(GitGutterNextHunk)
nmap              <leader>g[  <Plug>(GitGutterPrevHunk)
nmap              <leader>gp  <Plug>(GitGutterPreviewHunk)
nnoremap                 ygg  :GitGutterToggle<CR>
nnoremap                 ygs  :GitGutterSignsToggle<CR>
nnoremap                 ygh  :GitGutterLineHighlightsToggle<CR>
nnoremap                 ygn  :GitGutterLineNrHighlightsToggle<CR>
nnoremap                 ygf  :GitGutterFold<CR>

" plugin key mappings - indentline:
nnoremap          <leader>ir  :IndentLinesReset<CR>
nnoremap                 yii  :IndentLinesToggle<CR>
nnoremap                 yis  :LeadingSpaceToggle<CR>

" plugin key mappings - markdown-preview.nvim:
nnoremap          <leader>mp  :MarkdownPreview<CR>

" plugin key mappings - vim-hexokinase:
nnoremap                 yhh  :HexokinaseToggle<CR>

" netrw key mappings:
nnoremap                 ynn  :Lexplore<CR>
