" A VIM config file.
"
" Maintainer:   Guilherme Goncalves <inacio.guilherme@gmail.com>
" Credits:      Bram Moolenaar <Bram@vim.org>
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"     for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"     for OpenVMS:  sys$login:.vimrc


set nocompatible               " be iMproved, required
set encoding=utf-8             " Use utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'valloric/youcompleteme', { 'do': './install.py --tern-completer' }
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'xolox/vim-session'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat', {'do': 'sudo npm install -g eslint js-beautify typescript-formatter'}
Plug 'scrooloose/syntastic', { 'do': 'sudo npm install -g eslint jshint tslint' }
Plug 'SirVer/ultisnips'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'jamescarr/snipmate-nodejs'
Plug 'heavenshell/vim-jsdoc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'geoffharcourt/vim-matchit'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'curist/vim-angular-template'
Plug 'tpope/vim-surround'
Plug 'moll/vim-node'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'suan/vim-instant-markdown', { 'do': 'sudo npm install -g instant-markdown-d' }
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-easytags', { 'do': 'sudo apt-get install exuberant-ctags' }
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
Plug 'Quramy/tsuquyomi', { 'do': 'sudo npm install -g typescript' }
Plug 'junegunn/vim-easy-align'
Plug 'csscomb/vim-csscomb', { 'do': 'sudo npm install -g csscomb' }
call plug#end()


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file (restore to previous version)
  set undofile      " keep an undo file (undo changes after closing)
endif
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching
set number      " display line numbers
set numberwidth=1

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

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
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthisi | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" search tags
set tags=tags;/

" window settings
syntax enable

" gruvbox settings
let g:gruvbox_italicize_strings=1

set background=dark
set t_Co=256
colorscheme gruvbox

nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

" gui settings
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scrollbar
set guioptions-=L  "remove left-hand scrollbar

" split style
set fillchars+=vert:\ 

" font
set guifont=UbuntuMonoDerivativePowerline\ Nerd\ Font\ 11

" airline
set laststatus=2
let g:airline_theme='gruvbox'
let g:airline_detect_spell=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#hunks#enabled = 0
if has('gui_running')
    "let g:airline_powerline_fonts=1

    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    
    "" unicode symbols
    "let g:airline_left_sep = '»'
    "let g:airline_left_sep = ''
    "let g:airline_right_sep = '«'
    "let g:airline_right_sep = ''
    "let g:airline_symbols.crypt = ''
    "let g:airline_symbols.linenr = '␊'
    "let g:airline_symbols.linenr = '␤'
    "let g:airline_symbols.linenr = '¶'
    "let g:airline_symbols.maxlinenr = '☰'
    "let g:airline_symbols.maxlinenr = ''
    "let g:airline_symbols.branch = '⎇'
    "let g:airline_symbols.paste = 'ρ'
    "let g:airline_symbols.paste = 'Þ'
    "let g:airline_symbols.paste = '∥'
    "let g:airline_symbols.spell = 'Ꞩ'
    "let g:airline_symbols.notexists = '∄'
    "let g:airline_symbols.whitespace = 'Ξ'
    
    "" powerline symbols
    "let g:airline_left_sep = ''
    "let g:airline_left_alt_sep = ''
    "let g:airline_right_sep = ''
    "let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
endif

" nerdtree-syntax-highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" hide end of buffer '~'
if has('gui_running')
    hi! EndOfBuffer guibg=bg guifg=bg
else
    hi! EndOfBuffer ctermbg=bg ctermfg=bg
endif

" config hidden characters exibition.
" use with ':set list' and disable with ':set nolist'
"set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
"set nolist

" autoformat
noremap <F3> :Autoformat<CR>

" Store swap files in fixed location, not current directory.
set backupdir=/tmp
set undodir=/tmp
set directory=/tmp

" session settings
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" youcompleteme
"let g:ycm_add_preview_to_completeopt=0
"let g:ycm_confirm_extra_conf=0
"set completeopt-=preview

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

function! GetJSCheckers()
    let checkers = []
    if findfile('.eslintrc', '.;') != '' || findfile('.eslintrc.js', '.;') != ''
        call add(checkers, 'eslint')
    endif
    if findfile('.jshintrc', '.;') != ''
        call add(checkers, 'jshint')
    endif
    return checkers
endfunction

autocmd FileType javascript let b:syntastic_checkers = GetJSCheckers()
let g:syntastic_typescript_checkers = ['tslint', 'tsc']


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

" current directory abreviation '%%'
cabbr <expr> %% expand('%:p:h')
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

set nowrap
set hlsearch

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Set split sides
set splitbelow
set splitright

" Find/Replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Disable bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" highlighting current line
set cul

" auto refresh files
set autoread

" indentLine
let g:indentLine_enabled=1
set listchars=tab:\┆\ 
set list

" ==== NERD tree
" Open the project tree and expose current file in the nerdtree with Ctrl-\
" " calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <C-\> :call OpenNerdTree()<CR>
let NERDTreeShowHidden=1

" disable auto-hide
let g:vim_json_syntax_conceal = 0
set conceallevel=0
set cole=0
au FileType * setl cole=0

" spell
set spell spelllang=en_us,pt_br
set nospell

" default tabsize
set tabstop=4
set shiftwidth=4
set expandtab

" CTRLP settings
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " ignores files .gitignore

" easymotion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" easytags
let g:easytags_async = 1
let g:easytags_resolve_links = 1

" auto-pairs
let g:AutoPairsShortcutBackInsert = '<M-S-b>'
let g:AutoPairsMultilineClose=0

" scroll
set scrolloff=10

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" typescript
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_shortest_import_path = 1
"let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" vue
let g:vue_disable_pre_processors=1
let g:formatters_vue = ['eslint_local']
