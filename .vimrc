if &cp | set nocp | endif
let s:cpo_save=&cpo

""" Function keys INDEX """"""""""""""""""""""
"<F1> :call ToggleFocusMode()<CR>
"<F3> :GrepBuffer<CR>
"<F2> Hide Numbers and NERDTree
"<F4> Paste
"<F5> Refresh File
"<F7> :NERDTreeToggle<CR>
"<F8> :FufBuffer<CR>
"<F11> :call ToggleContrast()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""

" 256 Colors
set t_Co=256

call pathogen#infect()

syntax on
colorscheme zenburn
filetype plugin indent on

let &cpo=s:cpo_save
unlet s:cpo_save


"set title "Show filename in titlebar of window
set cpo&vim
set background=dark
"BS past autoindents, line boundaries, and even the start of insertion
set backspace=indent,eol,start 
set cmdheight=2
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set history=500
set hlsearch
set incsearch
set ruler
set shiftwidth=4
set showcmd
set tabstop=4
set termencoding=utf-8
set encoding=utf-8
set updatetime=500
set wildmenu
set number
set smartindent
set cursorline
set scrolloff=5
set gdefault
set nobackup
set directory=.

set nocompatible
set autoindent
set showmatch
set ignorecase
set smartcase

set expandtab
set shiftround
highlight LineNr ctermfg=Grey

" Save buffer automatically when changing files
set autowrite

" Handle Mac and DOS line-endings but prefer Unix endings
set fileformats=unix,mac,dos

" NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Powerline
set laststatus=2
let g:Powerline_symbols='unicode'

" Grep
set grepprg=/bin/grep
let Grep_OpenQuickfixWindow = 1

" Skeletons
au bufnewfile *.pl 0r ~/.vim/skeletons/template.pl
au bufnewfile *.pm 0r ~/.vim/skeletons/template.pm
au bufnewfile *.t 0r ~/.vim/skeletons/template.t

