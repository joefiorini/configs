" setup Pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set nocompatible              "don't need to keep compatibility with Vi

"Set colorscheme with options
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized         "use a colorscheme that's cli friendly
set background=dark           "make vim use colors that look good on a dark background

syntax on                     "turn on syntax highlighting

set showcmd                   "show incomplete cmds down the bottom
set showmode                  "show current mode down the bottom

set incsearch                 "find the next match as we type the search
set hlsearch                  "hilight searches by default
set ignorecase                "case insesitive searches
set smartcase                 "case sensitive search if term contains uppercase characters
set smartindent               "auto indent when adding a curly brace, etc.


set nowrap                    "dont wrap lines
set linebreak                 "wrap lines at convenient points

set shiftwidth=2              "number of spaces to use in each autoindent step
set tabstop=2                 "two tab spaces
set softtabstop=2             "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                 "spaces instead of tabs for better cross-editor compatibility
set cindent                   "recommended seting for automatic C-style indentation
set autoindent                "automatic indentation in non-C files
set wrap                      "wrap entire words, don't break them; much easier to read!

set hidden                    "allow hiding buffers with unsaved changes

set scrolloff=3               "add some breathing room at top and bottom of screen

"only show the cursorline/col in gui mode
if has("gui_running")
  set cursorline                "highlight current line
  set cursorcolumn              "highlight current column
end

set wildmenu                  "make tab completion act more like bash
set wildmode=list:longest

set mouse-=a                  "disable mouse automatically entering visual mode

let mapleader = ","           "remap leader to ',' which is much easier than '\'

set switchbuf=useopen         "don't reopen already opened buffers

set cmdheight=2               "make the command line a little taller to hide "press enter to viem more" text

set shell=/bin/sh             "make sure Vim sources my .zshrc

set ofu=syntaxcomplete#Complete "Turn on omnicomplete

" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

"set pastetoggle=<leader>v     "turn paste mode on and off with <leader>v
imap <leader>v <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>

filetype plugin indent on     "enable automatic filetype detection, filetype-specific plugins/indentation

augroup FTCheck

  au Bufenter *.m setfiletype objc
  au Bufenter *.h setfiletype objc
  au Bufenter *.pch setfiletype objc
  au Bufenter *.clj setfiletype clojure
  au BufNewFile,BufRead *.liquid   setf liquid
  " Thorfile, Rakefile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

augroup END

augroup RubyOpts

  "autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,ru  set ai sw=2 sts=2 et
  autocmd FileType ruby,eruby               set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby               let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby               let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby               let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby               map <Leader>h :%s/:\(\w\+\) =>/\1:/g<CR>
  autocmd BufNewFile,BufRead *_spec.rb compiler rspec
  highlight Pmenu ctermbg=238 gui=bold

augroup END



"au BufRead,BufNewFile *.screenplay set filetype=screenplay

"custom status line (across the bottom of the screen)
" See http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline' for more
" details on statusline
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ \ \ \ \ \ \ \ \ \ \ \ [POS=%2l,%2v][%p%%]\ \ \ \ \ \ \ \ \ \ \ \ [LEN=%L]
set laststatus=2


set grepprg=ack
function! Ack(args)
    let grepprg_bak=&grepprg
    set grepprg=ack\ -H\ --nocolor\ --nogroup
    execute "silent! grep " . a:args
    botright copen
    let &grepprg=grepprg_bak
endfunction

command! -nargs=* -complete=file Ack call Ack(<q-args>)


"set the kind of invisible characters to show
" for tabs, trailing spaces, non breaking spaces
set lcs=tab:→.,trail:•,nbsp:%

"show invisible characters. Use "set nolist" to turn off.
set list

"speed up fuzzy_finder_textmate plugin, like, a lot!
let g:fuzzy_matching_limit=60

"don't clutter my directories with swap files, bitch!
set nobackup
set nowritebackup
set noswapfile


"----------------------
"   Key Mappings      |
"----------------------

