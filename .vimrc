if &cp | set nocp | endif
let s:cpo_save=&cpo

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

"Save buffer automatically when changing files
set autowrite

"Handle Mac and DOS line-endings but prefer Unix endings
set fileformats=unix,mac,dos

"NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"Powerline
set laststatus=2
let g:Powerline_symbols='unicode'

"Para o grep
set grepprg=/bin/grep

"Skeletons
au bufnewfile *.pl 0r ~/.vim/skeletons/template.pl
au bufnewfile *.pm 0r ~/.vim/skeletons/template.pm
au bufnewfile *.t 0r ~/.vim/skeletons/template.t

"Statusline catita
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}[%l,%v][%p%%]\ %{fugitive#statusline()}
"set laststatus=2

" Map arrow keys to useful stuff
map <C-Up>    <PageUp>
map <C-Down>  <PageDown>
map <C-Left>  gT
map <C-Right> gt

"Para criar uma janela e mostrar o prove
nnoremap <silent> _pr :!prove<cr>:cope<cr><cr>


"==============[ F-KEYS ]==================================

" lets not allow F1 open help files! -> doesn't work :(
map <F1> <Esc>
imap <F1> <Esc>

" Para toggle number ao mesmo tempo que toggla mouse
"function ToggleMouse()
"    if &mouse == ""
"        set mouse=a
"    else
"        set mouse=
"    endif
"endfunction

" Para ficar em modo old style
nmap <silent> <F2> :set invnumber<CR>:NERDTreeClose<CR> 

" rot13 of current file -> play stuff!
"map <F3> ggVGg?

" Para grep
let Grep_OpenQuickfixWindow = 1
nnoremap <silent> <F3> :GrepBuffer<CR>

" Para togglar paste
"set pastetoggle=<F4>

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
map tt ebi'<ESC>ea'<ESC>
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


"command! -buffer -bar -range=0 Run :call s:run(<count>, '<args>')
" Do this, put in a function a toggler for folds
" command! Folder   :call :setfoldopen=all<CR>:setfolopen=all<CR>
" command! NoFolder :call :setfoldopen=none<CR>:setfolopen=none<CR>

" Locate Module
map L :cexpr system("locate_mod.pl " . shellescape(expand('<cWORD>')))<cr>:cope<cr><cr>
