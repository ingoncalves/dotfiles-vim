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

let g:polyglot_disabled = ['latex']

call plug#begin('~/.vim/plugged')
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-obsession'
Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/nerdtree'
Plug 'honza/vim-snippets'
Plug 'jamescarr/snipmate-nodejs'
Plug 'epilande/vim-react-snippets'
Plug 'heavenshell/vim-jsdoc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'moll/vim-node'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'suan/vim-instant-markdown'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-easytags'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-easy-align'
Plug 'csscomb/vim-csscomb'
Plug 'lervag/vimtex'
Plug 'vim-scripts/gnuplot.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-unimpaired'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-abolish'
Plug 'jmcantrell/vim-virtualenv'
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
"set tags=tags;/
set tags=tags

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
let g:NERDTreeNodeDelimiter = "\u00a0" " hides ^G

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

" coc
let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-cmake',
            \ 'coc-css',
            \ 'coc-eslint',
            \ 'coc-fzf-preview',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-ltex',
            \ 'coc-pyright',
            \ 'coc-sh',
            \ 'coc-snippets',
            \ 'coc-stylelintplus',
            \ 'coc-tsserver',
            \ 'coc-xml',
            \ 'coc-yaml'
            \ ]

" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files
set nobackup
set nowritebackup
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
  " " Recently vim can merge signcolumn and number column into one
  " set signcolumn=number
" else
  " set signcolumn=yes
" endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gD <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" autoformat
nmap <leader>f <Plug>(coc-codeaction)

" refactoring
nmap <leader>rf <Plug>(coc-refactor)
nmap <leader>rn <Plug>(coc-rename)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc-snippets config
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" tree-siter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = { },

  indent = {
    enable = true
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

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
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

" indentLine
let g:indentLine_enabled=1
"set listchars=tab:\┆\
"set list

" ==== NERD tree
" Open the project tree and expose current file in the nerdtree with <leader>t
" " calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! OpenNerdTree()
    if &modifiable && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
    else
        NERDTreeToggle
    endif
endfunction
nnoremap <silent> <leader>t :call OpenNerdTree()<CR>
let NERDTreeShowHidden=1

" disable auto-hide
let g:indentLine_setConceal = 0
let g:vim_json_syntax_conceal=0
let g:vim_markdown_conceal=0
let g:vim_markdown_conceal_code_blocks=0
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
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
noremap <leader><tab> :Files<CR>
noremap <leader>] :GFiles<CR>
noremap <leader>A :Rg<CR>
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" easymotion
" <Leader>f{char} to move to {char}
map  <Leader>a <Plug>(easymotion-bd-f)
nmap <Leader>a <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
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

" custom formatetrs
let g:formatdef_jsbeautify_editorconfig_javascript = '"js-beautify --editorconfig"'

" next grep result
map <F2> :cn<CR>

"latex
let g:tex_conceal = ""
let g:vimtex_view_method = 'skim'
let g:tex_flavor='latex'
let g:vimtex_quickfix_open_on_warning = 0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" nohl
nnoremap <silent> ]oh :nohl<CR>

" c/c++
nnoremap <F6> :make<cr>
autocmd BufEnter *.C :setlocal filetype=cpp

" wrap
nnoremap <F4> :set wrap linebreak nolist<cr>

" auto indent on paste
nnoremap p p=`]

" move lines
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==

" Python venv
let g:virtualenv_directory = $PWD

" highlight word under cursor with * without jumpping
nnoremap * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

" vim project specific config enable
set exrc
set secure
