map <localleader>vc :Start! open %:r-COMMENTS.pdf <CR>
map <localleader>vi :Start! open %:r-INSTRUCTOR.pdf <CR>
map <localleader>vS :Start! open %:r-STUDENT.pdf <CR>
map <localleader>vs :Start! open %:r-SOLUTIONS.pdf <CR>
map <localleader>vm :Start! open %:r-MARKER.pdf <CR>
map <localleader>vf :Start! open %:r-FIRSTPAGE.pdf <CR>
map <localleader>vh :Start! open %:r.html<CR>

map <F10> :VimtexCompile
map <localleader>LL :call CompileLectures()<CR>
map <localleader>LC :call CompileComments()<CR>
map <localleader>LS :call CompileSolutions()<CR>
map <localleader>LM :call CompileMarkerSolutions()<CR>
map <localleader>LF :call CompileFirstPage()<CR>
map <localleader>LE :call CompileEscape()<CR>

command! -nargs=0 GenerateBasic
      \ Start! latexmk -pdf -pdflatex="pdflatex --shell-escape \%O \%S" %  
      \ && latexmk -c % && 

command! -nargs=0 GenerateInstructor
      \ Start! latexmk -silent -pdf -jobname=%:r-INSTRUCTOR -pdflatex="pdflatex --shell-escape \%O '\def\InstructorNotes{1} \def\Solutions{1} \input{\%S}'" %:r 
      "\ Start! latexmk -silent -pdf -jobname=%:r-INSTRUCTOR -pdflatex="pdflatex --shell-escape \%O \%S" %:r 
      \ && latexmk -c -jobname=%:r-INSTRUCTOR %:r 

command! -nargs=0 GenerateAnnotated
      \ Start! latexmk -silent -pdf -jobname=%:r-ANNOTATED -pdflatex="pdflatex --shell-escape \%O '\def\LectureCopy{1} \input{\%S}'" %:r 
      \ && latexmk -c -jobname=%:r-ANNOTATED %:r 

command! -nargs=0 GenerateComments
      \ Start! latexmk -pdf -jobname=%:r-COMMENTS -pdflatex="pdflatex --shell-escape \%O '\def\Comments{1} \input{\%S}'" % 
      \ && latexmk -c -jobname=%:r-COMMENTS % 

"command! -nargs=0 GenerateStudentCopy
      "\ Start! latexmk -silent -pdf -jobname=%:r-STUDENT -pdflatex="pdflatex --shell-escape \%O '\def\StudentCopy{1} \input{\%S}'" %:r 
      "\ && latexmk -c -jobname=%:r-STUDENT %:r 

command! -nargs=0 GenerateSolutions
      \ Start! latexmk -pdf -jobname=%:r-SOLUTIONS -pdflatex="pdflatex --shell-escape \%O '\def\Solutions{1} \input{\%S}'" % 
      \ && latexmk -c -jobname=%:r-SOLUTIONS % 

command! -nargs=0 GenerateMarker
      \ Start! latexmk -pdf -jobname=%:r-MARKER -pdflatex="pdflatex --shell-escape \%O '\def\Solutions{1} \def\MyComments{1} \input{\%S}'" % 
      \ && latexmk -c -jobname=%:r-MARKER % 

command! -nargs=0 GenerateFirstPage
      \ Start! latexmk -pdf -jobname=%:r-FIRSTPAGE -pdflatex="pdflatex --shell-escape \%O '\def\FirstPageOnly{1} \input{\%S}'" % 
      \ && latexmk -c -jobname=%:r-FIRSTPAGE %

command! -nargs=0 CompileEscape write | Start! latexmk -pdf -pdflatex="pdflatex --shell-escape \%O \%S" % && latexmk -c % 

function! CompileBasic()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateBasic'
      
  execute "lcd " . l:cwd

endfunction

function! CompileComments()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateBasic'
  execute 'GenerateComments'
  execute "lcd " . l:cwd

endfunction

function! CompileInstructor()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateBasic'
  execute 'GenerateInstructor'
  execute "lcd " . l:cwd

endfunction

function! CompileLectures()
  let l:cwd = getcwd()
  lcd %:h
  let l:pdfannotated = expand( '%:r' ) . "-ANNOTATED.pdf"

  execute 'write'
  execute 'GenerateBasic'
  execute 'GenerateInstructor'

  "If filename-ANNOTATED.pdf doesn't exist, generate it:
  if !filereadable(l:pdfannotated)
    execute 'GenerateAnnotated'
  endif

  execute "lcd " . l:cwd

endfunction

function! CompileSolutions()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateBasic'
  execute 'GenerateSolutions'
  execute "lcd " . l:cwd

endfunction

function! CompileMarkerSolutions()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateBasic'
  execute 'GenerateSolutions'
  execute 'GenerateMarker'
  execute "lcd " . l:cwd

endfunction

function! CompileFirstPage()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateFirstPage'
  execute "lcd " . l:cwd

endfunction

"2025-09-10 Keeping the stuff below in for now, but as of today it's probably
"obsolete; I've put this functionality into my bash script sync2onedrive; it
"rsyncs specified PDFs to PDFExpert
"command! -nargs=1 MoveLectures call MoveLecturesFn( <q-args> )
"map <leader>mm1 :call MoveLecturesFn("math1003-2025f-lectures")<cr>
"map <leader>mm2 :call MoveLecturesFn("math2203-2025f-lectures")<cr>


"function! MoveLecturesFn(coursedir)
  "let l:cwd = getcwd()
  "lcd %:h

  "let l:outputdir="/Users/preynol1/pdfexpert/"
  "let l:pdfbasic = expand( '%:r' ) . ".pdf"
  "let l:pdfinstructor = expand( '%:r' ) . "-instructor.pdf"

  "if filereadable(l:pdfbasic)
    "let tempcommand = 'rsync ' . l:pdfbasic . ' ' . l:outputdir . a:coursedir. '/'
    "call system(tempcommand)
  "endif

  "if filereadable(l:pdfinstructor)
    "let tempcommandtwo = 'rsync ' . l:pdfinstructor . ' ' . l:outputdir . a:coursedir. '/'
    "call system(tempcommandtwo)
  "endif

  "execute "lcd " . l:cwd

"endfunction

