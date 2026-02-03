"2019-07-17 Key command to open corresponding html page (relies on dispatch plugins Start command)
map <leader>hh :Start! open %:r.html<CR>

"2023-05-29 ensure that md files are set to markdown filetype; tried placing in vimrc but found it was necessary to place here
au BufNewFile,BufRead,BufWinEnter *.md set filetype=markdown
