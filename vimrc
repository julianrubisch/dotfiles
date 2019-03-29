set nocompatible
let mapleader = ","

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

call plug#begin('~/.vim/plugged')
call s:SourceConfigFilesIn('rcplugins')
call plug#end()


" call deoplete#custom#option('complete_function', 'omnifunc')
" call deoplete#custom#source('omni', 'functions', {
" 		    \ 'ruby':  'LanguageClient#complete',
" 		    \ 'javascript': ['tern#Complete', 'jspc#omni', 'LanguageClient#complete']
" 		    \})
" call deoplete#custom#var('omni', 'input_patterns', {
" 		    \ 'ruby': ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']
" 		    \})
" let g:deoplete#enable_at_startup = 1

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

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

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
