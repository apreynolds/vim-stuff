map <leader>vf :Start! open %:r_chart.pdf <CR>
map <leader>vc :Start! open %:r_chords.pdf <CR>
map <leader>vl :Start! open %:r_lyrics.pdf <CR>
map <leader>vo :Start! open %:r_outline.pdf <CR>

"(remember that vimtex maps <leader>ll to compilation)
"map <F12> :CompileSong

" NOTES 2024-11-25. While latexmk does have a -cd option to compile in current
" directory, it seems to not play well with using jobname=%:r. Perhaps this is
" just a quirk of calling latexmk from within vim, in a directory other than
" that of the tex file (I used to use autochdir, but stopped doing so for
" other reasons related to workflow and using fzf).
"
command! -nargs=0 Songbook call SongbookFn()

function! SongbookFn()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateBasic'
  execute 'GenerateChart'
  execute 'GenerateOutline'
  execute 'GeneratePhone'

  let l:outputdir="/Users/preynol1/PDFExpert/Documents/songbooks"
  let l:basename = expand( '%:r' )
    echo l:outputdir
    echo l:basename

    let tempcommand = 'rsync ' . l:basename . '*.pdf ' . l:outputdir . '/'
    echo tempcommand 
    call system(tempcommand)

  execute "lcd " . l:cwd

endfunction

command! -nargs=0 SongBasicChartPhone call SongChartPhoneFn()

function! SongBasicChartPhoneFn()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateBasic'
  execute 'GenerateChart'
  execute 'GeneratePhone'
  execute "lcd " . l:cwd

endfunction

command! -nargs=0 SongBasicChartOutlinePhone call SongChartOutlinePhoneFn()

function! SongBasicChartOutlinePhoneFn()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateBasic'
  execute 'GenerateChart'
  execute 'GenerateOutline'
  execute 'GeneratePhone'
  execute "lcd " . l:cwd

endfunction

command! -nargs=0 SongChartChords call SongChartChordsLyricsFn()

function! SongChartChordsFn()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateChart'
  execute 'GenerateChords'
  execute "lcd " . l:cwd

endfunction

command! -nargs=0 SongChartChordsLyrics call SongChartChordsLyricsFn()

function! SongChartChordsLyricsFn()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateChart'
  execute 'GenerateChords'
  execute 'GenerateLyrics'
  execute "lcd " . l:cwd

endfunction

command! -nargs=0 SongGray call SongGrayFn()

function! SongGrayFn()
  let l:cwd = getcwd()
  lcd %:h

  execute 'write'
  execute 'GenerateChartGray'
  execute 'GenerateChordsGray'
  execute "lcd " . l:cwd

endfunction


command! -nargs=0 GenerateBasic
      \ Start! latexmk -pdf -pdflatex="pdflatex \%O \%S" %  
      \ && latexmk -c % && 

command! -nargs=0 GeneratePhone
  \ Start! latexmk -pdf -jobname=%:r_phone -pdflatex="pdflatex --shell-escape \%O '\def\Longpaper{1} \input{\%S}'" % 
  \ && latexmk -c -jobname=%:r_phone % 

command! -nargs=0 GenerateChart
  \ Start! latexmk -pdf -jobname=%:r_chart -pdflatex="pdflatex --shell-escape \%O '\def\ChordsAndLyrics{1} \input{\%S}'" % 
  \ && latexmk -c -jobname=%:r_chart % 

command! -nargs=0 GenerateChartGray
  \ Start! latexmk -pdf -jobname=%:r_chart_gray -pdflatex="pdflatex --shell-escape \%O '\def\ChordsAndLyrics{1} \def\BlackAndWhite{1} \input{\%S}'" % 
  \ && latexmk -c -jobname=%:r_chart_gray % 

command! -nargs=0 GenerateChords
  \ Start! latexmk -pdf -jobname=%:r_chords -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \input{\%S}'" % 
  \ && latexmk -c -jobname=%:r_chords % 

command! -nargs=0 GenerateChordsGray
  \ Start! latexmk -pdf -jobname=%:r_chords_gray -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % 
  \ && latexmk -c -jobname=%:r_chords_gray % 

