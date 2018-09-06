" svn-blame - Show SVN blame annotation for the current file.
" Maintainer:   Paul Nechifor <paul@nechifor.net>
" Version:      0.1
"
" This was originally copied from here:
" https://svn.apache.org/repos/asf/subversion/trunk/contrib/client-side/vim/vim-blame.vimrc

if exists("g:loaded_svnblame") || &cp || v:version < 700
  finish
endif
let g:loaded_svnblame = 1

function! s:svnBlame()
  let line = line(".")
  setlocal nowrap

  " Create a new window at the left-hand side.
  aboveleft 18vnew

  " Blame, ignoring white space changes.
  %!svn blame -x-w "#"
  setlocal nomodified readonly buftype=nofile nowrap winwidth=1
  setlocal nonumber
  if has('&relativenumber') | setlocal norelativenumber | endif

  " Return to original line.
  exec "normal " . line . "G"

  " Synchronize scrolling, and return to original window.
  setlocal scrollbind
  wincmd p
  setlocal scrollbind
  syncbind
endfunction
command Blame call s:svnBlame()
