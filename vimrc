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

nnoremap <Leader>p :call ParallelRspecRails()<CR>
nnoremap <Leader>pr :call ProntoRails('origin/dev')<CR>
nnoremap <Leader>af :call ALEFix<CR>

" commands
command! -nargs=1 Pronto call g:ProntoRails(<f-args>)
