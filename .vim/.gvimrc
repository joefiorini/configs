set guioptions-=T

set guifont=mensch:h14

colorscheme moria          "pretty!

if has("gui_running")
  "set fuoptions=maxvert,maxhorz
  "au GUIEnter * set fullscreen
  set columns=180
endif

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> <Plug>PeepOpen
  macmenu &Tools.Make key=<nop>
end
