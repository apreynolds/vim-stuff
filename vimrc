
"{{{ SEE ALSO:

" (RECALL that <leader>gf will open these files in new tab)

"AFTER: for custom filetype-specific commands
" ~/.vim/after/ftplugin/tex.vim
" ~/.vim/after/ftplugin/todo.txt.vim
" ~/.vim/after/ftplugin/markdown.vim
" ~/.vim/after/ftplugin/song.vim
" ~/.vim/after/ftplugin/vimwiki.vim

" SYNTAX: for colors, isk settings
" ~/.vim/after/syntax/tex.vim
" ~/.vim/after/syntax/sh.vim
" ~/.vim/after/syntax/html.vim
" ~/.vim/after/syntax/todo.vim

"}}} 

"{{{ INITIAL SETUP:

" Enabling filetype support provides filetype-specific indenting,
" syntax highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on

" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" :Man command will open man file for command in vimc
runtime ftplugin/man.vim

set viminfofile=~/.vim/viminfo

"}}} 

"{{{ BASIC functionality:

set autochdir " Change working directory to that of the opened file

" I read a thread that suggested modelines could be a security risk; follow up
" on this later
set nomodeline  

set hidden  " Possibility to have more than one unsaved buffer
set splitright splitbelow  " Open splits below, and to the right
set backspace=indent,eol,start " Intuitive backspace behavior.

" Since moving .vim/ into the cloud-synced Documents/, I don't want swap files
" to be cloud-synced, so place them in the non-synced ~/.cache/ directory:
set directory=~/.cache/vim-swap//

set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//

" Saving options in session and view files causes more problems than it
" solves, so disable it.
set sessionoptions-=options
set viewoptions-=options

" Ensure sessions save tabnames (necessary for Taboo plugin)
set sessionoptions+=globals 

"}}}

"{{{ BASIC look and feel:

set autoindent  " Minimal automatic indenting for any filetype.

" Command-line completion, use `<Tab>` to move around and `<CR>` to validate.
set wildmenu  
set wildmode=longest,list,full " Command line tab completion

set number relativenumber " Lines numbered relative to cursor
set tabstop=4  " 4 spaces (default is 8)
set expandtab  " Replace tabstops with spaces
set shiftwidth=2 " Sets indentation to 2 spaces (default is 8)
set tw=80 " text width set to 80 characters
set linebreak breakindent " Breaks lines at whitespace, and indent
set showbreak=.. " Indentation of a linebreak is indicate with ..
set ruler " Shows the current line number at the bottom-right of the screen.
set showmatch " Briefly show matching bracket
set conceallevel=2 " Hides bold markers, $ in math mode, etc.
set laststatus=2 " Necessary for statusline
set showcmd " Show (partial) command in last line
set scrolloff=2 " Keep 2 lines visible at top/bottom when scrolling
set noshowmode " Showmode is unnecessary when using airline
set formatoptions+=j " Delete comment character when joining commented lines.


"MAXIMIZE WINDOW:
nnoremap <C-W>m <C-W>\|<C-W>_ 

"}}}

"{{{ BASIC searching

set incsearch  " Incremental search, hit `<CR>` to stop.
set ignorecase " Ignore case when searching
set smartcase  " Case-sensitive searching when uppercase letters are present
set hlsearch   " for vim-cool

"}}}

"{{{ Leader

let mapleader = ","

" local leader is used for e.g. filetype plugins:
let maplocalleader = "," "same

"}}}

"{{{ AUGROUP

augroup GENERAL
  autocmd!
  autocmd BufNewFile,BufRead *.txt setlocal tw=80
  autocmd BufNewFile,BufRead *.cls setlocal filetype=tex

  " 2024-10-07 Started using .song filetype for music songsheets, as it's
  " better for custom snippets and compilation commands. Note that ft=song.tex
  " sets filetype to both song and tex, and syntax to tex
  autocmd BufNewFile,BufRead *.song setlocal filetype=song.tex

  autocmd BufEnter,BufRead tex.snippets setlocal foldmethod=marker foldmarker=<<<,>>> 
  autocmd BufNewFile,BufRead *rc setlocal foldmethod=marker
  autocmd BufNewFile,BufRead *.toml setlocal foldmethod=marker
  autocmd BufNewFile,BufRead *ign-except-text setlocal filetype=gitignore
  autocmd BufNewFile,BufRead *dircolors setlocal foldmethod=marker
augroup end

"}}} end AUGROUP

"{{{ Vim-plug

call plug#begin()

"To disable a plugin append ', {'on': []}'

Plug 'morhetz/gruvbox'
Plug 'preservim/nerdcommenter'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-obsession' 
Plug 'tpope/vim-dispatch' "keymaps disabled
Plug 'vimwiki/vimwiki'

"Plugin was last updated in 2016, and I've made local changes to it, so don't
"update it.
Plug 'freitass/todo.txt-vim', { 'frozen': 1 } 

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'embear/vim-foldsearch'
Plug 'gcmt/taboo.vim'
Plug 'edkolev/tmuxline.vim', {'on': []} "Unnecessary
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'artnez/vim-wipeout'
Plug 'christoomey/vim-tmux-navigator'

