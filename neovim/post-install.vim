fun! InitializeSPInitNVim()
  PlugInstall
  echom "Installing Plugins. Will exit automatically."
  sleep 1
  qall
endf

autocmd VimEnter * :call InitializeSPInitNVim()
