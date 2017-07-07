" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif



if has("cscope")
	if has("win32")
		set csprg=cscope
"	else
"		set csprg=~/bin/cscope
	endif
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif




""""""""""""giggham""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""



function! Filetype_c()
	set cindent
	set smartindent
	set autoindent
	set cino+=:0 "dont' indent case:
	set cino+=g0 "indent c++ public private etc...
endfunction

function! Filetype_cpp()
	set cindent complete=.,w,b,u,k
	set smartindent
	set autoindent
	set cino+=:0 "dont' indent case:
	set cino+=g0 "indent c++ public private etc...
endfunction


augroup filesetting
	autocmd FileType c				call Filetype_c()
	autocmd FileType cpp			call Filetype_cpp()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000 " How many lines of history to remember
set clipboard+=unnamed " turns out I do like is sharing windows clipboard
if has("win32")
	set ffs=dos,unix,mac " support all three,in this order
else
	set ffs=unix,dos,mac " support all three,in this order
endif
set viminfo+=! " make sure it can save viminfo
set isk+=_,$,@,%,#,- " none of these should be word dividers,so make them not be
set autowrite
set autoread
set nobackup
if (has("gui_running"))
	set background=dark " we are using a dark background
	set nowrap
    "if has("gui_gtk2")
    "    set guifont=WenQuanYi\ Micro\ Hei\ Mono\ 12
    "elseif has("x11")
    "    set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
    "elseif has("gui_win32")
    "    set guifont=Courier_New:h12:cANSI
    "endif
	colorscheme torte
	"colorscheme Dim
	"colorscheme darkblue
	"colorscheme baycomb
	"colorscheme desert
	"colorscheme biogoo
	"colorscheme oceandeep
	"colorscheme wintersday
	"colorscheme desertedocean
	"colorscheme navajo
