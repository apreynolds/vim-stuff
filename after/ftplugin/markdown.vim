"2023-06-08 Key command to open corresponding pdf page (relies on dispatch plugins Start command)
map <leader>vp :Start! open %:r.pdf<CR>
map <leader>vd :Start! open %:r.docx<CR>

map <F9> :Pandoc
map <leader>pp :PandocPDF<CR>
map <leader>pd :PandocDocx<CR>
map <leader>ph :PandocHtml<CR>

"command! -nargs=0 Pandoc write | Start! pandoc --citeproc % -o %:r.pdf 
command! -nargs=0 PandocPDF write | Start! pandoc % -o %:r.pdf 

command! -nargs=0 PandocDocx write | Start! pandoc --citeproc % -o %:r.docx 

command! -nargs=0 PandocHtml write | Start! pandoc --citeproc % -o %:r.html

augroup MARKDOWN
  autocmd!
  autocmd BufWrite *.md PandocPDF
augroup end
