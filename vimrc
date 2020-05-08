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

if !has('nvim')
  Plug 'rhysd/vim-healthcheck'
endif
call plug#end()

" if (has("termguicolors"))
"   set termguicolors
" endif

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

syntax on
color night-owl
set number
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set foldmethod=indent
set foldlevel=20
set shell=/bin/bash
set redrawtime=10000 
set clipboard=unnamed
hi Visual term=reverse cterm=reverse guibg=Gray
hi StatusLine ctermbg=3 ctermfg=Black


inoremap <C-@> <C-x><C-o>

nmap <leader>vr :sp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>tc :sp ~/.tmux.conf<cr>
imap <C-s> <esc>:w<cr>

set encoding=utf8

function! ParallelRspecRails()
  execute '!env CAPYBARA_DRIVER=headless_chrome bin/rails parallel:spec'
endfunction

function! ProntoRails(branch)
  execute '!bundle exec pronto run -c=' . a:branch
endfunction

function! RemoveFocus()
  execute '%s/, focus: true//g'
endfunction

nnoremap <Leader>p :call ParallelRspecRails()<CR>
nnoremap <Leader>pr :call ProntoRails('origin/dev')<CR>
nnoremap <Leader>af :ALEFix<CR>
nnoremap <Leader>rg :Rg<CR>

" commands
command! -nargs=1 Pronto call g:ProntoRails(<f-args>)
command! RemoveFocus call g:RemoveFocus()
command! -bang -nargs=1 Be execute 'Dispatch<bang> bundle exec ' . <f-args>
command! Bi execute 'Dispatch bundle install'
