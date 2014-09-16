" bootstrap {{{
  set nocompatible
  filetype off

  if has('vim_starting')
    if isdirectory('~/.vim/bundle/neobundle.vim')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    else
      let &runtimepath .= ',' . escape(fnamemodify(resolve(expand('<sfile>')), ':h') . '/bundle/neobundle.vim/', '\,')
    endif
  endif

  call neobundle#rc(expand('~/.vim/bundle/'))

  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'chrisbra/SudoEdit.vim'
  NeoBundle 'ciaranm/securemodelines'
  NeoBundle 'ConflictDetection', { 'depends': 'ingo-library' }
  NeoBundle 'ConflictMotions', { 'depends': ['ingo-library', 'CountJump'] }
  NeoBundle 'CursorLineCurrentWindow'
  NeoBundle 'cynix/auto-neobundle'
  NeoBundle 'cynix/vimproc.vim', { 'build': { 'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak' } }
  NeoBundle 'derekwyatt/vim-fswitch'
  NeoBundle 'digitaltoad/vim-jade'
  NeoBundle 'evanmiller/nginx-vim-syntax'
  NeoBundle 'godlygeek/tabular'
  NeoBundle 'gregsexton/gitv', { 'depends': [['tpope/vim-fugitive', { 'augroup': 'fugitive' }]] }
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'kien/ctrlp.vim'
  NeoBundle 'Lokaltog/powerline', { 'rtp': 'powerline/bindings/vim' }
  NeoBundle 'Lokaltog/vim-easymotion'
  NeoBundle 'maxbrunsfeld/vim-yankstack'
  NeoBundle 'othree/html5.vim'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'Raimondi/delimitMate'
  NeoBundle 'RelativeNumberCurrentWindow'
  NeoBundle 'scrooloose/nerdcommenter'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'Shougo/vimfiler', { 'depends': 'Shougo/unite.vim' }
  NeoBundle 'tpope/vim-fugitive', { 'augroup': 'fugitive' }
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'tpope/vim-repeat'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tpope/vim-unimpaired'
  NeoBundle 'Valloric/MatchTagAlways'
  NeoBundle 'vim-ruby/vim-ruby'

  if (v:version > 703 || v:version == 703 && has('patch584')) && has('python') && (filereadable('/usr/lib/libclang.dylib') || filereadable('/Library/Developer/CommandLineTools/usr/lib/libclang.dylib') || filereadable('/usr/local/lib/libclang.so') || filereadable('/opt/local/lib/libclang.so') || filereadable('/usr/lib64/libclang.so') || filereadable('/usr/lib/libclang.so'))
    NeoBundle 'Valloric/YouCompleteMe', { 'augroup': 'youcompleteme', 'build': { 'mac': './install.sh --clang-completer --system-clang', 'unix': './install.sh --clang-completer --system-clang' } }
  endif

  filetype plugin indent on

  NeoBundleCheck
  augroup AutoNeoBundle
    autocmd!
    autocmd VimEnter * call auto_neobundle#update_weekly()
  augroup END
" }}}