" change from <Leader>t to <Leader>]
map <Leader>m <Plug>MakeGreen

" Make Y consistent with C and D
nnoremap Y y$

" Reparse CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Make <c-l> print the path to file being edited in ex mode
cmap <c-l> <c-r>=expand("%")<CR>

" Map Q to something useful
noremap Q gq

" <C-c> in insert mode doesn't fire insertleave, which is a problem in <C-v>
"   mode; this makes <C-c> fire insertleave
inoremap <C-c> <ESC>

" Rerun the last command
nnoremap <Leader>. :<Up><CR>

nnoremap <Leader>ga :!git add %<CR>

" Make tabs work like we're used to
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>

" Search with ctrl+f
map <C-F> :grep "" <LEFT><LEFT>

" Make omnicomplete a bit easier
imap <Leader>o <C-x><C-o>

" For Passenger-hosted apps
nmap ss :!touch tmp/restart.txt<CR>

" Show NERD_Tree with line numbers for easier navigation
map <Leader>d :Bclose<CR>

" Shortcuts to some commonly used apps
map <Leader>r :!rvm-auto-ruby -rubygems %<CR>
map <Leader>rs :!rspactor<CR>
map <Leader>gx :!gitx<CR>

" Buffer navigation
map <Leader>, <C-^>
map <Leader>] :bnext<CR>
map <Leader>[ :bprev<CR>
map <Leader>ls :buffers<CR>

" Finally quit hitting :Q instead of :q
cmap Q<CR> q

" Make windows a little easier to resize
nnoremap <Leader>= <C-W>+
nnoremap <Leader>- <C-W>-
nnoremap <Leader>_ <C-W>_
nnoremap ++ <C-W>>
nnoremap -- <C-W><

" For unimpaired plugin
nmap <C-j> ]e
nmap <C-k> [e
vmap <C-j> ]egv
vmap <C-k> [egv

" For allml plugin
inoremap <M-o> <Esc>o
let g:allml_global_maps = 1

" Hashrocket shortcut compliments of TextMate
imap <C-l> <space>=><space>

" Insert []
imap <C-]> <C-s>]

" Quickly open/source .vimrc/.gvimrc
nmap ,vs :source $HOME/.vimrc<cr>
nmap ,vv :tabe $HOME/.vimrc

" Auto surround using mapped surroundings in visual mode
vmap ) s)
vmap ] s]
vmap ' s'
vmap } s}

" visual shifting (without leaving visual mode)
vnoremap < <gv
vnoremap > >gv

" from Gary Bernhardt: don't close splits when deleting buffers
cnoremap <expr> bd (getcmdtype() == ':' ? 'Bclose' : 'bd')

" Quickly delete trailing spaces and tab characters
fun! ClearAllTrailingSpaces()
  %s/\s\+$//
  %s/\t/  /g
endfun

" and map it to <Leader>c
nmap <Leader>c :call ClearAllTrailingSpaces()<CR>

" Convert one line blocks in braces { } to multiline do ... end
fun! BlockBracesToDoEnd()
  s/{\(.*\)}/do\r\1\rend/
endfun

" and map it to <Leader>b for block
nmap <Leader>b :call BlockBracesToDoEnd()<CR>

function! ToggleScratch()
  if expand('%') == g:ScratchBufferName
    quit
  else
    Sscratch
  endif
endfunction

map <Leader>s :call ToggleScratch()<CR>

function! ScrubQuotes()
  %s/“/"/g
  %s/”/"/g
  %s/‘/'/g
  %s/’/'/g
endfunction

nmap <LEADER>g :call ScrubQuotes()<CR>

" Make ',e' (in normal mode) give a prompt for opening files
" in the same dir as the current buffer's file.
cnoremap %% <C-R>=expand("%:h")<cr>/
map <leader>e :e %%
map <leader>a :tabe %%
map <leader>n :Rename %%
map <leader>k :!mkdir %%

" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

" Customizations to make tabular plugin easier to use from https://gist.github.com/287147
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

