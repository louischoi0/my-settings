set nocompatible              " be iMproved, required set runtimepath^=~/.vim/bundle/ctrlp.vim "filetype off                  " required                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                                                                                                           
" set the runtime path to include Vundle and initialize                                                                                                                                                                                                                                                                                                    
set rtp+=~/.vim/bundle/Vundle.vim                                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                           
call vundle#begin()                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                           
" let Vundle manage Vundle, required                                                                                                                                                                                                                                                                                                                       
Plugin 'VundleVim/Vundle.vim'                                                                                                                                                                                                                                                                                                                              
Plugin 'vim-airline/vim-airline'                                                                                                                                                                                                                                                                                                                           
Plugin 'vim-airline/vim-airline-themes'                                                                                                                                                                                                                                                                                                                    
Plugin 'scrooloose/syntastic'                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                           
"Plugin 'tpope/vim-fireplace'                                                                                                                                                                                                                                                                                                                              
"Plugin 'guns/vim-clojure-static'                                                                                                                                                                                                                                                                                                                          
"Plugin 'clojure-vim/async-clj-highlight'                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                           
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }                                                                                                                                                                                                                                                                                        
Plugin 'junegunn/fzf.vim'                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                           
Plugin 'cormacrelf/vim-colors-github'                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                           
Plugin 'derekwyatt/vim-scala'                                                                                                                                                                                                                                                                                                                              
Plugin 'neoclide/coc.nvim',{'branch' :'release'}                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                           
au BufRead,BufNewFile *.sbt set filetype-scala                                                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                           
call vundle#end()            " required                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                           
let g:scala_sort_across_groups=1                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                           
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

"color wizard
let g:github_colors_soft = 5
let g:airline_theme = "github"
colorscheme github

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
"let g:clojure_maxlines=100

" To debug in repl.
"nnoremap <F2> :Eval<ENTER>
