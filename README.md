# Dotfiles backup

Backups of my terminal/vim configuration files. For use with/requires:

- vimtex
- latexmk
- powershell10kzsh (a zshell theme that includes my colorscheme)
- coc.vim
- node.js
- vim.surround
- vim.commentary
- ohmyzshell

Installation of all is relatively straightforward. Only exception was configuring vimtex.
## Files: (leading . removed so they don't stay hidden)
- .vimrc - global vim configurations
- .zshrc - zshell configurations
- p10k.zsh - powershell 10k config
- vim/ftplugin/markdown.vim - markdown specific vim config (must be placed in .vim/ftplugin for vim to find)
- vim/ftplugin/tex.vim - latex specific vim config (must be placed in .vim/ftplugin for vim to find)
- bashscripts/ 
   ├──dtuSCPReceive.sh - quick scp to get file from dtu hpc, requires vpn and directs to [usernumber]/projects as root
   ├──dtuSCPSend.sh - send file to hpc, same as above
   ├──dtu\_SCP\_mirroring\_directory.sh - get file from hpc assuming the directory is the same as home pc (treating postdoc/ as root)
   ├──gather\_fig\_files.sh - take plotting lines from fig.plt files in subdirectories and merge into one in current directory.
   ├──gather\_fig\_files\_from\_subfolders.sh - same as above but assumes files are one folder deeper.
   ├──makeExpDir - read the dir names in the current directory and create exp\_n+1 dir.
   ├──mergeOutput - For HPC experiments, combine the output files into 1 file. Not really used now
   ├──split\_any.sh - take the keywords marking res.dat lines, split them into different files, with subfolders. 
   ├──split\_any\_here.sh - take the keywords marking res.dat lines, split them into different files, without subfolders. 
   ├──split\_many.sh - split many res.dat files using the above files, same arguments. Assumes files live in set1....setn dirs 
   ├──tikzFromFile.sh - take sufficient rows of data from file to new file for tikz plots without getting so much data to crash tikz
   ├──tikzFromMany.sh - take sufficient rows of data from multiple files to new file for tikz plots without getting so much data to crash tikz

