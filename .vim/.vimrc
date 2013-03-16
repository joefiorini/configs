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

set splitright                "open vsplits to the right

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

set mouse=a                   "enable the mouse; I like being able to scroll

set hidden                    "allow hiding buffers with unsaved changes

set scrolloff=3               "add some breathing room at top and bottom of screen

"only show the cursorline/col in gui mode
if has("gui_running")
  set cursorline                "highlight current line
  set cursorcolumn              "highlight current column
end

set wildmenu                  "make tab completion act more like bash
set wildmode=list:longest
set completeopt=menu,longest

set switchbuf=useopen         "don't reopen already opened buffers

set cmdheight=2               "make the command line a little taller to hide "press enter to viem more" text

set shell=/bin/sh             "make sure Vim sources my .zshrc

set ofu=syntaxcomplete#Complete "Turn on omnicomplete

function! ChgExt(ext)
	let l:curfile = expand("%:p")
  let l:newfile = expand("%:r") . a:ext
  echo l:newfile
	let v:errmsg = ""
	silent! exe "saveas!" . " " . l:newfile
  if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
    silent exe "bwipe! " . l:curfile
    if delete(l:curfile)
      echoerr "Could not delete " . l:curfile
    endif
  endif
endfunction

" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

"set pastetoggle=<leader>v     "turn paste mode on and off with <leader>v
imap <leader>v <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>

filetype plugin indent on     "enable automatic filetype detection, filetype-specific plugins/indentation

augroup FTCheck

  au Bufenter *.m                   setfiletype objc
  au Bufenter *.h                   setfiletype objc
  au Bufenter *.pch                 setfiletype objc
  au Bufenter *.clj                 setfiletype clojure
  au Bufenter *.plates              setfiletype html
  au Bufenter *.md                  setfiletype markdown
  au BufNewFile,BufRead *.liquid    setfiletype liquid
  " Thorfile, Rakefile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,Assetfile,config.ru}    set ft=ruby

augroup END

augroup WebDesign
  autocmd FileType css,scss,less,styl   set omnifunc=csscomplete#CompleteCSS
augroup END
augroup RubyOpts

  "autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,ru  set ai sw=2 sts=2 et
  autocmd FileType ruby,eruby               set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby               let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby               let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby               let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby               map <Leader>h :%s/:\(\w\+\) =>/\1:/g<CR>
  autocmd FileType ruby,eruby               imap <C-l> <space>=><space>

  autocmd BufNewFile,BufRead *_spec.rb compiler rspec
  highlight Pmenu ctermbg=238 gui=bold
  iabbrev rdebug    require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger
  iabbrev rpry    require 'pry'; require 'pry-nav'; binding.pry
  autocmd User Rails Rnavcommand factory spec/factories -suffix=_factory.rb -default=model()
  autocmd User Rails Rnavcommand feature features -suffix=.feature -default=cucumber
  autocmd User Rails Rnavcommand acceptance spec/acceptance -suffix=.feature -default=cucumber
  autocmd User Rails Rnavcommand support spec/support features/support -default=env
  autocmd User Rails Rnavcommand js app/assets/javascripts -suffix=.js.coffee -default=application
  autocmd User Rails Rnavcommand jsspec spec/javascripts -suffix=.js.coffee -default=spec
  autocmd User Rails Rnavcommand presenter app/presenters -suffix=_presenter.rb -default=application
  autocmd User Rails Rnavcommand representer app/representers -suffix=_representer.rb -default=application
  autocmd User Rails Rnavcommand concern app/concerns -suffix=.rb -default=application


augroup END

autocmd vimenter * if !argc() | NERDTree | endif

"custom status line (across the bottom of the screen)
" See http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline' for more
" details on statusline
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ \ \ \ \ \ \ \ \ \ \ \ [POS=%2l,%2v][%p%%]\ \ \ \ \ \ \ \ \ \ \ \ [LEN=%L]
set laststatus=2

let g:user_zen_settings = {
\  'indentation' : '  ',
\}

let g:gist_clip_command = 'pbcopy'

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

" Make Y consistent with C and D
nnoremap Y y$

" Make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>

" Make <c-l> print the path to file being edited in ex mode
cmap <c-l> <c-r>=expand("%")<CR>

" <C-c> in insert mode doesn't fire insertleave, which is a problem in <C-v>
"   mode; this makes <C-c> fire insertleave
inoremap <C-c> <ESC>

" Rerun the last command
nnoremap <Leader>. :<Up><CR>

" Make omnicomplete a bit easier
imap <Leader>o <C-x><C-o>

" Buffer navigation
map <Leader><Leader> <C-^>
map <Leader>] :bnext<CR>
map <Leader>[ :bprev<CR>
map <Leader>ls :buffers<CR>

" Finally quit hitting :Q instead of :q
cmap Q<CR> q

cmap <C-T> <C-B>map <Leader>t :<C-E><lt>CR>

" For unimpaired plugin
nmap <C-j> ]e
nmap <C-k> [e
vmap <C-j> ]egv
vmap <C-k> [egv

" For allml plugin
inoremap <M-o> <Esc>o
let g:allml_global_maps = 1

" Quickly open/source .vimrc/.gvimrc
nmap ,vs :source $HOME/.vimrc<cr>
nmap ,vv :tabe $HOME/.vimrc

" Auto surround using mapped surroundings in visual mode
vmap ) s)
vmap ] s]
vmap ' s'
vmap } s}

" from Gary Bernhardt: don't close splits when deleting buffers
cnoremap <expr> bd (getcmdtype() == ':' ? 'Bclose' : 'bd')

" Quickly delete trailing spaces and tab characters
fun! ClearAllTrailingSpaces()
  %s/\s\+$//
  %s/\t/  /g
endfun

" and map it to <Leader>c
nmap <Leader>c :call ClearAllTrailingSpaces()<CR>

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
map <leader>k :!mkdir -p %%

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

" Add Handlebars support to Vim Commentary
autocmd Syntax handlebars set commentstring={{!\ %s\ }}
