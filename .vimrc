" A VIM config file.
"
" Maintainer:   Guilherme Goncalves <inacio.guilherme@gmail.com>
" Credits:      Bram Moolenaar <Bram@vim.org>
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"     for Amiga:  s:.vimrc
"     for MS-DOS and Win32:  $VIM\_vimrc
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
Plug 'valloric/youcompleteme', { 'do': 'sudo ./install.py --tern-completer --clang-completer' }
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-obsession'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale', {'do': 'sudo npm install -g prettier eslint typescript && sudo pip install autopep8 && sudo apt-get install astyle'}
Plug 'SirVer/ultisnips'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'jamescarr/snipmate-nodejs'
Plug 'epilande/vim-react-snippets'
Plug 'heavenshell/vim-jsdoc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'geoffharcourt/vim-matchit'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'curist/vim-angular-template'
Plug 'tpope/vim-surround'
Plug 'moll/vim-node'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'suan/vim-instant-markdown', { 'do': 'sudo npm install -g instant-markdown-d' }
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-easytags', { 'do': 'sudo apt-get install exuberant-ctags' }
Plug 'Yggdroot/indentLine'
Plug 'Quramy/tsuquyomi', { 'do': 'sudo npm install -g typescript' }
Plug 'junegunn/vim-easy-align'
Plug 'csscomb/vim-csscomb', { 'do': 'sudo npm install -g csscomb' }
Plug 'lervag/vimtex'
Plug 'vim-scripts/gnuplot.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-unimpaired'
Plug 'ap/vim-css-color'
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
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch      " do incremental searching
set number         " display line numbers
set numberwidth=1
set updatetime=100 " delay of file's changes tracking (default is 4000)

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

    " always set autoindenting on
    set autoindent

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

set background=dark
set t_Co=256
let g:dracula_italic = 0
if exists('$TMUX')
  let g:dracula_colorterm = 0
endif
colorscheme dracula
"highlight Normal ctermbg=None

" gui settings
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scrollbar
set guioptions-=L  "remove left-hand scrollbar

" airline
set laststatus=2
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#hunks#enabled = 0

" nerdtree-syntax-highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" config hidden characters exibition.
" use with ':set list' and disable with ':set nolist'
"set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
"set nolist

" Store swap files in fixed location, not current directory.
set backupdir=~/.vimtmp
set undodir=~/.vimtmp
set directory=~/.vimtmp

" session settings
"let g:session_autosave = 'no'
"let g:session_autoload = 'no'

" youcompleteme
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" autoformat
noremap <F3> :ALEFix<CR>

" fixers
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'cpp': ['clang-format'],
\    'javascript': ['eslint', 'prettier'],
\    'python': ['autopep8'],
\}
let g:ale_linters = { 'javascript': ['eslint'] }

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
"set listchars=tab:\┆\
"set list

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

" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
noremap <leader><tab> :Files<CR>
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

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
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" custom formatetrs
let g:formatdef_jsbeautify_editorconfig_javascript = '"js-beautify --editorconfig"'

" next grep result
map <F2> :cn<CR>

"latex
let g:polyglot_disabled = ['latex']
let g:tex_conceal = ""

" nohl
nnoremap <silent> ]oh :nohl<CR>

" c/c++
nnoremap <F6> :make<cr>

" wrap
nnoremap <F4> :set wrap linebreak nolist<cr>

" vim project specific config enable
set exrc
set secure

let g:ycm_filepath_blacklist = {}
