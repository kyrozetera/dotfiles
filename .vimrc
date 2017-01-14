" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

execute pathogen#infect()

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
  set synmaxcol=250 " don't let vim do syntax on long lines. Speeds up terminal vim.
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
	filetype indent on 
	filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set mousemodel=popup

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vimrc
endif

set number
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nosmarttab
set backspace=indent,eol,start

colo default

"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:UltiSnipsExpandTrigger="<C-e>"
"let g:UltiSnipsJumpForwardTrigger="<Tab>"
"let g:UltiSnipsJumpForwardTrigger="<S-Tab>"
"let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
let g:syntastic_php_checkers = ['php', 'phplint', 'phpcs', 'phpmd']

augroup filetype_sbt
    autocmd!
    autocmd BufNewFile,BufRead *.sbt set filetype=sbt
    autocmd FileType sbt setlocal syntax=scala
augroup END

"remove trailing whitespace on save
autocmd BufWritePre *.{php,scala,rs} :call StripWhiteSpace()
function! StripWhiteSpace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

autocmd BufWritePost *.php silent! :call RebuildCscope()
function RebuildCscope()
    !/var/www/hpa/cscope.sh
    :cs reset
endfunction

autocmd FileType php call SetupPHP()
function SetupPHP()
    set omnifunc=phpcomplete#CompletePHP
    "inoremap <buffer> <C-d> <C-O>:call pdv#DocumentWithSnip()<CR>
endfunction

au BufRead,BufNewFile *.twig set filetype=htmldjango

" nginx
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft=='' | setfiletype nginx | endif


"set tags=/var/www/tags
"let php_sql_query=1

let g:session_autosave = 'no'

"nerdtree
if has('autocmd')
"	autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif
let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_new_tab=0

nnoremap <C-RightMouse> :tab split<CR>:exe 'tag ' . expand('<cword>')<CR>
nnoremap <C-\> :tab split<CR>:exe 'tag ' . expand('<cword>')<CR>
nnoremap <C-Left> :tabprev<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Up> :tabfirst<CR>
nnoremap <C-Down> :tablast<CR>
vnoremap . :normal .<CR>

"cscope mappings
nnoremap g<C-\> :silent! cs find 0 <C-R>=expand("<cword>")<CR><CR>:cwindow<CR>
vnoremap <silent> g<C-\> :<C-U>
    \:let old_reg=getreg("")<bar>
    \:let old_regmode=getregtype("")<CR>
    \gvy
    \:silent! cs find s <C-R>=@"<CR><CR>
    \:call setreg("", old_reg, old_regmode)<CR>:cwindow<CR>


"neocomplete
let g:neocomplete#enable_insert_char_pre = 1

":Ack settings
if executable('agc')
  let g:ackprg = 'agc --nogroup --nocolor --column'
endif

let g:ackhighlight = 1
"let g:ack_autofold_results = 1

nnoremap <C-F> :Ack!<space>

let g:ctrlp_max_files = ''

let g:ctrlp_custom_ignore = {
  \ 'dir': '/var/www/hpa/public/js\|/var/www/KoddiETL/.*/target\|/var/www/KoddiETL/.*/project/project\|/var/www/KoddiETL/.*/project/target',
  \ }

"  \ 'dir': '\v[\/](public/js)',

"use all 256 colors
set t_Co=256

"vimdiff colors
highlight DiffAdd    cterm=bold ctermfg=white ctermbg=darkgreen gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=white ctermbg=darkblue gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=grey ctermbg=cyan gui=none guifg=bg guibg=Red
highlight! link DiffText Todo

omap i,w i,e
xmap i,w i,e

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
imap <buffer> <C-Right> <C-O>w
imap <buffer> <C-Left> <C-O>b
sunmap w
sunmap b
