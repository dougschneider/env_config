" include any files installed using pathogen
call pathogen#infect()

colorscheme molokai
" make ctrlp never change working directory
let g:ctrlp_working_path_mode = 0

" open nerdtree automatically on startup (but only if running gvim)
"autocmd vimenter * NERDTree
" switch to the window to the right of the nerdtree on startup
"autocmd VimEnter * wincmd l

" make the current line be highlighted; but only highlight the line in the
" current window.
autocmd VimEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

set tabstop=4
set softtabstop=4 " make it so that backspaces get rid of spaces as if they were tabs

set expandtab

" highlight lines over 120 characters 
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>121v.\+/

" enable syntax coloring if available
if has("syntax")
  syntax on
endif

" Make Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set showmatch       " Show matching brackets.

" Have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

set autoindent      " Automatically indent code
set shiftwidth=4    " Number of spaces for each indent level

set hlsearch        " highlight search terms

" Removes whitespace at the end of a line before saving
autocmd BufWritePre *.{py,rst} :%s/\s\+$//e

" `gf` jumps to the filename under the cursor.  Point at an import statement
" and jump to it!
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" Enable pylint checking (requires pylint.vim plugin in ~/.vim/compiler/
" By default, this opens a 'Quick Fix' window  with pylint violations every time the buffer is written
" autocmd FileType python compiler pylint

" command so that sphinx documentation templates can be added to a function
" by simply using ctrl+s when the cursor is on a function.
python << EOL
import vim
def createSphinxDocs():
    variables = ''.join(vim.current.range)
    indentationLevel = " "*(len(variables) - len(variables.strip()) + 4)
    variables = variables[variables.index('(')+1:variables.index(')')]
    variables = [var.strip() for var in variables.split(',') if var != "self"]
    currentBuffer = vim.current.buffer
    row, col = vim.current.window.cursor
    currentBuffer[row:row] = [indentationLevel + "\"\"\""]
    for var in reversed(variables):
        currentBuffer[row:row] = [indentationLevel + "    :type %s:" % var]
        currentBuffer[row:row] = [indentationLevel + "    :param %s:" % var]
        currentBuffer[row:row] = [""]
    currentBuffer[row:row] = [indentationLevel + "\"\"\" "]
    vim.current.window.cursor = (row+1,9+len(indentationLevel))

EOL

map <C-s> :py createSphinxDocs()<cr>

" when using vim autocomplete it will ignore files listed here
set wildignore+=*.o,*.obj,.git,*.pyc

" make it so that windows can be changed with alt+arrow keys
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <silent> <A-j> :wincmd k<CR>
nmap <silent> <A-k> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>

" make jk act as escape when in insert mode
inoremap jk <Esc>
inoremap <Esc> <Nop>

"autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

set guioptions-=T
set guioptions-=m

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
"function! s:CloseIfOnlyNerdTreeLeft()
" if exists("t:NERDTreeBufName")
"   if bufwinnr(t:NERDTreeBufName) != -1
"     if winnr("$") == 1
"       q
"     endif
"   endif
" endif
"endfunction

" set up search criteria
set ignorecase
set smartcase
set incsearch

" add line numbers
"set number

" set up test case loader (use F3 to load a corresponding test case)
nmap <F3> :LoadUnitTestFile<CR>

" make ctrl+backspace get rid of entire words behind the cursor (camel case
" words are accounted for thanks to the eraseSubWords plugin.
imap <C-BS> <C-H>
" make ctrl+delete get rid of entire words in front of the cursor
imap <C-Del> <C-[>diwi

" make control and up/down arrows move faster
nmap k gk
nmap j gj
imap <C-Up> <C-[>5k
imap <C-Down> <C-[>5j
nmap <C-Up> 5k
nmap <C-Down> 5j
nmap <C-k> 5k
nmap <C-j> 5j

" toggle tag bar

nnoremap <silent> <F5> :TagbarToggle<Enter>

"nmap <Space> :bn<Enter>

vmap <C-/> :s/^/#/g<Enter>

set tags=/local/home/schned2/git/ui/tags

" fold the code
autocmd BufNewFile,BufRead *.ps set foldmethod=indent
autocmd BufNewFile,BufRead *.ps set foldlevel=1
nnoremap <Space> za