"Nice Statusline
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}[%l,%v][%p%%]\ %{fugitive#statusline()}
"set laststatus=2

" Map Leader
" Leader is mapped already to \
"let mapleader = ","

" Map Control+arrow keys to useful stuff
map <C-Up>    <PageUp>
map <C-Down>  <PageDown>
map <C-Left>  gT
map <C-Right> gt

" Map tabs better
nmap <C-l> gt

" Easy navigation with splits
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ack
nnoremap <leader>a :Ack

"Create a window and shows prove
nnoremap <silent> _pr :!prove<cr>:cope<cr><cr>


"==============[ F-KEYS ]==================================

" lets not allow F1 open help files! -> doesn't work :(
map <F1> <Esc>
imap <F1> <Esc>

nmap <silent> <F1> :call ToggleFocusMode()<CR>

" Para ficar em modo old style
nmap <silent> <F2> :set invnumber<CR>:NERDTreeClose<CR> 

"Shows GrepBuffer
nnoremap <silent> <F3> :GrepBuffer<CR>

" To toggle paste
set pastetoggle=<F4>

"Refresh current file
nmap <silent> <F5> :e %<CR>

"Activate NERDTREE
nmap <silent> <F7> :NERDTreeToggle<CR>

" Para search do buffer
map <F8> :FufBuffer<CR>

" Activate contrast
function ToggleContrast()
    if exists("g:zenburn_high_Contrast")
        unlet g:zenburn_high_Contrast
    else
      let g:zenburn_high_Contrast = 1
    endif

    colorscheme zenburn
endfunction

nmap <silent> <F11> :call ToggleContrast()<CR>


"==============[ Perl Specific ]=================================


autocmd FileType perl setlocal keywordprg=perldoc\ -T\ -f
autocmd FileType perl set autoindent|set smartindent

" Check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m

" Use tab and shift tab to indent region
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

"Para foldar tudo
xmap za set foldmethod=indent

"But not magic outdenting of comments...
inoremap # X<C-H>#

" Make BS/DEL work as expected
vmap <BS> x

" Insert ticks around word ... must NOT be on last char of word
"map tt ebi'<ESC>ea'<ESC>
map tt ysiw'
map TT ebi{'<ESC>ea'}<ESC>

" When in Visual mode, paste over the selected region...
vmap <silent> <C-P> x:call TransPaste(visualmode())<CR>

function! TransPaste(type)
    " Remember the last yanked text...
    let reg_save = @@

    " Grab the MacOSX clipboard contents via a shell command...
    let clipboard = system("pbtranspaste")

    " Put them in the yank buffer...
    call setreg('@', clipboard, a:type)

    " Paste them...
    silent exe "normal! P"

    " Restore the previous yanked text...
    let @@ = reg_save
endfunction



"quick syntax toggler
map ,sp :set syntax=perl<CR>
map ,sm :set syntax=mason<CR>
map ,sh :set syntax=html<CR>

" Little change to make it return to same line
nnoremap <silent> _t ml:%!perltidy -q<cr><ESC>'l
vnoremap <silent> _t :!perltidy -q<cr>

"clean up xml
nnoremap <silent> _x :%!tidy -quiet -indent -xml -utf8 -w 120<cr>
vnoremap <silent> _x :!tidy -quiet -indent -xml -utf8 -w 120<cr>

" set copiler to perlcritic; make for current file; open error window
nnoremap <silent> _pc :compiler perlcritic<cr>:make<cr>:cope<cr><cr>

" ##### Shortcuts #####

" Insert common Perl code structures...
" warn does not buffer
iab subo sub {<CR>my $s = shift;<CR>my %a = @_;<CR><CR>return;<CR>}<ESC>5kwi
iab dprint print STDERR sprintf("%s %s: %s\n", '<C-R>%','gil', "" );<ESC>?""<CR>a
iab dprintd print STDERR sprintf("%s %s: %s\n", '<C-R>%','gil',Dumper() );<ESC>?()<CR>a

iab cprint $c->log->debug( '<C-R>%' . Dumper() );<ESC>?()<CR>a

" template toolkit
iab ttdump <ESC>o[% USE Dumper %]<CR><pre>[% Dumper.dump_html(detalhe) %]</pre><ESC>?detalhe<CR>cw

" search for use strict;
" Include logger package  
" create a logger global object, jump back to where we were
iab mklogj <ESC>/use strict<CR>jjouse Sonaecom::Logger;<CR>my $l = Sonaecom::Logger::get_logger();<CR><ESC>:sleep 2<ESC>''
map mklogj <ESC>/use strict<CR>jjouse Sonaecom::Logger;<CR>my $l = Sonaecom::Logger::get_logger();<CR><ESC>:sleep 2<ESC>''

iab mklog <ESC>ouse Sonaecom::Logger;<CR>my $l = Sonaecom::Logger::get_logger();<ESC>
map mklog <ESC>ouse Sonaecom::Logger;<CR>my $l = Sonaecom::Logger::get_logger();<ESC>

" Log stuff
iab logthis $c->log->debug(Dumper cena);<ESC>?cena<CR>cw


" ##### End Shortcuts #####

" Add new highlight combinations...
"highlight YELLOW_ON_BLACK ctermfg=yellow ctermbg=black
"highlight WHITE_ON_RED ctermfg=white ctermbg=red

" Track "faux" references...
"function! BadRefs ()
"    match WHITE_ON_RED /_ref[ ]*[[{(]\|_ref[ ]*-[^>]/
"endfunction
"call BadRefs()

" reformat paragraph with no arguments:
"map ** {!} perl -MText::Autoformat -e'autoformat({ all => 1 , justify => 'full' })' j<CR><CR>

" pressing < or > will let you indent/unident selected lines
vnoremap < <g<ESC>
vnoremap > >g<ESC>

" some common typos
command! Qa qa
command! Q  q
command! W  w
command! Wq wq
command! WQ wq

"====[ After Damian Presentation ]====

" Snipet for adding persistent_undo:
if has ('persistent_undo')
    set undodir=$HOME/tmp/.vim/undo_files
    set undolevels=5000
    set undofile
endif

" Use smartcompletion plugin
runtime plugin/smartcom.vim

" Make naughty characters visible...
" (uBB is right double angle, uB7 is middle dot)
exec "set lcs=tab:\uBB\uBB,trail:\uB7,nbsp:~"

augroup VisibleNaughtiness
    autocmd!
    autocmd BufEnter  *       set list
    autocmd BufEnter  *.txt   set nolist
    autocmd BufEnter  *.vp*   set nolist
    autocmd BufEnter  *       if !&modifiable
    autocmd BufEnter  *           set nolist
    autocmd BufEnter  *       endif
augroup END

" Execute files
autocmd FileType perl   nmap W :!clear;echo;echo;perl %;echo;echo;echo<CR>
autocmd FileType python nmap W :!clear;echo;echo;python2 %;echo;echo;echo<CR>

"nmap <Space> <PageDown>


"command! -buffer -bar -range=0 Run :call s:run(<count>, '<args>')
" Do this, put in a function a toggler for folds
" command! Folder   :call :setfoldopen=all<CR>:setfolopen=all<CR>
" command! NoFolder :call :setfoldopen=none<CR>:setfolopen=none<CR>

" Locate Module
map L :cexpr system("locate_mod.pl " . shellescape(expand('<cWORD>')))<cr>:cope<cr><cr>

" Check http://laktek.com/2012/09/05/distraction-free-writing-with-vim/
" turn-on distraction free writing mode for markdown files
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} call DistractionFreeWriting()

function! DistractionFreeWriting()
    "set lines=40 columns=100           " size of the editable area
    "set fuoptions=background:#00f5f6f6 " macvim specific setting for editor's background color 
    "set fullscreen                     " go to fullscreen editing mode
    set background=light
    set gfn=Cousine:h14                " font to use
    set guioptions-=r                  " remove right scrollbar
    set laststatus=0                   " don't show status line
    set noruler                        " don't show ruler
    set linebreak                      " break the lines on words
    set nocursorline                   " don't show cursorline
    set number
    set numberwidth=10
    highlight LineNr term=bold cterm=NONE ctermfg=white ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
    colorscheme iawriter
endfunction


""" FocusMode
" From: http://paulrouget.com/e/vimdarkroom/
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=DarkGrey ctermbg=none
    hi NonText ctermfg=0
    set nocursorline
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    colorscheme zenburn "re-call your colorscheme
  endif
endfunc