"2025-05-18 encountered error when sourcing vimrc, so have disabled
"(unimportant plugin)
Plug 'TaDaa/vimade', {'on': []} 

Plug 'preservim/nerdtree'
Plug 'tpope/vim-eunuch'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak'

"2025-06-10 I no longer need this, as FZF and Rg (and tmux) achieve the same
"goals
Plug 'voldikss/vim-floaterm', {'on': []} 

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'romainl/vim-cool'
Plug 'nanotee/zoxide.vim'
Plug 'preservim/vim-markdown'
Plug 'AndrewRadev/bufferize.vim'
Plug 'kshenoy/vim-signature' "for marks
Plug 'Tarmean/fzf-session.vim' "replaces dominickng/fzf-session.vim
Plug 'yukimura1227/vim-yazi'
call plug#end()

"}}}

"{{{ Colors

"https://github.com/morhetz/gruvbox/wiki/Configuration

let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
colorscheme gruvbox
set background=dark "had to add this which I switched to kitty terminal

"SET COLOR OF DIRECTORIES TO MATCH MY DIRCOLORS:
hi! link Directory GruvboxBlue

"}}}

"{{{ plugin: Dispatch

let g:dispatch_no_maps = 1

"}}}

"{{{ plugin: todo.txt, Foldsearch

" DISABLE MAPPINGS: (I only use one, Fw)
let g:foldsearch_disable_mappings = 1

"ENABLE FW: (folds lines not containing word under cursor)
nnoremap <leader>fw :Fw<cr>

augroup TODO
  autocmd!
  autocmd BufEnter *todo.txt setlocal foldmethod=manual

  " Display tasks that do not contain WORD (fold others)
  autocmd FileType todo nnoremap <leader><leader>1 :Fp @\(WORD\)\@!<cr>

  " I do not know why I created the following:
  "autocmd FileType todo nnoremap <leader><leader>p :Fp (\w)<cr>

  " Display tasks with due date, but without threshold date (fold others)
  autocmd FileType todo nnoremap <leader><leader>d :Fp due:\d\d\d\d-\d\d-\d\d\( t:\d\d\d\d-\d\d-\d\d\)\@!<cr>

  " Display priority A tasks (fold others)
  autocmd FileType todo noremap <leader><leader>a :Fp (A)<cr>

  " Display priority A or B tasks (fold others)
  autocmd FileType todo noremap <leader><leader>b :Fp (A)\\|(B)<cr>

  " Display priority A or B or C tasks (fold others)
  autocmd FileType todo noremap <leader><leader>c :Fp (A)\\|(B)\\|(C)<cr>
augroup end

"}}}

"{{{ plugin: Fugitive

" Keymaps for fugitive commands: 
nnoremap <leader>gc :Git commit -m "
nnoremap <leader>gC :Git commit<cr>
nnoremap <leader>gb :Git branch 
nnoremap <leader>gk :Git checkout 
nnoremap <leader>gt :Git tag 
nnoremap <leader>gm :Git merge  
nnoremap <leader>gr :Git rebase  
nnoremap <leader>gP :Git push<cr>

"}}}

"{{{ plugin: EasyAlign

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}}

"{{{ plugin: Goyo
inoremap <leader>gg :Goyo<cr>
nnoremap <leader>gg :Goyo<cr>

let g:goyo_height = '90%'
let g:goyo_width = 100
let g:goyo_linenr = 1

function! s:goyo_enter()
  silent !tmux set status off
  set showmode
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  set noshowmode
  highlight NonText ctermfg=bg
  highlight VertSplit ctermfg=bg
endfunction

augroup GOYO
  autocmd!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup end

"}}}

"{{{ plugin: FZF, Rg

let g:fzf_action = {
      \ 'ctrl-t': '$tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-o': 'Start! open', } " for opening with application
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }

nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>gf :GFiles<cr>

"run Files, DO ignore .gitignore files, AND run only on specific text files
command! -bang -nargs=? -complete=dir FilesTextOnly 
      \call fzf#vim#files(
      \<q-args>, fzf#vim#with_preview(
      \{'source': 'fd --follow --ignore-file ~/.config/fd/ign-except-text'}
      \), 
      \<bang>0)
"run Files, DON'T ignore .gitignore files, so I can open e.g. pdfs
command! -bang -nargs=? -complete=dir FilesAll 
      \call fzf#vim#files(
      \<q-args>, fzf#vim#with_preview(
      \{'source': 'fd --no-ignore-vcs --follow'}
      \), 
      \<bang>0)

"run Files:
nnoremap <leader>ff :FilesTextOnly<cr>
nnoremap <leader>fa :FilesAll<cr>
nnoremap <leader>fu :FilesTextOnly ../<cr>
nnoremap <leader>fau :FilesAll ../<cr>
nnoremap <leader>fU :FilesTextOnly ../../<cr>
nnoremap <leader>faU :FilesAll ../../<cr>
nnoremap <leader>f0 :FilesAll ~//Documents/0desktopia<cr>
nnoremap <leader>f1 :FilesAll ~/Documents/1math<cr>
nnoremap <leader>f2 :FilesAll ~/OneDrive\ -\ University\ of\ New\ Brunswick/2work<cr>
nnoremap <leader>f3 :FilesAll ~/Documents/3tech<cr>

