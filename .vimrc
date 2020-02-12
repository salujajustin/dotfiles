"        __________   ____________
"       |  ________| |____    ____|
"       |  |  __________  |  |
"       |  | |   _______| |  |  File:        .vimrc
"       |  | |  |_______  |  |  Desc:         Personal Vim 8 configuration
"       |  | |_______   | |  |
"       |  |  _______|  | |  |  Maintainer:  <Justin Saluja>
"       |  | |__________| |  |  Email:       <salujajustin@gmail.com>
"   ____|  |____   _______|  |  Github:      <salujajustin>
"  |____________| |__________|

"                               Prerequisites   
"
"  Install the minpac package manager:
"  '''sh
"  mkdir -p ~/.vim/pack/minpac/opt
"  mkdir -p ~/.vim/tmp
"  git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
"  '''
set packpath^=~/.vim
packadd minpac

if exists('*minpac#init')
    call minpac#init({'verbose': 3})  " minpac is loaded
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    " Basic plugins 
    call minpac#add('machakann/vim-sandwich')  " delete, change, add surroundings: ()[]{}<>...
    call minpac#add('scrooloose/nerdcommenter')  " commenting code
    call minpac#add('EinfachToll/DidYouMean')  " stupidity checker
    " Colorschemes  
    call minpac#add('ajmwagar/vim-deus')  " :colorscheme deus
    call minpac#add('cocopon/iceberg.vim')  " :colorscheme iceberg
    call minpac#add('dikiaap/minimalist')  " :colorscheme minimalist
    " LaTeX document support
    call minpac#add('lervag/vimtex')  " syntax, compilation, parsing etc.   
    call minpac#add('sirver/ultisnips')  " snippet manager
    call minpac#add('KeitaNakamura/tex-conceal.vim')  " latex text concealer
    call minpac#add('907th/vim-auto-save')  " automatically save changes to disk  
    " Code support 
    call minpac#add('jiangmiao/auto-pairs')  " insert or delete brackets, parens, quotes in pair 
    " call minpac#add('neoclide/coc.nvim', {'branch': 'release'})  " intellisense engine  
 endif

" minpac utility commands : call when adding/removing plugins 
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

" Coc extentions
" :CocInstall coc-vimtex
" :CocInstall coc-snippets

" store system kernel in a variable
let OS=substitute(system('uname -s'), "\n","","")

" <leader> & <localleader> as a precursor to user defined commands
let mapleader = ','
let maplocalleader = " "

" Basics
set nocompatible 
set encoding=utf-8
set number relativenumber 
set background=dark
syntax enable 
syntax on 
colorscheme deus

" Tab remap to 4 spaces 
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Backup dir
set backupdir=~/.vim/tmp//,.  " backup files
set directory=~/.vim/tmp//,.  " swap files

" For seeing unused whitespace and end-of-line
set listchars=space:⋅,eol:¬
nnoremap <leader>. :set list!<CR>

" Disable automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" File extension syntax highlighting
autocmd BufNewFile,BufRead *.rasi set syntax=css

" LaTeX Settings "
"   ultisnips settings
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/snippets']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"   vimtex settings 
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_view_forward_search_on_start=0
if (OS == "Darwin")
    let g:vimtex_view_method='skim'
else 
    let g:vimtex_view_method='zathura'
endif
"   tex-conceal settings
set conceallevel=1
let g:tex_conceal='abdmg'
"   spell checking 
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"   auto-save options 
let g:auto_save_silent = 1  " do not display auto-save notification
nnoremap <localleader>w :AutoSaveToggle<CR>

" Coc options:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" NerdCommenter options
let NERDSpaceDelims = 1

" Indent levels in code settings
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
set ts=4 sw=4 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Insert Mode key mappings
" -> exit insert mode
inoremap jk <Esc>   
" -> jump out of {}[]() etc.
inoremap <leader>l <ESC>la

" Normal Mode key mappings
"   replace all words aliased to S, with confirmation
nnoremap S  :%s//gc<Left><Left><Left>  

" Cut & Copy visual lines to system clipboard
" echo has('clipboard') ==> if 0 install vim-gtk3
if (OS == "Darwin")
    vmap '' :w !pbcopy<CR><CR>
else 
    set clipboard=unnamedplus  " ctrl-c & ctrl-v clipboard
    cnoremap <C-v> <C-r>+/  
endif

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
let &t_ut=''
