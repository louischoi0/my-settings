set nocompatible              " be iMproved, required
"filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'

"Plugin 'nanotech/jellybeans.vim'
Plugin 'arzg/vim-wizard'
Plugin 'tpope/vim-fireplace'
Plugin 'guns/vim-clojure-static'
Plugin 'clojure-vim/async-clj-highlight'

call vundle#end()            " required

syntax on
filetype plugin indent on    " required

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
  \ 'file': '\v\.(exe|so|dll)$'
\ }
let g:airline_theme="base16_pop"

let g:clojure_syntax_keywords = {
    \ 'clojureMacro': ["defproject", "defcustom"],
    \ 'clojureFunc': ["string/join", "string/replace"]
    \ }

color wizard 

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction

" vim-clojure-static의 구문 강조 기능이 한번에 처리할 최대 행 수
" 높은 값일수록 긴 함수를 만났을 때 처리시간이 오래 걸린다.
" 0으로 설정하면 제한없이 끝까지 처리.
let g:clojure_maxlines=100

" To debug in repl.
nnoremap <F2> :Eval<ENTER>

" To change airline theme macro. type theme name at end of line.
nnoremap <F5> :AirlineTheme 
map <F7> a(<ESC>
map <F8> a)<ESC>

" Comment in clojure.
map <F4> 0i;<ESC>j

" Comment in python.
map <F3> 0i#<ESC>j

" Replace ctrl + b,f to k,j to take adventage of using ctrl + b in tmux.
map <C-j> <C-f>
map <C-k> <C-b>

" execute at ahead buffet of word to embrace with ().
" * is cursor.
" example - *map to (map)*

map <F5> <F7>we<F8>

