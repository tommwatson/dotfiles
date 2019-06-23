call plug#begin('~/.vim/plugged')

" Language / syntax support.
" Plug 'tpope/vim-haml'
" Plug 'tpope/vim-rails'
" Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-markdown'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rake'
" Plug 'vim-ruby/vim-ruby'
" Plug 'dsawardekar/portkey' | Plug 'dsawardekar/ember.vim'
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'kchmck/vim-coffee-script'
" Plug 'fatih/vim-go'
" Plug 'rust-lang/rust.vim'
" Plug 'hail2u/vim-css3-syntax'
" Plug 'groenewege/vim-less'
" Plug 'elzr/vim-json'
" Plug 'noprompt/vim-yardoc'
" Plug 'othree/html5.vim'
" Plug 'othree/yajs.vim'
" Plug 'ap/vim-css-color'
" Plug 'ynkdir/vim-vimlparser' | Plug 'syngan/vim-vimlint'
" Plug 'mutewinter/tomdoc.vim'
" Plug 'cespare/vim-toml'
" Plug 'hashivim/vim-hashicorp-tools'
" Plug 'apeschel/vim-syntax-syslog-ng'
" Plug 'evanmiller/nginx-vim-syntax'
Plug 'python-mode/python-mode', {'branch': 'develop'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'Soliah/vim-test'
" Plug 'godlygeek/tabular'
" Plug 'tomtom/tcomment_vim'
" Plug 'henrik/rename.vim'
" Plug 'scrooloose/syntastic'
" Plug 'benekastah/neomake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Valloric/YouCompleteMe'
" Plug 'dyng/auto_mkdir'
" Plug 'posva/vim-vue'
Plug 'JuliaEditorSupport/julia-vim'

" Themes
Plug 'chriskempson/base16-vim'

call plug#end()

" source ~/.vim/platform.vim
source ~/.vim/core.vim
source ~/.vim/plugins.vim
source ~/.vim/mappings.vim

" Strip Trailing Whitespace
function! StripTrailingWhitespace()
    if !&binary && &modifiable && &filetype != 'diff'
        let l:winview = winsaveview()
        %s/\s\+$//e
        let @/=''
        call winrestview(l:winview)
    endif
endfunction
nnoremap <leader>W :call StripTrailingWhitespace()<CR>