"run Files in 3tech/mytips
nnoremap <leader><F1> :FilesAll ~/Documents/3tech/mytips/<cr>


"run Rg in cwd (default)
nnoremap <leader>rr :RgTextOnly <cr>
nnoremap <leader>rg :Rg <cr>
"run Rg in wiki diaries (default)
nnoremap <leader>rt :RgTechDiary <cr>

"run Rg in cwd only on specific text files (and follow symlinks):
command! -bang -nargs=* RgTextOnly 
      \call fzf#vim#grep(
      \"rg --follow --column --line-number --no-heading \--color=always 
      \--smart-case --ignore-file ~/.config/fd/ign-except-text 
      \-- ".fzf#shellescape(<q-args>), 
      \fzf#vim#with_preview(), 
      \<bang>0)

"run Rg in diary, only on specific text files:
command! -bang -nargs=* RgTechDiary 
      \call fzf#vim#grep(
      \"rg --column --line-number --no-heading --color=always 
      \--smart-case --ignore-file ~/.config/fd/ign-except-text 
      \-- ".fzf#shellescape(<q-args>), 
      \fzf#vim#with_preview({'dir': '~/Documents/3tech/diary'}), 
      \<bang>0)

"}}}

"{{{ plugin: Airline

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline_powerline_fonts=1

"NOTE: couldn't get the airline obsession status to work, but will abandon.
"See https://github.com/vim-airline/vim-airline/issues/777
"let g:airline#extensions#obsession#enabled = 1

" Change theme with :AirlineTheme
let g:airline_theme='gruvbox'
"let g:airline_theme='bubblegum'
"let g:airline_theme='raven'
let g:airline#extensions#tmuxline#enabled = 1

"}}}

"{{{ plugin: Taboo

let g:taboo_tabline=1 "for taboo to work with airline
let g:taboo_tab_format="%N%U %f%m" " Naming format for tabs
let g:taboo_renamed_tab_format="%N%U %l%m" " Naming format for renamed tabs
"let g:taboo_tab_format="%N:%f%m" " Naming format for tabs
"let g:taboo_renamed_tab_format=" %N:%l%m" " Naming format for renamed tabs

nnoremap <leader>tr :TabooRename 
"the $ will place the tab last:
nnoremap <leader>tn :$tabnew<CR>
nnoremap <leader>tm :tabm

"}}}

"{{{ PLUGIN: vimtex, and other tex stuff

let g:tex_flavor='latex' "new tex files will have ft set to tex

let g:vimtex_toc_todo_labels = {'TODO': 'TODO: ', 'FIXME': 'FIXME: ', 'NOTE': 'NOTE: '}

let g:vimtex_compiler_latexmk = {
      \ 'callback' : 1,
      \ 'continuous' : 1,
      \ 'executable' : 'latexmk',
      \ 'hooks' : [],
      \ 'options' : [
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=0',
      \ ],
      \}

let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=1
let g:vimtex_fold_types = {
      \ 'items' : {'enabled' : 0},
      \  'cmd_single' : {
      \      'cmds' : [
      \        'solutionbox',
      \        'notebox',
      \        'currentupdatebox',
      \        'structure',
      \        'chords',
      \        'lyrics',
      \        'lyricswithchords',
      \      ],
      \    },
      \ 'envs' : {
      \   'blacklist' : ['enumerate','itemize'],
      \   'whitelist' : [],
      \ },
      \ }

"2025-07-07 filter out warnings related to fontaxes; prompted by baskervaldx
let g:vimtex_quickfix_ignore_filters = [
      "\ 'Package fontaxes Warning: Axis ',
      "\ 'Marginpar on page',
      "\ 'Label(s) may have changed',
      "\ 'Exercise properties may have changed',
      \]

let g:tex_isk='48-57,a-z,A-Z,192-255,:,-,_,'

let g:vimtex_syntax_conceal = {
      \ 'accents': 1,
      \ 'ligatures': 1,
      \ 'cites': 1,
      \ 'fancy': 1,
      \ 'spacing': 0,
      \ 'greek': 1,
      \ 'math_bounds': 1,
      \ 'math_delimiters': 1,
      \ 'math_fracs': 1,
      \ 'math_super_sub': 1,
      \ 'math_symbols': 1,
      \ 'sections': 0,
      \ 'styles': 1,
      \}

let g:vimtex_syntax_custom_cmds = [
      \ {'name': 'texttt', 'conceal': 1, 'argstyle': 'under'},
      \ {'name': 'lstinline', 'conceal': 1, 'argstyle': 'italunder'},
      \]

let g:vimtex_indent_delims = {
      \ 'open' : ['{'],
      \ 'close' : ['}'],
      \ 'close_indented' : 0,
      \ 'include_modified_math' : 0,
      \}

"}}}

"{{{ plugin: Ultisnips

let g:UltiSnipsEditSplit='context'
"let g:UltiSnipsListSnippets='<C-u>'
let g:UltiSnipsExpandTrigger='<s-tab>'

map <F3> :UltiSnipsEdit<CR>

"}}}

