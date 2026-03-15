" =============================================================================
" 1. Plugin Management (Vim-Plug)
" =============================================================================
call plug#begin('~/.vim/plugged')

" UI & Aesthetics
Plug 'ghifarit53/tokyonight-vim'                " Colorscheme
Plug 'vim-airline/vim-airline'                  " Statusline
Plug 'vim-airline/vim-airline-themes'           " Statusline themes
Plug 'ryanoasis/vim-devicons'                   " Filetype icons

" Development Tools
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion 
Plug 'preservim/nerdtree'                       " File explorer 
Plug 'preservim/nerdcommenter'                  " Easy commenting 

" Git Integration
Plug 'tpope/vim-fugitive'                       " Git wrapper 
Plug 'airblade/vim-gitgutter'                   " Git diff signs 

call plug#end() 

" =============================================================================
" 2. General Settings
" =============================================================================
syntax on                                   " Enable syntax highlighting 
filetype plugin indent on                   " Filetype detection & indentation 

set number                                  " Line numbers & relative numbers
set mouse=a                                 " Enable mouse support 
set encoding=utf-8                          " Default encoding 
set termguicolors                           " 24-bit RGB color support 
set signcolumn=yes                          " Always show sign column for CoC 
set hidden                                  " Allow buffer switching without saving 
set nobackup nowritebackup                  " Disable backup files for CoC stability 
set updatetime=300                          " Faster diagnostic response 

" Indentation (4 spaces)
set tabstop=4                               " Tab width 
set shiftwidth=4                            " Indent size 
set expandtab                               " Use spaces instead of tabs 
set smartindent autoindent                  " Automatic indentation logic

" =============================================================================
" 3. Plugin-Specific Configurations
" =============================================================================

" --- TokyoNight Theme ---
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1 
colorscheme tokyonight 
set background=dark

" --- Airline Statusline ---
let g:airline_powerline_fonts = 1 
let g:airline_theme = 'tokyonight' 
let g:airline#extensions#tabline#enabled = 1 
let g:airline#extensions#tabline#formatter = 'unique_tail' 
let g:airline#extensions#whitespace#enabled = 0 

" --- NERDTree ---
" Open NERDTree automatically if no file is specified
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif 
let g:NERDTreeShowIcons=1 

" --- CoC Extensions ---
let g:coc_global_extensions = [
    \ 'coc-python', 
    \ 'coc-clangd',
    \ 'coc-yaml',
    \ 'coc-json', 
    \ 'coc-html', 
    \ 'coc-css', 
    \ 'coc-tsserver', 
    \ ] 

" =============================================================================
" 4. Key Mappings
" =============================================================================
let mapleader="," 

" --- General Utilities ---
nnoremap <leader>n :NERDTreeToggle<CR> 
" Open terminal in the current file's directory
nnoremap <leader>t :cd %:p:h \| belowright terminal<CR> 
tnoremap <C-t> <C-\><C-n> 

" --- Tab & Buffer Navigation ---
for i in range(1, 9)
    execute 'nmap <leader>' . i . ' <Plug>AirlineSelectTab' . i
endfor
nmap <leader>- <Plug>AirlineSelectPrevTab 
nmap <leader>+ <Plug>AirlineSelectNextTab 
nmap <leader>q :bp<CR>:bd #<CR>  " Close current buffer and return to previous 

" --- CoC Completion & Navigation ---
" Tab-based completion
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh() 
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>" 

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction 

" Confirm completion with Enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>" 

" Navigation
nmap <silent> gd <Plug>(coc-definition) 
nmap <silent> gy <Plug>(coc-type-definition) 
nmap <silent> gi <Plug>(coc-implementation) 
nmap <silent> gr <Plug>(coc-references) 
nnoremap <silent> K :call ShowDocumentation()<CR> 

" Refactoring & Formatting
nmap <leader>rn <Plug>(coc-rename) 
nmap <leader>f  <Plug>(coc-format-selected) 
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport') 
