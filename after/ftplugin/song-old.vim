map <leader>vcl :Start! open %:r-ChordsAndLyrics.pdf <CR>
map <leader>vch :Start! open AdditionalPDFS/%:r-Chords.pdf <CR>
map <leader>vly :Start! open AdditionalPDFS/%:r-Lyrics.pdf <CR>
map <leader>vst :Start! open AdditionalPDFS/%:r-Structure.pdf <CR>

"(remember that vimtex maps <leader>ll to compilation)
map <F12> :CompileSong
map <leader>lsm :CompileSongmulti<CR>
map <leader>ls2 :CompileSongchordsLyrics<CR>
map <leader>lsc :CompileSongchords<CR>
map <leader>lsy :CompileSonglyrics<CR>
map <leader>lsl :CompileSonglong<CR>
map <leader>lss :CompileSongstructure<CR>

"generates songsheet (color), and Long in AdditionalPDFs dir (creates if doesn't exist)
command! -nargs=0 CompileSong write | Start! latexmk -pdf -jobname=%:r -pdflatex="pdflatex \%O \%S" %  && latexmk -c -jobname=%:r % && mkdir -p AdditionalPDFs && latexmk -pdf -jobname=AdditionalPDFs/%:r-Long -pdflatex="pdflatex --shell-escape \%O '\def\Longpaper{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Long % 

"generates ChordsAndLyrics  (color and grayscale), and Lyrics (grayscale), Chords (color and grayscale), Structure in AdditionalPDFs dir (creates if doesn't exist)
command! -nargs=0 CompileSongmulti write |  Start! mkdir -p AdditionalPDFs && latexmk -pdf -jobname=%:r-ChordsAndLyrics -pdflatex="pdflatex --shell-escape \%O '\def\ChordsAndLyrics{1} \input{\%S}'" % && latexmk -c -jobname=%:r-ChordsAndLyrics % && latexmk -pdf -jobname=AdditionalPDFs/%:r-ChordsAndLyrics-grayscale -pdflatex="pdflatex --shell-escape \%O '\def\ChordsAndLyrics{1} \def\BlackAndWhite{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-ChordsAndLyrics-grayscale % && latexmk -pdf -jobname=AdditionalPDFs/%:r-Chords -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Chords % && latexmk -pdf -jobname=AdditionalPDFs/%:r-Chords-grayscale -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Chords-grayscale % && latexmk -pdf -jobname=AdditionalPDFs/%:r-Lyrics -pdflatex="pdflatex --shell-escape \%O '\def\LyricsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Lyrics % && latexmk -pdf -jobname=AdditionalPDFs/%:r-Structure -pdflatex="pdflatex --shell-escape \%O '\def\Structure{1} \def\Longpaper{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Structure % 

command! -nargs=0 CompileSonglong write | Start! latexmk -pdf -jobname=AdditionalPDFs/%:r-Long -pdflatex="pdflatex --shell-escape \%O '\def\Longpaper{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Long % 

command! -nargs=0 CompileSongchordsLyrics write | Start! latexmk -pdf -jobname=%:r-ChordsAndLyrics -pdflatex="pdflatex --shell-escape \%O '\def\ChordsAndLyrics{1} \input{\%S}'" % && latexmk -c -jobname=%:r-ChordsAndLyrics % 

command! -nargs=0 CompileSongchords write | Start! mkdir -p AdditionalPDFs && latexmk -pdf -jobname=AdditionalPDFs/%:r-Chords -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Chords % && latexmk -pdf -jobname=AdditionalPDFs/%:r-Chords-grayscale -pdflatex="pdflatex --shell-escape \%O '\def\ChordsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Chords-grayscale % 

command! -nargs=0 CompileSonglyrics write | Start! mkdir -p AdditionalPDFs && latexmk -pdf -jobname=AdditionalPDFs/%:r-Lyrics -pdflatex="pdflatex --shell-escape \%O '\def\LyricsOnly{1} \def\BlackAndWhite{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Lyrics % 

command! -nargs=0 CompileSongstructure write | Start! mkdir -p AdditionalPDFs && latexmk -pdf -jobname=AdditionalPDFs/%:r-Structure -pdflatex="pdflatex --shell-escape \%O '\def\Structure{1} \def\Longpaper{1} \input{\%S}'" % && latexmk -c -jobname=AdditionalPDFs/%:r-Structure % 