command! -nargs=0 GenerateLyrics
  \ Start! latexmk -pdf -jobname=%:r_lyrics -pdflatex="pdflatex --shell-escape \%O '\def\LyricsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % 
  \ && latexmk -c -jobname=%:r_lyrics % 

command! -nargs=0 GenerateOutline
  \ Start! latexmk -pdf -jobname=%:r_outline -pdflatex="pdflatex --shell-escape \%O '\def\Structure{1} \def\Longpaper{1} \input{\%S}'" % 
  \ && latexmk -c -jobname=%:r_outline % 

"generates songsheet (color), and Long in more-PDFs dir (creates if doesn't exist)
"command! -nargs=0 CompileSong write | 
  "\ lcd %:h | 
  "\ Start! latexmk -silent -pdf -pdflatex="pdflatex \%O \%S" %  
  "\ && latexmk -c % 
  "\ && latexmk -silent -pdf -jobname=%:r_phone -pdflatex="pdflatex --shell-escape \%O '\def\Longpaper{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_phone % 

"generates ChordsAndLyrics  (color and gray), and Lyrics (gray), Chords (color and gray), Structure in more-PDFs dir (creates if doesn't exist)
  "\ Start! mkdir -p more-PDFs 
"command! -nargs=0 CompileSongall write |  
  "\ Start! latexmk -pdf -pdflatex="pdflatex \%O \%S" %  
  "\ && latexmk -c % 
  "\ && latexmk -pdf -jobname=%:r_chart -pdflatex="pdflatex --shell-escape \%O '\def\ChordsAndLyrics{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_chart % 
  "\ && latexmk -pdf -jobname=%:r_chart_gray -pdflatex="pdflatex --shell-escape \%O '\def\ChordsAndLyrics{1} \def\BlackAndWhite{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_chart_gray % 
  "\ && latexmk -pdf -jobname=%:r_chords -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_chords % 
  "\ && latexmk -pdf -jobname=%:r_chords_gray -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_chords_gray % 
  "\ && latexmk -pdf -jobname=%:r_lyrics -pdflatex="pdflatex --shell-escape \%O '\def\LyricsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_lyrics % 
  "\ && latexmk -pdf -jobname=%:r_outline -pdflatex="pdflatex --shell-escape \%O '\def\Structure{1} \def\Longpaper{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_outline % 
  "\ && latexmk -pdf -jobname=%:r_phone -pdflatex="pdflatex --shell-escape \%O '\def\Longpaper{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_phone % 

"command! -nargs=0 CompileSongphone write | 
  "\ Start! latexmk -pdf -jobname=%:r_phone -pdflatex="pdflatex --shell-escape \%O '\def\Longpaper{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_phone % 

"command! -nargs=0 CompileSongchart write | 
  "\ Start! latexmk -pdf -jobname=%:r_chart -pdflatex="pdflatex --shell-escape \%O '\def\ChordsAndLyrics{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=%:r_chart % 

"command! -nargs=0 CompileSongchords write | 
  "\ Start! mkdir -p more-PDFs && 
  "\ latexmk -pdf -jobname=more-PDFs/%:r_chords -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=more-PDFs/%:r_chords % 
  "\ && latexmk -pdf -jobname=more-PDFs/%:r_chords_gray -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=more-PDFs/%:r_chords_gray % 

"command! -nargs=0 CompileSonglyrics write | 
  "\ Start! mkdir -p more-PDFs && 
  "\ latexmk -pdf -jobname=more-PDFs/%:r_lyrics -pdflatex="pdflatex --shell-escape \%O '\def\LyricsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=more-PDFs/%:r_lyrics % 

"command! -nargs=0 Compilesongoutline write | 
  "\ Start! mkdir -p more-PDFs && 
  "\ latexmk -pdf -jobname=more-PDFs/%:r_outline -pdflatex="pdflatex --shell-escape \%O '\def\Structure{1} \def\Longpaper{1} \input{\%S}'" % 
  "\ && latexmk -c -jobname=more-PDFs/%:r_outline % 
