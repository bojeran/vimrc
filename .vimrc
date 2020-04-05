" Some notes to help understanding this .vimrc
" - `:echo has("python3")` -> seems to check what `:version` shows.
" required for YouCompleteMe
set nocompatible
set encoding=utf-8
filetype off

" set the runtime path to include Vundle and initialize
" $HOME should be cross compatible
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin('$HOME/.vim/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

if has("win32")
    " this is needed for unity open %1:%2
    Plugin 'bogado/file-line'
    Plugin 'ycm-core/YouCompleteMe'
    Plugin 'OmniSharp/omnisharp-vim'
endif

call vundle#end()            " required
filetype plugin indent on    " required

" set leader key
let mapleader = ","
" in case i want the backspace to also delete newline and so on
set backspace=indent,eol,start
" show useful column width
set colorcolumn=80

if has("win32")
    let g:OmniSharp_server_path = $HOME . '\omnisharp-roslyn\OmniSharp.exe'
    let g:OmniSharp_server_stdio = 1
    " Timeout in seconds to wait for a response from the server
    let g:OmniSharp_timeout = 5
    " Don't autoselect first omnicomplete option, show options even if there is
    " only
    " one (so the preview documentation is accessible). Remove 'preview' if you
    " don't want to see any documentation whatsoever.
    set completeopt=longest,menuone,preview
    set previewheight=5
    let g:OmniSharp_highlight_types = 3


    augroup omnisharp_commands
        autocmd!
    
        " Show type information automatically when the cursor stops moving.
        " Note that the type is echoed to the Vim command line, and will overwrite
        " any other messages in this space including e.g. ALE linting messages.
        autocmd CursorHold *.cs OmniSharpTypeLookup
    
        " The following commands are contextual, based on the cursor position.
        autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
    
        " Finds members in the current buffer
        autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
    
        autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
        autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
        autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>
    
        " Navigate up and down by method/property/field
        autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
        autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
    
        " Find all code errors/warnings for the current solution and populate the quickfix window
        autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
    augroup END
    
    " Contextual code actions (uses fzf, CtrlP or unite.vim when available)
    nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
    " Run code actions with text selected in visual mode to extract method
    xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>
    
    " Rename with dialog
    nnoremap <Leader>nm :OmniSharpRename<CR>
    nnoremap <F2> :OmniSharpRename<CR>
    " Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
    command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
    
    nnoremap <Leader>cf :OmniSharpCodeFormat<CR>
    
    " Start the omnisharp server for the current solution
    nnoremap <Leader>ss :OmniSharpStartServer<CR>
    nnoremap <Leader>sp :OmniSharpStopServer<CR>

    " General behvior
    "set background=dark        " Use a dark background
    ":silent! colorscheme solarized      " A theme with a dark background
    syntax on                  " Enable syntax highlighting
    colorscheme desert
    "set lines=30 columns=120   " Initial window size
endif


if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h14:cANSI
        " run the command immediately when starting vim
        autocmd VimEnter * call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)
        " activate/deactivate full screen with function key <F11>  
        map <F11> <Esc>:call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>
        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar
        set guioptions-=r  "remove right-hand scroll bar
        set guioptions-=L  "remove left-hand scroll bar
    endif
endif

noremap <space> :
inoremap jj <ESC>

map ,cd :cd %:p:h <CR>
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,m :make<CR>
" Move between windows more comfortable (also in terminal mode)
map ,j <c-w>j<c-w><CR>
tmap ,j <c-w>j<c-w><CR>
map ,k <c-w>k<c-w><CR>
tmap ,k <c-w>k<c-w><CR>
map ,h <c-w>h<c-w><CR>
tmap ,h <c-w>h<c-w><CR>
map ,l <c-w>l<c-w><CR>
tmap ,l <c-w>l<c-w><CR>
" Most easiest switching between two windows
map ,w <c-w>w<c-w><CR>
tmap ,w <c-w>w<c-w><CR>


" didn't use + before therefore i use it to quickly paste
map + "+p
map ü "+p
" lmap -> Insert, Command-Line, Lang-Args
" cmap -> Command-Line
cmap ü <c-r>+
tmap ü <c-w>"+
" switch easier to normal mode
tmap ö <c-w>N


" Some basic changes
" set tab size to 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab


