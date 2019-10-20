"        __________   ____________
"       |  ________| |____    ____| 
"       |  |  __________  |  |                      
"       |  | |   _______| |  |  File: 	     .vimrc
"       |  | |  |_______  |  |  Desc:  	     Personal Vim configuration
"       |  | |_______   | |  |             
"       |  |  _______|  | |  |  Maintainer:  <Justin Saluja>           
"       |  | |__________| |  |  Email:       <salujajustin@gmail.com>            
"   ____|  |____   _______|  |  Github:      <salujajustin>                               
"  |____________| |__________|

set packpath^=~/.vim
packadd minpac

if exists('*minpac#init')
    " minpac is loaded
    call minpac#init({'verbose': 3})
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " delete, change, add surroundings: ()[]{}<>...
    call minpac#add('tpope/vim-surround')
    " autocomplete 
    call minpac#add('maralla/completor.vim')
    " commenting code
    call minpac#add('scrooloose/nerdcommenter')
    " code folding
    call minpac#add('pseewald/vim-anyfold')
    ":colorscheme iceberg
    call minpac#add('cocopon/iceberg.vim')
    ":colorscheme deus 
    call minpac#add('ajmwagar/vim-deus')
    ":colorscheme minimalist
    call minpac#add('dikiaap/minimalist')

    call minpac#add('EinfachToll/DidYouMean')
 endif

" minpac utility commands 
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

" <leader> as a precursor to user defined commands
let mapleader = ','

set t_ut=

" Basics
set nocompatible 
syntax on 
filetype plugin indent on 
set encoding=utf-8
set number relativenumber 
syntax enable 
set background=dark
colorscheme deus

" Indent levels in code settings
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
set ts=4 sw=4 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" For seeing unused whitespace:
" set list 
" set listchars=space:⋅
" Disable automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Key mappings
inoremap jk <Esc>

" Code Folding Options
"   :h anyfold
"   :h fold-commands
autocmd Filetype * AnyFoldActivate               " Activate for all filetypes
    " set foldlevel=0  " Close all folds
    set foldlevel=99 " Open all folds

" Enclosing autocompletion
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <leader>l <right>

" Replace all words aliased to S, with confirmation
nnoremap S  :%s//gc<Left><Left><Left>
" nnoremap S  :%s/\<\>//g<Left><Left><Left><Left><Left>

" Replace all whole words aliased to 
" C/C++ autocompletion: requires a sudo apt install clang
let g:completor_clang_binary = '/usr/bin/clang-3.8'
" see github for passing additional clang arguments such as include libraries

let NERDSpaceDelims = 1



" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.

" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.  Default suggests completions as you type.
let g:completor_auto_trigger = 0
inoremap <expr> <Tab> Tab_Or_Complete()

" Tab remap to 4 spaces 
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
