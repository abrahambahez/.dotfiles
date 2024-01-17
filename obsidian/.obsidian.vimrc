" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
" I like using H and L for beginning/end of line
nmap H ^
nmap L $

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

"map obs commands after space
unmap <Space>

exmap focus obcommand obsidian-focus-mode:toggle-focus-mode
nmap <Space>f :focus

exmap task obcommand obsidian-shellcommands:shell-command-go7h3xk84r
nmap <Space>t :task