"{{{ plugin: Wipeout

" Closes all buffers not in windows
nnoremap <leader>wo :Wipeout<CR>

"}}}

"{{{ plugin: Obsession and fzf-session 

"NOTE: Using 'Tarmean/fzf-session.vim', after previously trying
"'dominickng/fzf-session.vim'; the former is a little newer.  I mistakenly
"thought that the latter would obviate the need for Obsession, but I was
"wrong: Obsession provides the crucial "auto-save sessions" functionality.
"While it may be possible to get the latter working the way I want with
"Obsession, I won't bother trying as the function below allows the behaviour I
"want, namely: - Unload the current session and wipeout all the hidden buffers
"- Load a new session (fuzzy)

map <leader>oo :Obsession ~/.vim/sessions/
map <leader>os :echo ObsessionStatus()<cr>

map <leader>sl :SessionLoad<cr>
map <leader>ss :call SessUnloadWipeoutLoad()<cr>
map <leader>su :call SessUnloadWipeout()<cr>

"Custom function to unload, wipeout:
function! SessUnloadWipeout()
  "Unload the current session:
  execute 'SessionUnload' 
  "Wipeout all hidden buffers so they won't be in the next session:
  execute 'Wipeout'
  "Remove the custom label associated with the current tab:
  execute 'TabooReset'
endfunction
"Custom function to unload, wipeout, and load new session:
function! SessUnloadWipeoutLoad()
  "Unload the current session:
  execute 'SessionUnload' 
  "Wipeout all hidden buffers so they won't be in the next session:
  execute 'Wipeout'
  "Remove the custom label associated with the current tab:
  execute 'TabooReset'
  "Fuzzy load a new session:
  execute 'SessionLoad'
endfunction

"}}}

"{{{ plugin: yazi-vim

" Replace netrw with yazi
let g:yazi_replace_netrw = 1  

" Disable default key mappings
let g:yazi_no_mappings = 1  

" Set keymap to open yazi in new tab
nnoremap <leader>y :tabnew \| Yazi<cr>

"}}}

"{{{ Diff (and mappings)

"diff options 2015-07-18
"Note that 'dp' puts, and 'do' obtains
if &diff
  " diff mode
  set diffopt+=iwhite " ignore changes in amount of whitespace
endif

nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff<CR>

"}}} end DIFF

"{{{ Mappings: Inserting date/time

"Enter current date (see help i^R and search =):
inoremap <F2> <C-R>=strftime("%F")<CR>
"First enter insert mode, then date, then esc back to normal:
nnoremap <F2> i<C-R>=strftime("%F")<CR><ESC>

"}}} end Inserting date/time

"{{{ MISC: launching external scripts

nnoremap <leader>sy :Start! sync2onedrive<cr>

"}}} end MISC

"{{{ plugin: vim-markdown

let g:vim_markdown_new_list_item_indent = 2

"}}} end vim-markdown

"{{{ plugin: Vimwiki


"{{{ GENERAL

let g:vimwiki_folding='expr' "2019-07-17 'list' is another option; see documentation
let g:vimwiki_hl_headers=1
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_global_ext = 0
let g:vimwiki_user_htmls = 'courses.html,IIindex.html,math.html,video.html,contact.html'
let g:vimwiki_valid_html_tags = 'a,b,i,s,u,sub,sup,kbd,br,hr,div,center,strong,em,iframe,span,script,h1,audio,source,table,tr,th,td'
let g:vimwiki_toc_header = 'contents'
let g:vimwiki_key_mappings =
      \ {
      \   'table_mappings': 0,
      \ }

"removed .md from list, so that vimwiki wouldn't auto-generate html
"for .md files (2025-05-23)
let g:vimwiki_ext2syntax = {'.mkdn': 'markdown',
      \  '.mdwn': 'markdown', '.mdown': 'markdown',
      \  '.markdown': 'markdown', '.mw': 'media'}

nnoremap <localleader>vc :VimwikiTOC<CR>

" I like newly opened tabs to be last
nnoremap <localleader>vt :call MyVimwikiTabnewLink()<cr>

function! MyVimwikiTabnewLink()
  execute 'VimwikiTabnewLink'
  execute 'tabmove $'
endfunction

nnoremap <localleader>vv :VimwikiVSplitLink<CR>

nnoremap <localleader>vk :VimwikiDiaryNextDay<CR>
nnoremap <localleader>vj :VimwikiDiaryPrevDay<CR>

"Insert mode vimwiki table mappings:
inoremap <leader><leader>c <Plug>VimwikiTableNextCell
inoremap <leader><leader>p <Plug>VimwikiTableNextCell

"}}} end GENERAL

"{{{ VimwikiLinkHandler

function! VimwikiLinkHandler(link)
  " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
  "   1) [[vfile:~/Code/PythonProject/abc123.py]]
  "   2) [[vfile:./|Wiki Home]]
  let link = a:link
  if link =~# '^vfile:'
    let link = link[1:]
  else
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ''
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    exe '$tabnew ' . fnameescape(link_infos.filename)
    return 1
  endif
endfunction

"}}} end VimwikiLinkHandler

"{{{ Setting up the wikis