else
	set wrap
	colo ron
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wmh=0 "This sets the minimum window height to 0
set lsp=0 " space it out a little more (easier to read)
set wildmenu " turn on wild menu
set wildmode=list:longest,full
set ruler " Always show current positions along the bottom
set cmdheight=2 " the command bar is 2 high
"set number " turn on line numbers
set lz " do not redraw while running macros (much faster) (LazyRedraw)
set hid " you can change buffer without saving
set switchbuf=useopen 
set backspace=2 " make backspace work normal
set whichwrap=b,s,<,>,[,],h,l  " backspace and cursor keys wrap to
set shortmess=atI " shortens messages to avoid 'press a key' prompt
set report=0 " tell us when anything is changed via :...
" make the splitters between windows be blank
"set fillchars=vert:\,stl:\,stlnc:\
set guioptions-=b
"set guioptions-=T "get rid of toolbar
"set guioptions-=m "get rid of menu
"set guioptions-=e "remove the gui tabbar
set winaltkeys=no
if version>=700
	set pumheight=10 "set popup menu hight
	set showtabline=2
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showcmd
set showmatch " show matching brackets
set matchpairs=(:),{:},[:],<:>
set mat=5 " how many tenths of a second to blink matching brackets for
set nohlsearch " do not highlight searched for phrases
set incsearch " BUT do highlight as you type you search phrase
set ignorecase
set smartcase
"set listchars=tab: \ | \ ,trail: .,extends: > ,precedes: < ,eol: $ " what to show when I hit :set list
"set lines=41 " 80 lines tall
"set columns=160 " 160 cols wide
set so=5 " Keep 10 lines (top/bottom) for scope
set novisualbell " don't blink
set noerrorbells " no noises
set titlestring=%F
set statusline=%k(%02n)%t%m%r%h%w\ \[%{&ff}:%{&fenc}:%Y]\ \[line=%04l/%04L\ col=%03c/%03{col(\"$\")-1}]\ [%p%%]
set laststatus=2 " always show the status line
"set cursorline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set fo=tcrqn " See Help (complex)
set hls
set tabstop=2 " tab spacing (settings below are just to unify it)
set softtabstop=2 " unify
set shiftwidth=2 " unify
set expandtab " real tabs please!
"set nowrap
set wrap " do not wrap lines
set smarttab " use tabs at the start of a line,spaces elsewhere
"set autoindent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"file encoding
set fileencodings=ucs-bom,utf-8,prc,latin1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"    Enable folding,but by default make it act like folding is off,because folding is annoying in anything but a few rare cases
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable " Turn on folding
"set foldmethod=indent " Make folding indent sensitive
set foldmethod=manual " Make folding indent sensitive
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen-=search " don't open folds when you search into them
set foldopen-=undo " don't open folds when you undo stuff


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer Explorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <F11> :BufExplorer<CR>

let bufExplorerDefaultHelp=0
let bufExplorerDetailedHelp=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagList
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"for Windows only
if has("win32")
	set path=.
	let Tlist_Ctags_Cmd='ctags.exe' " Location of ctags
else
	set path=.
endif
let Tlist_Sort_Type="order" " order by

let Tlist_Compact_Format=1
let Tlist_Exit_OnlyWindow=1 " if you are the last,kill yourself

" Automatically close the folds for the non-active files in the taglist window
let Tlist_File_Fold_Auto_Close=1
let Tlist_Enable_Fold_Column=0 " Do not show folding tree

let Tlist_Show_Menu=0

"Display the tags for only one file in the taglist window
let Tlist_Show_One_File=1

"Display tag prototypes or tag names in the taglist window
let Tlist_Display_Tag_Scope=1
let Tlist_Close_On_Select=0
let Tlist_Display_Prototype=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Highlight_Tag_On_BufEnter=1
let Tlist_Process_File_Always=0

noremap <silent> <F12> :TlistToggle<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
    autocmd GUIEnter * simalt ~x
endif
"autocmd BufEnter * let &titlestring = hostname() . ':' . expand('%f')
autocmd BufEnter * : syntax sync fromstart " ensure every file does syntax highlighting (full)
"autocmd BufEnter * lcd%:p:h "??????????????



" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\ exe "normal g`\"" |
			\ endif

if version>=700
	if has("autocmd") && exists("+omnifunc")
		autocmd Filetype *
					\ if &omnifunc=="" |
					\ setlocal omnifunc=syntaxcomplete#Complete |
					\ endif
	endif
endif


noremap j gj
noremap k gk

"jone line in insert mode
inoremap <C-j> <C-o>J

"tab opt

if has("win32")
	nnoremap <A-1> 1gt
	nnoremap <A-2> 2gt
	nnoremap <A-3> 3gt
	nnoremap <A-4> 4gt
	nnoremap <A-5> 5gt
	nnoremap <A-6> 6gt
	nnoremap <A-7> 7gt
	nnoremap <A-8> 8gt
	nnoremap <A-9> 9gt
nnoremap <A-h> :tabp<CR>
nnoremap <A-l> :tabn<CR>
nnoremap <A-t> :tabnew<CR>
nnoremap <A-w> :tabclose<CR>
nnoremap <C-Tab> gt
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"abbr
iabbr teh the
iabbr #d #define
iabbr #i #include <>
iabbr #b /************************************************
iabbr #e ************************************************/
iabbr rt return TRUE;
"iabbr rf return FALSE;
iabbr jt <c-r>=strftime("%Y-%m-%d")<cr>



"cscope
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>z :cs find s 




"NSN FUCKING CODING STYLE
if filereadable("Imakefile")
	source $HOME/workdir/conf/chorus_vimrc
endif

if $TERM!="linux"
   set mouse=a
endif

"imap { {<CR>}<UP><END><CR>

"quickfix
nnoremap <silent> <F10> *:vimgrep /<C-R>//g **/*.h **/*.c<CR> :cw<CR>
nnoremap <silent> <F9> *:vimgrep /<C-R>//g *.c *.h <CR> :cw<CR>
nnoremap <silent> <F8> *:vimgrep /<C-R>//g *.* <CR> :cw<CR>
nmap <silent> <F3> :cn<CR>
nmap <silent> <F4> :cp<CR>

augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end
augroup filetype
    au! BufRead,BufNewFile *.proto setfiletype proto
augroup end


"nerdtree
noremap <silent> <F11> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.vim$', '\~$', '\.o$']

"clang_complete
"let g:clang_complete_copen=1
"let g:clang_periodic_quickfix=1
"let g:clang_snippets=1
"let g:clang_close_preview=1
"let g:clang_use_library=1

