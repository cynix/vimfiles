" pathogen {{{
  filetype off 
  call pathogen#helptags()
  call pathogen#runtime_append_all_bundles()
" }}}

" basic config {{{
  syntax on
  filetype plugin indent on

  set nocompatible
  set nobackup
  set nowritebackup
  set noswapfile
  set undofile
  set undodir=~/.vim/tmp
  set autochdir

  set fileformats=unix,dos
  set fileformat=unix

  set showmatch
  set matchpairs+=<:>
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
  set relativenumber
  set ruler
  set cursorline
  set showcmd
  set showmode
  set virtualedit=block
  set confirm
  set updatetime=1500
  set history=1000
  set undolevels=1000
  set viminfo='1000,h,s1000
  set diffopt+=context:3
  set statusline=%F%m%r%h%w\ [%{&ff}%(/%{&ft}%)]%=\ [%03.3b/0x%02.2B]\ [%04l,%04v]\ [%p%%\ of\ %L]
  execute 'set listchars=eol:'.nr2char(172).',trail:'.nr2char(183).',tab:'.nr2char(8227).'\ ,extends:'.nr2char(8250).',precedes:'.nr2char(8249).',nbsp:'.nr2char(171)

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
  set textwidth=72
  set colorcolumn=80
  set formatoptions=croqwanlmB1
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
    set shiftwidth=2
    set tabstop=8
    set softtabstop=4
    set shiftround
    set expandtab
    set smarttab
  " }}}

  " highlight redundant spaces {{{
    hi RedundantSpaces ctermfg=214 ctermbg=160 cterm=bold
    match RedundantSpaces / \+\ze\t/
  " }}}

  " highlight conflict markers {{{
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
    " jump to next conflict
    nmap <silent> <Leader>> /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
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

" mappings {{{
  " insert blank line below/above without entering insert mode {{{
    nnoremap - :put=''<CR>
    nnoremap + :put!=''<CR>
  " }}}

  " visual mode indent/unindent {{{
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv
  " }}}

  " D is d$, C is c$, so why should Y be yy? {{{
    noremap Y y$
  " }}}

  " use ctrl-n/p to go to next/prev file (instead of like j/k) {{{
    nnoremap <C-n> :bn<CR>
    nnoremap <C-p> :bp<CR>
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
  
  " sudo write {{{
    command! -bar -nargs=0 W  silent! exec "write !sudo tee % >/dev/null"  | silent! edit!
  " }}}

  " always use very magic regexes {{{
    nnoremap / /\v
    vnoremap / /\v
  " }}}

  " use tab for bracket matching {{{
    nnoremap <Tab> %
  " }}}

  " FuzzyFinder {{{
    nmap <silent> <Leader><Tab> :FufBuffer<CR>
    nmap <silent> <Leader><S-Tab> :FufFile<CR>
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
      au FileType make set noexpandtab shiftwidth=8
    " }}}
  augroup END " }}}
" }}}