let $myrx_todo = '\C\<\%(CONCERN\|DONE\|INFO\|FIXED\|HOWTO\|NOTE\|QUESTION\|RESOURCE\|SUMMARY\|TODO\|UPDATE\|ZTEMP\|\)\>'

let math = {}
let math.path = '~/Documents/1math/'
let math.path_html = '~/Documents/1math/'
let math.diary_rel_path = 'diary/'
let math.index = 'math-index'
let math.css_name = '.wikiconfig/style_www/style.css'
let math.template_path = '~/Documents/1math/.wikiconfig/'
let math.rx_todo = $myrx_todo
let math.template_default = 'def_template'
let math.template_ext = '.thtml'
let math.auto_tags = 1
let math.auto_export = 0
let math.auto_diary_index = 1

let site_work = {}
let site_work.path = '/Documents/websites/2work-web/'
let site_work.path_html = '/Documents/websites/2work-web/'
let site_work.css_name = 'style_www/style.css'
let site_work.template_path = '~/Documents/websites/2work-web/wikiconfig/'
let site_work.template_default = 'def_template'
let site_work.template_ext = '.thtml'
let site_work.auto_export = 1

let tech = {}
let tech.path = '~/Documents/3tech/'
let tech.path_html = '~/Documents/3tech/'
let tech.diary_rel_path = 'diary/'
let tech.index = 'tech-index'
let tech.css_name = '.wikiconfig/style_www/style.css'
let tech.template_path = '~/Documents/3tech/.wikiconfig/'
let tech.rx_todo = $myrx_todo
let tech.template_default = 'def_template'
let tech.template_ext = '.thtml'
let tech.auto_tags = 1
let tech.auto_export = 0
let tech.auto_diary_index = 1

let site_music= {}
let site_music.path = '~/Documents/websites/4music-web/'
let site_music.path_html = '~/Documents/websites/4music-web/'
let site_music.css_name = 'style_www/style.css'
let site_music.template_path = '~/Documents/websites/4music-web/wikiconfig/'
let site_music.template_default = 'def_template'
let site_music.template_ext = '.thtml'
let site_music.auto_export = 1

let g:vimwiki_list = [ math, site_work, tech, site_music ]


"}}} end Setting up the wikis

"{{{ Tags customizations

" MyVimwikiGenerateTags; cleans up vimwiki tag link formatting
function! MyVimwikiGenerateTags()
  "clear .vimwiki_tags beforehand
  execute 'Start! rm .vimwiki_tags_bak2 && mv .vimwiki_tags_bak1 .vimwiki_tags_bak2 && mv .vimwiki_tags .vimwiki_tags_bak1'
  "Replace == :tag: == with == tag == so that VimwikiRebuildTags! doesn't 'see' these tags, then write the file and pause
  execute '%s/== :\(.*\): ==/== \1 ==/'
  execute "write"
  sleep 1
  "Use built-in function to rebuild tags on all files:
  execute 'VimwikiRebuildTags!'
  "Use built-in function to generate tags:
  execute 'VimwikiGenerateTagLinks'
  "Move to Generated Tags heading:
  execute 'g/= Generated Tags ='
  "From heading to end of file, on lines not containing "/" (thus excluding files in subdirectories), re-format the link so that it appears as HEADING (FILE)
  "(Assumes filename consists only of letters, numbers, dashes, underscores, spaces, dots)
  "execute '.,$v/^  - \[\[.*\//s/\(  - \[\[\)\([a-zA-Z0-9-_ .]\+\)\(.*\)#\(.*\)\]\]/\1\2\3#\4 | \4 (\2)\]\]/'
  execute '.,$v/^  - \[\[.*\//s/\(  - \[\[\)\([a-zA-Z0-9-_ .]\+\)\(.*\)#\(.*\)\]\]/\1\2\3#\4 | \4\]\]/'
  "Move to Generated Tags heading:
  execute 'g/= Generated Tags ='
  "From heading to end of file, on lines containing "/" (thus only for files in subdirectories), re-format the link so that it appears as HEADING (FILE in DIR)
  "(Assumes filename consists only of letters, numbers, dashes, underscores, spaces, dots)
  "execute '.,$g/^  - \[\[.*\//s/\(  - \[\[\)\(.*\)\/\([a-zA-Z0-9-_ .]\+\)\(.*\)#\(.*\)\]\]/\1\2\/\3\4#\5 |\5 (\3 in \2)\]\]/'
  execute '.,$g/^  - \[\[.*\//s/\(  - \[\[\)\(.*\)\/\([a-zA-Z0-9-_ .]\+\)\(.*\)#\(.*\)\]\]/\1\2\/\3\4#\5 |\5\]\]/'
  "Move to Generated Tags heading:
  execute 'g/= Generated Tags ='
  "Replace == tag == with == :tag: ==, mainly for tab-completion, and it also looks nice in html
  execute '.,$s/== \(.*\) ==/== :\1: ==/'
  "Remove all lines that refer to the TAGS file itself:
  "execute '%s/.*TAGS#Generated Tags#.*\n//'
endfunction

"}}}

"{{{ DIARY archive

