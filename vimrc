let mapleader = ","

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-sensible'
Plug 'julianrubisch/vim-rspec'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'slim-template/vim-slim'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'

" File browsing
Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'w0rp/ale'

Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" Plug 'thinca/vim-ref'
" Plug 'kbrw/elixir.nvim', { 'do': 'yes \| ./install.sh' }

Plug 'itchyny/lightline.vim'

Plug 'maximbaz/lightline-ale'

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'ngmy/vim-rubocop'
Plug 'janko-m/vim-test'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

" Themes
Plug 'rakr/vim-two-firewatch'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'cocopon/iceberg.vim'
Plug 'joshdick/onedark.vim'

" Dev Icons
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'

" Testing
Plug 'junegunn/vader.vim'

" Fuzzy File Finding
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Close delimiters automatically
Plug 'Raimondi/delimitMate'
call plug#end()


call deoplete#custom#option('complete_function', 'omnifunc')
call deoplete#custom#source('omni', 'functions', {
		    \ 'ruby':  'LanguageClient#complete',
		    \ 'javascript': ['tern#Complete', 'jspc#omni', 'LanguageClient#complete']
		    \})
call deoplete#custom#var('omni', 'input_patterns', {
		    \ 'ruby': ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']
		    \})
let g:deoplete#enable_at_startup = 1

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

syntax on
color dracula
set number
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set foldmethod=indent
set foldlevel=20
set shell=/bin/bash
hi Visual term=reverse cterm=reverse guibg=Gray
hi StatusLine ctermbg=3 ctermfg=Black

let g:rspec_command = "!bin/rspec {spec}"

let g:LanguageClient_autoStop = 0
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'css': ['css-languageserver', '--stdio'],
    \ 'scss': ['css-languageserver', '--stdio'],
    \ 'sass': ['css-languageserver', '--stdio'],
    \ 'less': ['css-languageserver', '--stdio'],
    \ 'html': ['html-languageserver', '--stdio'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'elixir': ['~/Documents/_CODE/util/elixir-ls/bin/language_server.sh'],
    \ 'ruby': ['solargraph', 'stdio']
    \ }
let g:LanguageClient_windowLogMessageLevel = "Error"

let g:ale_linters = {
\   'css': ['csslint'],
\   'elixir': ['mix'],
\   'javascript': ['prettier', 'eslint'],
\   'ruby': ['rubocop'],
\   'scss': ['sasslint']
\}

let g:ale_lint_on_text_changed = 0

let g:ale_fixers = {
\   'css': ['csslint'],
\   'elixir': ['mix_format'],
\   'javascript': ['prettier', 'eslint'],
\   'ruby': ['rubocop'],
\   'scss': ['sasslint']
\}

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <buffer>
  \ <leader>sf :call LanguageClient#textDocument_documentSymbol()<cr>

" autocmd FileType ruby setlocal omnifunc=LanguageClient#complete

inoremap <C-@> <C-x><C-o>

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

nmap <leader>vr :sp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>tc :sp ~/.tmux.conf<cr>
imap <C-s> <esc>:w<cr>

" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup

set encoding=utf8

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat'
      \ },
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }


function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! ParallelRspecRails()
  execute '!env CAPYBARA_DRIVER=headless_chrome bin/rails parallel:spec'
endfunction

function! ProntoRails(branch)
  execute '!bundle exec pronto run -c=' . a:branch
endfunction

nnoremap <Leader>p :call ParallelRspecRails()<CR>
nnoremap <Leader>pr :call ProntoRails('origin/dev')<CR>
nnoremap <Leader>af ALEFix<CR>

map <C-n> :NERDTreeToggle<CR>
" map <C-n> f :NERDTreeFind<cr>

" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|tmp)$',
"   \ }
" let g:ctrlp_clear_cache_on_exit = 0

" FZF mappings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nmap <leader>f :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" commands
command! -nargs=1 Pronto call g:ProntoRails(<f-args>)