" basic config {{{
  syntax on

  set nobackup
  set nowritebackup
  set noswapfile
  set autochdir

  if exists('+undofile')
    if !isdirectory(expand('~/.vim/tmp')) && exists('*mkdir')
      call mkdir(expand('~/.vim/tmp'), 'p', 0700)
    endif

    set undofile
    set undodir=~/.vim/tmp
  endif

  set fileformats=unix,dos
  set fileformat=unix

  set showmatch
  set matchtime=5

  set backspace=indent,eol,start
  set shortmess=flmnrxoOrTI
  set iskeyword+=_,$,@,%,#
  set hidden
  set encoding=utf-8
  set termencoding=utf-8
  set title
  set autoread
  set autowrite
  set report=0

  let mapleader = ','
  " swap backtick with apostrophe {{{
    nnoremap ' `
    nnoremap ` '
  " }}}
  " make shift-tab work {{{
    map <Esc>[Z <S-Tab>
    ounmap <Esc>[Z
  " }}}

  set wildmenu
  set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.dylib,*.dmg,*.pdf
  set wildmode=full
" }}}

" UI options {{{
  " highlight unwanted whitespace {{{
    au ColorScheme * highlight ExtraWhitespace ctermbg=52 guibg=52 
    au BufWinEnter * let w:extra_whitespace=matchadd('ExtraWhitespace', '\s\+$', -1)
  " }}}

  " adjust gutter color {{{
    au ColorScheme * highlight SignColumn ctermbg=NONE
  " }}}

  " color scheme {{{
    set background=dark
    set t_Co=256
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    colorscheme solarized
  " }}}

  " restore screen {{{
    set restorescreen
    set t_ti=[?1049h
    set t_te=[?1049l
  " }}}

  set mouse=nv
  set ttyfast
  set laststatus=2
  set number
  set numberwidth=5
  set ruler
  set cursorline
  set showcmd
  set showmode
  set virtualedit=block
  set confirm
  set updatetime=4000
  set history=1000
  set undolevels=1000
  set viminfo='1000,h,s1000
  set diffopt+=context:3
  execute 'set listchars=eol:'.nr2char(172).',trail:'.nr2char(183).',tab:'.nr2char(187).'\ ,extends:'.nr2char(8250).',precedes:'.nr2char(8249).',nbsp:'.nr2char(171)

  if exists('+relativenumber')
    set relativenumber
  endif

  " scrolling {{{
    set scrolloff=5
    set sidescrolloff=5
    set scrolljump=5
    set sidescroll=5
  " }}}

  set splitbelow splitright
  set noequalalways
" }}}

" text options {{{
  set autoindent
  set smartindent
  set nowrap
  set textwidth=80
  set formatoptions=roqwnlmB1
  set linebreak
  set nostartofline
  set comments=s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:-,b:\"

  " search {{{
    set ignorecase
    set smartcase
    set incsearch
    set hlsearch
    set gdefault
  " }}}

  " tabs {{{
    set tabstop=4
    set softtabstop=0
    set shiftwidth=4
    set shiftround
    set smarttab
    set noexpandtab
  " }}}

  " highlight redundant spaces {{{
    hi RedundantSpaces ctermfg=214 ctermbg=160 cterm=bold
    match RedundantSpaces / \+\ze\t/
  " }}}
" }}}

" folding {{{
  set foldenable
  set foldmethod=marker
  set foldlevel=0
  set foldcolumn=0
" }}}

" secure modelines {{{
  set nomodeline
  let g:secure_modelines_verbose=0
" }}}

" tags {{{
  let g:GtagsCscope_Auto_Load=1
  let g:GtagsCscope_Auto_Map=0
  let g:GtagsCscope_Absolute_Path=1
  let g:GtagsCscope_Keep_Alive=1
  let g:GtagsCscope_Quiet=1
" }}}

" auto-complete and syntax checking {{{
  let g:ycm_add_preview_to_completeopt=1
  let g:ycm_confirm_extra_conf=0
  let g:syntastic_check_on_open=1
  let g:syntastic_enable_signs=0
  let g:syntastic_quiet_messages={'level': 'warnings'}
  highlight SyntasticError     ctermfg=white ctermbg=124 guifg=NONE guibg=NONE gui=undercurl guisp=#ff0000
  highlight SyntasticErrorSign ctermfg=white ctermbg=red guifg=white guibg=red
" }}}

" indent guides {{{
  let g:indent_guides_auto_colors=0
  au VimEnter,ColorScheme * :hi IndentGuidesOdd  ctermbg=234
  au VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=NONE
" }}}

" vimfiler {{{
  let g:vimfiler_as_default_explorer = 1
" }}}

" easymotion {{{
  let g:EasyMotion_leader_key = '<Leader>'
" }}}

" ConflictDetection/ConflictMotions {{{
  highlight def conflictOursMarker   ctermfg=red
  highlight def conflictTheirsMarker ctermfg=red
  highlight def link conflictBaseMarker conflictBase
  let g:ConflictMotions_ConflictBeginMapping = 'c'
  let g:ConflictMotions_ConflictEndMapping   = 'C'
  let g:ConflictMotions_ConflictMapping      = 'c'
" }}}

" delimitMate {{{
  let g:delimitMate_expand_cr=1
  let g:delimitMate_expand_space=1
" }}}

" mappings {{{
  " map jk to Esc in insert mode
  inoremap jk <Esc>

  " insert blank line below/above without entering insert mode {{{
    nnoremap - :put=''<CR>
    nnoremap + :put!=''<CR>
  " }}}

  " visual mode indent/unindent {{{
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv
  " }}}

  " D is d$, C is c$, so why should Y be yy? {{{
    call yankstack#setup()
    nmap Y y$
  " }}}

  " jump to tags and symbols {{{
    nnoremap <C-g> :cs find d <C-R>=expand("<cword>")<CR>:<C-R>=line('.')<CR>:%:p<CR>
    nnoremap <silent> <C-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>
    nnoremap <silent> <C-t> <C-o>
  " }}}

  " switch to companion file {{{
    nnoremap <C-o> :FSHere<CR>
  " }}}

  " p in visual mode replaces selected text with the "" register {{{
    vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>
  " }}}

  " remove search highlight {{{
    nnoremap <silent> <Leader>/ :nohls<CR>
  " }}}

  " toggle list mode {{{
    nnoremap <silent> <Leader>l :set invlist list?<CR>
  " }}}

  " toggle paste mode {{{
    nnoremap <silent> <Leader>p :set invpaste paste?<CR>
  " }}}

  " toggle wrap {{{
    nnoremap <silent> <Leader>r :call ToggleWrap()<CR>
    function! ToggleWrap()
      if &wrap
        echo "wrap off"
        setlocal nowrap
        silent! nunmap <buffer> k
        silent! nunmap <buffer> j
        silent! nunmap <buffer> 0
        silent! nunmap <buffer> ^
        silent! nunmap <buffer> $
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
      else
        echo "wrap on"
        setlocal wrap display+=lastline
        noremap  <buffer> <silent> k gk
        noremap  <buffer> <silent> j gj
        noremap  <buffer> <silent> 0 g0
        noremap  <buffer> <silent> ^ g^
        noremap  <buffer> <silent> $ g$
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
      endif
    endfunction
  " }}}

  " toggle fold {{{
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':'30j')<CR>
    vnoremap <Space> zf
  " }}}

  " always use very magic regexes {{{
    nnoremap / /\v
    vnoremap / /\v
  " }}}

  " use tab for bracket matching {{{
    nmap <Tab> %
  " }}}

  " windows and buffers {{{
    nnoremap \ <C-w>
    nmap \\ :b#<CR>
    nmap \d :bd<CR>
    nmap \b :CtrlPBuffer<CR>
  " }}}
" }}}

" autocommands {{{
  augroup General " {{{
    autocmd!
    " restore cursor position {{{
      au BufReadPost *
        \ if &filetype !~ 'commit\c' |
        \   if line("'\"") > 0 && line("'\"") <= line("$") |
        \     exe "normal! g`\"" |
        \   endif |
        \ endif
    " }}}

    " vim help {{{
      au FileType help au BufEnter,BufWinEnter <buffer>
        \ setlocal nonumber |
        \ nnoremap <buffer> <Space> <C-]> |
        \ nnoremap <buffer> <BS>    <C-T>
    " }}}

    " diff highlighting {{{
      au FileType diff hi clear RedundantSpaces |
        \ hi DiffCol ctermbg=238 cterm=bold |
        \ match DiffCol /^[ +-]\([+-]\)\@!/
    " }}}

    " makefiles {{{
      au FileType make setlocal tabstop=8 shiftwidth=8 noexpandtab
      au FileType cmake setlocal tabstop=4 shiftwidth=4 expandtab
    " }}}

    " html/xml {{{
      au FileType html,xhtml,xml,xsd setlocal tabstop=2 shiftwidth=2 expandtab matchpairs+=<:>
    " }}}

    " ruby {{{
      au FileType ruby,yaml setlocal tabstop=2 shiftwidth=2 expandtab
    " }}}

    " python {{{
      au FileType python setlocal tabstop=4 shiftwidth=4 expandtab
    " }}}

    " auto-wrap text and text-like files {{{
      au BufNewFile,BufRead *.txt setfiletype text
      au FileType text,tex,plaintex,markdown setlocal formatoptions+=t | setlocal spell
    " }}}

    " Jamfiles {{{
      au BufNewFile,BufRead *.jam,Jamfile setlocal tabstop=2 shiftwidth=2 expandtab
    " }}}
  augroup END " }}}

  augroup AutoCloseWindows " {{{
    autocmd!

    " automatically close quickfix window
    au WinEnter *
      \ if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&buftype') == 'quickfix' |
      \   quit |
      \ endif

    " automatically close preview window
    au InsertLeave  * if pumvisible() == 0 | silent! pclose | endif
  augroup END " }}}

  augroup FSwitchConfig " {{{
    autocmd!

    au BufEnter *.cc let b:fswitchdst='h,hh'
    au BufEnter *.h  let b:fswitchdst='c,cc,cpp,m'
  augroup END " }}}
" }}}

" use local vimrc if available {{{
  if filereadable(expand('$VIM/vimrc.local'))
    source $VIM/vimrc.local
  endif
  if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
  endif
" }}}

" vim: set ts=2 sw=2 et