nnoremap <localleader>ut :call UnTag() <cr>
function! UnTag()
  "replace colons with semicolons in tags:
  execute '%s/:\([wtc][#+@-\[]\{-}\)\(\w\{-}\):/;\1\2;/g'
endfunction
nnoremap <localleader>ut :call UnTag() <cr>

command! -nargs=1 ArchiveDiaryEntry call ArchiveDiaryEntry( <q-args> )

nnoremap <localleader>arc :ArchiveDiaryEntry <C-R>%<CR>

" Archiving diary entries (updated 2025-05-20). Assumes it's run from wiki home directory
function! ArchiveDiaryEntry(filename) range
  "append hour, minute, second to filename:
  execute 'Move! ' .  escape( fnamemodify(a:filename, ':r') . strftime("__%H-%M-%S")  . ".wiki", ' ' )
  "get cwd:
  let l:cwd = getcwd()
  "move html file if it exists:
  let l:htmlfile = fnamemodify( a:filename, ':r' ) . ".html"
  if filereadable(l:htmlfile)
    let movehtml = 'mv ' . l:htmlfile . ' diary/.zz-diary/'
    call system(movehtml)
  endif
  "Now move wiki file to ../zz-diary/
  execute 'Move! diary/.zz-diary/'
  sleep 1
  "Navigate back to original directory and open diary.wiki in a split:
  execute 'sp ' . l:cwd . '/diary/diary.wiki'
  sleep 1
  "write the diary (also updates it):
  execute 'w'
  sleep 1
  "buffer containing archived entry will still be open, so move to it and delete it:
  execute 'wincmd k'
  sleep 1
  execute 'bd'
endfunction

"}}} end DIARY

"{{{ AUGROUP
"
augroup WIKI
  autocmd!
  "Generate links in a wiki's diary file upon write (note that
  "VimwikiDiaryIndex function has 'write' built into it, so this will be
  "executed upon (number)<leader>wi):
  autocmd BufWrite *diary.wiki  VimwikiDiaryGenerateLinks
  " Automatically call MyTags upon writing TAGS.wiki
  autocmd BufWrite *TAGS.wiki  call MyVimwikiGenerateTags()
  autocmd BufWrite math-index.wiki  call MyVimwikiGenerateTags()
  autocmd BufWrite tech-index.wiki  call MyVimwikiGenerateTags()
  "HTML FILETYPE: for thtml (template) files
  autocmd BufNewFile,BufRead *.thtml setlocal filetype=html
augroup end

"}}} end AUGROUP


"}}} end PLUGIN vimwiki

"{{{ MY CUSTOM HELP FILES 

