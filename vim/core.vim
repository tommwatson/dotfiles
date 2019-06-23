" ------------------------------------------------------------------------------
" File: core.vim
" Description: Core configuration that shouldn't require any plugins.
" Author: Christopher Chow <chris@chowie.net>
" ------------------------------------------------------------------------------

" -----------------------------
" Color
" -----------------------------
set background=dark
let base16colorspace=256
set t_Co=256
colorscheme base16-outrun-dark


if &term =~ '^xterm'
  " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
  execute "set t_kP=\e[5;*~"
  execute "set t_kN=\e[6;*~"
         
" Arrow keys http://unix.stackexchange.com/a/34723
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" -----------------------------
" General Settings
" -----------------------------
syntax on

command! W :w                                " Seriously, it's not like :W is bound
set nocompatible                             " Turn off vi compatibility.

set encoding=utf8                            " Always use unicode.
set spelllang=en_au                          " Set spell check language.
set shortmess=aIoO                           " Show short messages, no intro.

set hidden                                   " Allow hidden buffers.
set history=100                              " Size of command history.
set confirm                                  " Enable error files & error jumping.
set autoread                                 " Automatically reload changes if detected

set timeoutlen=200                           " Time to wait for a command (after leader for example).
set ttimeout ttimeoutlen=60                  " Time to wait for a key sequence.

set tags+=tags                               " Enable tags.

set selection=inclusive                      " Select to the end of line.

filetype on                                  " Detect file type.
filetype indent on                           " Enable file indenting.
filetype plugin indent on                    " Load syntax files for better indenting.

if has('mouse')
  set mouse=a                                " Enable mouse everywhere.
  set mousemodel=popup_setpos                " Show a pop-up for right-click.
  set mousehide                              " Hide mouse while typing.
endif

" -----------------------------
" Backups and undo
" -----------------------------
set nobackup                                 " Disable backups.
set nowritebackup
set noswapfile
set undolevels=1000                          " Large undo levels.

" Persistent Undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo
endif

" -----------------------------
" Search and Replace
" -----------------------------
set incsearch                                " Show partial matches as search is entered.
set hlsearch                                 " Highlight search patterns.
set ignorecase                               " Enable case insensitive search.
set smartcase                                " Disable case insensitivity if mixed case.
set wrapscan                                 " Wrap to top of buffer when searching.
set gdefault                                 " Make search and replace global by default.

" -----------------------------
" Text Format
" -----------------------------
set tabstop=2
set backspace=indent,eol,start               " Delete everything with backspace
set shiftwidth=2                             " Tabs under smart indent
set shiftround
set cindent
set autoindent
set smarttab
set expandtab

" -----------------------------
" Visual
" -----------------------------
set showmatch                                " Show matching brackets.
set matchpairs+=<:>                          " Pairs to match.
set matchtime=2                              " How many tenths of a second to blink
set list                                     " Show invisible characters

" Show trailing spaces as dots and carrots for extended lines.
" From Janus, http://git.io/PLbAlw

set listchars=""                             " Reset the listchars
set listchars+=trail:•                       " Show trailing spaces as dots

" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:<

" -----------------------------
" UI
" -----------------------------
set ruler                                    " Show the cursor position.
set nowrap                                   " Line wrapping off
set laststatus=2                             " Always show the statusline
set fillchars+=stl:\ ,stlnc:\ " Space.       " Disable status line fill chars.
set showcmd                                  " Show last command.
set noshowmode                               " Don't show the mode since airline shows it
set title                                    " Set the title of the window in the terminal to the file
set number

if exists('+colorcolumn')
  highlight colorcolumn ctermbg=236 guibg=#262D51
endif

" -----------------------------
" Sounds
" -----------------------------
set noerrorbells
set novisualbell
set t_vb=

" -----------------------------
" Languages
" -----------------------------
au FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab
au FileType julia setlocal tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab
au FileType go setlocal noexpandtab nolist

" -----------------------------
" Run shell command in scratch buffer
" -----------------------------
"

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
