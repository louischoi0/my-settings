set nocompatible              " be iMproved, required set runtimepath^=~/.vim/bundle/ctrlp.vim "filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-python/python-syntax'

Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

Plugin 'morhetz/gruvbox'

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
set background=dark
colorscheme gruvbox 


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
"

nnoremap <F2> :set hlsearch<ENTER>
nnoremap <F3> :nohlsearch<ENTER>

" To change airline theme macro. type theme name at end of line.
nnoremap <F5> :AirlineTheme 
map <F7> a(<ESC>
map <F8> a)<ESC>
nmap <F10> :NERDTreeToggle<CR>
nmap <F9> :NERDTree<CR>

" Comment in clojure.
"map <F4> 0i;<ESC>j

" Comment in python.
map <F4> 0i#<ESC>j

" Replace ctrl + b,f to k,j to take adventage of using ctrl + b in tmux.
map <C-j> <C-f>
map <C-k> <C-b>

" execute at ahead buffer of word to embrace with ().
" * is cursor.
" example - *map to (map)*

map <F5> <F7>hwe<F8>

set tags=./tags;,tags;

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd l

" Cscope database setting.
"""
"function! LoadCscope() let db = findfile("cscope.out", ".;") if (!empty(db))
"	let path = strpart(db, 0, match(db, "/cscope.out$")) set
"	nocscopeverbose " suppress 'duplicate connection' error exe "cs add "
"	. db . " " . path set cscopeverbose " else add the database pointed to
"	by environment variable elseif $CSCOPE_DB != "" cs add $CSCOPE_DB
"endif endfunction au BufEnter /* call LoadCscope()

set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c
"
" " always show signcolumns
" set signcolumn=yes
"
" " Some server have issues with backup files, see #649
 set nobackup
 set nowritebackup
"
" " Better display for messages
" set cmdheight=2
"
" " Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"
" " Use <cr> for confirm completion, `<C-g>u` means break undo chain at
" current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
" " Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
"
" " Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" " Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
"
" " Remap for do action format
 nnoremap <silent> F :call CocAction('format')<CR>
"
" " Use K for show documentation in preview window
 nnoremap <silent> K :call <SID>show_documentation()<CR>
"
 function! s:show_documentation()
   if &filetype == 'vim'
       execute 'h '.expand('<cword>')
         else
             call CocAction('doHover')
               endif
               endfunction

               " Highlight symbol under cursor on CursorHold
               autocmd CursorHold * silent call CocActionAsync('highlight')

               " Remap for rename current word
               nmap <leader>rn <Plug>(coc-rename)

               " Show all diagnostics
               nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
               " Find symbol of current document
               nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
               " Search workspace symbols
               nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
               " Do default action for next item.
               nnoremap <silent> <space>j  :<C-u>CocNext<CR>
               " Do default action for previous item.
               nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
               " Resume latest coc list
               nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
"let g:fzf_colors =
			"\ { 'fg':      ['fg', 'Normal'],
  "\ 'bg':      ['bg', 'Normal'],
  "\ 'hl':      ['fg', 'Comment'],
  "\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  "\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  "\ 'hl+':     ['fg', 'Statement'],
  "\ 'info':    ['fg', 'PreProc'],
  "\ 'border':  ['fg', 'Ignore'],
  "\ 'prompt':  ['fg', 'Conditional'],
  "\ 'pointer': ['fg', 'Exception'],
  "\ 'marker':  ['fg', 'Keyword'],
  "\ 'spinner': ['fg', 'Label'],
  "\ 'header':  ['fg', 'Comment'] }
"
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
"let g:fzf_history_dir = '~/.local/share/fzf-history'
