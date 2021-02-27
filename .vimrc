""" enter the current millenium
set nocompatible

""" work around CVE-2019-12735
set nomodeline

""" encoding
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
scriptencoding utf-8

""" appearance
set termguicolors
set background=dark
colorscheme onedark 
set laststatus=2
set ruler
set scrolloff=1 sidescrolloff=5
set number relativenumber
set splitbelow splitright

""" misc
set undofile
set ttyfast
set timeout timeoutlen=1000 ttimeoutlen=50
set dir=~/.cache/vim
set undodir=~/.cache/vim_undo
set autoread
set noerrorbells
set updatetime=300
set mouse=n
set autochdir


""" status-line
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{StatuslineTrailingSpaceWarning()}%=%-5(\ l:\%l,\ \c:%c\ %)

"recalculate the trailing whitespace warning when idle, and after saving
augroup cal_white_space
    autocmd!
    autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
augroup end

"return '[ts]' or ''
function! StatuslineTrailingSpaceWarning()
    if !exists('b:statusline_trailing_space_warning')
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[ts]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

let t:is_transparent = 1
function! Toggle_transparent_background()
  if t:is_transparent == 0
    hi Normal guibg=#111111 ctermbg=black
    let t:is_transparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 0
  endif
endfunction

" set basic fzf settings
set rtp+=~/.fzf

" search in git-dir if present
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2], 'options': '--delimiter : --nth 4..'}, <bang>0)

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()


""" fzf mappings
nnoremap <silent> <C-p> :ProjectFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-g> :GFiles?<CR>
nnoremap <silent> <leader>f :PRg<CR>
nnoremap <silent> <leader>F :Filetypes<CR>
nnoremap <silent> \ :BLines<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>
let g:fzf_layout = { 'down': '~40%' }

""" fzf.vim
" set basic fzf settings
set rtp+=~/.fzf
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_layout = { 'down': '~40%' }

""" change default grep to rg
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
let g:rg_derive_root='true'


""" search settings
set hlsearch
set history=10000
set incsearch
set ignorecase
set smartcase

""" file-search setting
set wildmenu
set wildmode=longest:full,full
set wildchar=<TAB>

""" file-format settings
set fileformats=unix
set smartindent
set ts=4 sts=-1 sw=4 ai et
syntax enable
filetype plugin indent on
augroup file_type_options
    autocmd!
    autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    autocmd BufNewFile,BufRead *.md,*.markdown set filetype=ghmarkdown
    autocmd BufNewFile,BufRead *.md,*.markdown setlocal formatoptions+=c formatoptions+=r formatoptions+=o
augroup END

""" wrap settings
set linebreak
set nowrap

""" removing trailing whitespaces
command! Removespaces :%s/\s\+$//e

""" mappings
" remap leader-key
let mapleader = ','

" stop highlighting matches
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
" fzf mappings
nnoremap <silent> <C-p> :w<CR>:ProjectFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-g> :GFiles?<CR>
nnoremap <silent> <leader>f :w<CR>:PRg<CR>
nnoremap <silent> <leader>F :Filetypes<CR>
nnoremap <silent> \ :BLines<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" write & quit mapping
noremap <silent> <leader>w :w<CR>
noremap <silent> <leader>q :q<CR>
noremap <silent> <leader>Q :q!<CR>
noremap <silent> <leader>wq :wq<CR>

" quick split
noremap <silent> <leader>v :vsp<CR>
noremap <silent> <leader>h :sp<CR>

" closing a buffer
noremap <silent> <leader>d :bd<CR>

" easy movement around wrapped lines
noremap j gj
noremap k gk
noremap 0 g0
noremap $ g$
noremap <Up> g<Up>
noremap <Down> g<Down>

" next-previous tab
noremap <silent> <leader>n :tabn<CR>
noremap <silent> <leader>p :tabp<CR>

" save and run scripts
augroup run_py
    autocmd!
    autocmd filetype python nmap <F5> :w<CR>:!clear;python %<CR>
augroup END

" copy to primary clipboard
vnoremap <C-y> "+y

" opening & sourcing vimrc
nnoremap <silent> <leader>ev :tabe $MYVIMRC<CR>
augroup source_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC :source %
augroup END
" opening zshrc
nnoremap <silent> <leader>ez :tabe ~/.zshrc<CR>
" save as sudo
cnoremap !! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
""" even strager doesn't know why
set exrc secure