augroup CUSTOMHELP
  autocmd!
  autocmd BufNewFile,BufRead *.help.txt 
        \setlocal filetype=help foldmethod=marker modifiable noreadonly
  autocmd BufWritePost ~/.vim/doc/* :helptags ~/.vim/doc
augroup end

"JUST IN CASE I NEED TO SET MODIFIABLE:
nnoremap <leader>md :set modifiable<cr>

"USE MY HELP FILES:
nnoremap <leader>hv :help myvim-
nnoremap <leader>hl :$tabe ~/Documents/3tech/mytips/latex.tex<cr>

"EDIT MY HELP FILES:
nnoremap <F1> :call OpenMyVimQuicknotes()<CR>

function! OpenMyVimQuicknotes()
  execute 'help myvim-quicknotes'
  execute 'set modifiable'
endfunction

"}}} end MY CUSTOM HELP FILES

"{{{ OPENING MISC FILES (based on :h gf)

" To open the manual for a particular latex package, simply put cursor under the
" package name and enter this keymap:
noremap <leader>xd :Start! texdoc <cfile><cr>

" If I'm using a personal latex class or style file, store in texmf/tex/local,
" and wish to open in, simply put cursor under the file name and enter:
noremap <leader>xf :$tabe /Users/preynol1/Library/texmf/tex/local/<cfile>.cls<cr>

" Opens vimrc in new tab
nnoremap <leader>ev :$tabe $HOME/Documents/3tech/vim/vimrc<cr>
" Sources vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Opens yazi keymap in new tab
nnoremap <leader>ey :$tabe $HOME/Documents/3tech/yazi/keymap.toml<cr> 

" Open file under cursor in new tab
map gf :$tabe <cfile><CR>

" Open file under cursor in application
nnoremap <leader>go :Open <cfile><cr>

" COPY FILENAME WITH PATH TO UNNAMED REGISTER:
nnoremap <leader>cp :let @" = expand("%:p")<CR>
nnoremap <leader>cP :let @+ = expand("%:p")<CR>

"}}} end Opening misc files

"{{{ My "append to filename" function (obsolete?)

"FUNCTION: Takes argument, appends it to end of filename.
"(Renames file, deletes old one, appropriately sets filetype.)
"USE: vimwiki diary entries that turn out to be important, and merit a descriptive name.

nnoremap <leader>af :MyAppendToFilename 

command! -nargs=1 MyAppendToFilename call MyAppendToFilename( <q-args> )

function! MyAppendToFilename(append) range
  "store filename:
  let l:filename = bufname()
  "store filetype:
  let l:filetype = &filetype
  "store extension:
  let l:extension = '.' . fnamemodify( l:filename, ':e' )
  "I forget why I found this necessary; maybe for files without extenstions?
  if len(l:extension) == 1
    let l:extension = ''
  endif

  execute 'Move! ' .  escape( fnamemodify(l:filename, ':r') . '-' . a:append . l:extension, ' ' )

  "set filetype of moved file appropriately:
  execute 'set ft=' . l:filetype

endfunction

"}}} end My "append to filename" function

"{{{ My "Backup with timestamp" function
"Writes a backup file with timestamp appended to filename. 
"For tex files, check if pdf file exists, and if so, copy that pdf file to a timestamped backup pdf as well.
"Does not open the backed up file.

nnoremap <leader>ts :call BackupWithTimestamp()<cr>

function! BackupWithTimestamp()
  let l:filename = bufname()
  let l:extension = '.' . fnamemodify( l:filename, ':e' )
  if len(l:extension) == 1
    let l:extension = ''
  endif

  let l:timestampedfilename = escape( fnamemodify(l:filename, ':r') . strftime("-%Y%m%d") . l:extension, ' ' )

  if filereadable(l:timestampedfilename)
    echom "Today's backup already exists. Not proceeding."
  else
    if l:extension == ".tex"
      echom "tex file detected, will check for pdf"
      let l:pdffile = fnamemodify( l:filename, ':r' ) . ".pdf"
      if filereadable(l:pdffile)
        let l:timestampedpdffilename = escape( fnamemodify(l:filename, ':r') .  strftime("-%Y%m%d") . '.pdf', ' ' )
        echom l:pdffile "detected, will be copied to " l:timestampedpdffilename
        let tempcommand = 'cp ' . l:pdffile . ' ' . l:timestampedpdffilename
        call system(tempcommand)
      else
        echom l:pdffile "NOT detected"
      endif
    endif

    execute "write " . l:timestampedfilename

    echom "Backed up " strftime("%Y%m%d")
    "execute "e " . a:filename
  endif
endfunction

"}}} end My "Backup with timestamp" function

"{{{ COMPLETTION, DICTIONARY

" Note that i option will cause tab completion to scan included files (took ages
" with some latex files). 
" k option will include dictionary
set complete=.,w,b,u,t,k 

set dictionary+=~/.vim/doc/dictionary.txt " added 2024-10-05

"nnoremap <leader>ed :tabe $HOME/SYSTEM/dictionary.txt <CR>

nnoremap <leader>dd :call AddToDictionary()<cr>

function! AddToDictionary()
  let l:currentword = expand('<cword>')
  call writefile([l:currentword], $HOME . "/.vim/doc/dictionary.txt", "a")
endfunction

"}}} end COMPLETTION

"{{{ plugin: vim-cool

let g:cool_total_matches = 1

"}}} end 

"{{{ plugin: NERDTree

nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nc :NERDTreeCWD<CR>

"}}} end NERDTree 

"{{{ functions: add quick notes

"2025-06-11 These functions allow me to write a line of text and append it to
"a particular file of my choosing. 
"(Remember to delete line afterwards, as it's not relevant to current file!)

"2025-07-17 Found the following function at https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! Get_visual_selection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  "return join(lines, "\n") 
  return lines
endfunction

command! -range -nargs=0 AddToLatexMyTips call writefile(Get_visual_selection(), $HOME . "/Documents/3computer/mytips/latex.tex", "a")

"}}} 

"{{{ MyKeymaps Functions

nnoremap <leader>kk :Bufferize call MyKeymaps()<CR>

"Hi there!
function! MyKeymaps()
  set foldmethod=marker
  echo ",kk: Bufferize call MyKeymaps() -- OPEN THESE IN BUFFER "
  echo "{{{ GIT, FUGITIVE "
  echo ",gc: Git commit -m  -- and enter message"
  echo ",gC: Git commit -- enter message AND body"
  echo ",gb: Git branch -- create branch (no spaces)"
  echo ",gk: Git checkout branch"
  echo ",gt: Git tag"
  echo ",gm: Git merge"
  echo ",gr: Git rebase -- (generally I rebase BRANCH onto main)"
  echo ",gP: Git push"
  echo "}}}"
  echo "{{{ OPEN/CLOSE/VIEW ETC "
  echo "gf: $tabe <cfile><cr> -- OPENING FILE UNDER CURSOR IN NEW TAB"
  echo ",go: Open <cfile><cr> -- OPEN FILE UNDER CURSOR"
  echo ",xd: Start! texdoc <cfile><cr> -- TEXDOC FILE UNDER CURSOR"
  echo ",xf: $tabe /Users/preynol1/Library/texmf/tex/local/<cfile>.cls<cr> -- OPEN cls FILE"
  echo ",ev: Opens vimrc"
  echo ",sv: Sources vimrc"
  echo ",ey: Opens yazi keymaps"
  echo "}}}"
  echo "{{{ MISC "
  echo ",fw: Fw -- foldsearch, show lines which contain the word under the cursor"
  echo ",gg: Toggle Goyo"
  echo ",cp: copy current filename to clipboard"
  echo ",cP: copy current filename to system clipboard"
  echo "<F2>: insert current date"
  echo "<F3>: Ultisnips edit (for current filetype)"
  echo "ctrl-W m: maximize window"
  echo ",wo: Wipeout -- Closes all buffers not in windows"
  echo ":Td: delete all buffers in current tab"
  echo ",dt: diffthis"
  echo ",do: diffoff"
  echo ",dd: AddToDictionary -- Writes word under cursor to .vim/doc/dictionary.txt"
  echo "}}}"
  echo "{{{ RENAME & BACKUP FILES "
  echo ",af: MyAppendToFilename -- Takes argument, appends it to end of filename."
  echo ",ts: BackupWithTimestamp -- Writes new file with timestamp appended to filename (also checks for tex/pdf)"
  echo "}}}"
  echo "{{{ SCRIPTS "
  echo ",sy: :Start! sync2onedrive -- For syncing to OneDrive"
  echo "}}}"
  echo "{{{ MY CUSTOM HELP "
  echo ",md: set modifiable"
  echo ",hv: help myvim-"
  echo ",hl: $tabe ~/Documents/3computer/latex/latex.tex"
  echo "<F1>: call OpenMyVimQuicknotes()"
  echo "}}}"
  echo "{{{ MY ADD-TO-OTHER-FILES "
  echo "(no keymap): AddToLatexMyTips -- appends visual selection to latex.tex"
  echo "}}}"
  echo "{{{ FZF, RG "
  echo ",bb: Buffers"
  echo ",gf: GFiles"
  echo ",ff: FilesTextOnly -- run Files in cwd only on files specified in ign-except-text; exclude .gitignore files"
  echo ",fa: FilesAll -- run Files in cwd; include .gitignore files so I can open e.g. pdfs"
  echo ",fu: FilesTextOnly up-one-level"
  echo ",fau: FilesAll up-one-level"
  echo ",fU: FilesTextOnly up-two-levels"
  echo ",faU: FilesAll up-two-levels"
  echo ",f[count]: FilesAll -- run FilesAll in 0desktopia, 1math, etc "
  echo ",rr: RgTextOnly -- run Rg in cwd only on textfiles, follow symlinks"
  echo ",rg: Rg -- run Rg in cwd (default)"
  echo ",rt: RgTechDiary -- run Rg in 3tech/diary"
  echo "}}}"
  echo "{{{ VIMWIKI "
  echo ",vc: VimwikiTOC"
  echo ",vt: MyVimwikiTabnewLink() -- new tab at end"
  echo ",vv: VimwikiVSplitLink"
  echo ",vk: VimwikiDiaryNextDay"
  echo ",vj: VimwikiDiaryPrevDay"
  echo ",iw: InitializeWikis"
  echo "[count],w,w: MakeDiaryNote"
  echo "[count],w,t: MakeTabDiaryNote"
  echo ",ut: Untag -- for untagging diary entries"
  echo ",arc: ArchiveDiaryEntry -- perform Untag first, must be run from wikis home directory"
  echo ",hh: :Start! open %:r.html"
  echo "}}}"
  echo "{{{ MARKDOWN "
  echo "<F9> :Pandoc"
  echo ",pp :PandocPDF -- generates pdf"
  echo ",pd :PandocDocx -- generates docx"
  echo ",ph :PandocHtml -- generates html"
  echo "}}}"
  echo "{{{ TEX "
  echo ",vc: Start! open %:r-COMMENTS.pdf "
  echo ",vi: Start! open %:r-INSTRUCTOR.pdf "
  echo ",vS: Start! open %:r-STUDENT.pdf "
  echo ",vs: Start! open %:r-SOLUTIONS.pdf "
  echo ",vm: Start! open %:r-MARKER.pdf "
  echo ",vf: Start! open %:r-FIRSTPAGE.pdf "
  echo ",vh: Start! open %:r.html"
  echo ",LL: call CompileLectures()"
  echo ",LC: call CompileComments()"
  echo ",LS: call CompileSolutions()"
  echo ",LM: call CompileMarkerSolutions()"
  echo ",LC: call CompileCoverMarkerSolutions()"
  echo ",LF: call CompileFirstPage()"
  echo ",LE: call CompileEscape()"
  echo ",mm1: call MoveLecturesFn('math1003-2025f-lectures')"
  echo ",mm2: call MoveLecturesFn('math2203-2025f-lectures')"
  echo "<F10>: VimtexCompile"
  echo "}}}"
  echo "{{{ SESSIONS "
  echo ",oo: Obsession <name> -- track session <name>"
  echo ",os: echo ObsessionStatus()"
  echo ",ss: SessUnloadWipeoutLoad -- unload, wipeout, and fuzzy load new session"
  echo ",su: SessUnloadWipeout -- unload, wipeout"
  echo ",sl: SessionLoad -- fuzzy load new session"
  echo "}}}"
  echo "{{{ TABOO "
  echo ",tr: TabooRename"
  echo ",tn: new (last) tab"
  echo ",tm: tabm -- e.g. tabm3 will move to 3"
  echo "}}}"
  echo "{{{ NERDTREE "
  echo ",nn: NERDTreeToggle"
  echo ",nc: NERDTreeCWD -- current working directory"
  echo "}}}"
endfunction

"}}} 
