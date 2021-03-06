set hlsearch
set ignorecase
set smartcase

" disable startup message
set shortmess+=I

" split by default to the right and below
set splitbelow
set splitright

" setup swap files dir per user
silent :!mkdir -p $HOME/.swap-$USER-vim
set dir=$HOME/.swap-$USER-vim

" starts with mouse in vim mode
set mouse=a

set scrolloff=2
set pastetoggle=<F10>
set modeline
set shiftwidth=4 tabstop=4 expandtab

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

set nofoldenable
set showcmd

set clipboard=unnamed

" Show invisible characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list

" Keep undo history across sessions, by storing it in a file.
set undolevels=1000
if has('persistent_undo')
    silent !mkdir -p ~/.local/share/vim/undo > /dev/null 2>&1
    set undodir=~/.local/share/vim/undo
    set undofile
endif

" uses Ctrl-Space for emmet expanding
if has("gui_running")
    let g:user_emmet_expandabbr_key = '<C-space>'
else
    let g:user_emmet_expandabbr_key = '<Nul>'
end

let g:airline_powerline_fonts = 1
" disabled for causing weird chars in output
let g:airline#extensions#tagbar#enabled = 0

" CtrlP config:
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_use_caching = 0

" Use ag in CtrlP for listing files.
" Lightning fast and respects .gitignore (caveat: ignores ctrlp_custom_ignore)
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" keep syntastic minimally annoying
let g:syntastic_enable_signs=0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "active_filetypes": ["ruby", "php", "python", "javascript"],
            \ "passive_filetypes": ["puppet", "java"] }
" let g:syntastic_debug=1

let g:flake8_max_line_length=100

" don't fold docstrings:
let g:SimpylFold_fold_docstring = 0

" make Python plugin Jedi more awesome
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_assignments_command = 'gd'
let g:jedi#goto_command = 'gD'
let g:jedi#popup_on_dot = 0
let g:jedi#rename_command = ""
let g:jedi#smart_auto_mappings = 0


let g:ropevim_guess_project=1
let g:ropevim_enable_autoimport=1
let g:ropevim_local_prefix='<leader>r'
let g:ropevim_global_prefix='<leader>e'
let g:ropevim_goto_def_newwin="tabnew"
let g:ropevim_open_files_in_tabs=1

let g:tagbar_ctags_bin='~/bin/ctags'

" ALE (linter)
" Only use flake8 for Python, because pylint is huge and impossible to appease
let g:ale_linters = {
\ 'python': ['flake8'],
\ 'javascript': ['prettier'],
\}
" Stupid Unicode tricks
let g:ale_sign_info = "🚩"
let g:ale_sign_warning = "🚨"
let g:ale_sign_error = "💥"
let g:ale_sign_style_warning = "💈"  " get it?  /style/ issues?  wow tough crowd
let g:ale_sign_style_error = "🚨"

" Airline; use powerline-style glyphs and colors
let g:airline_powerline_fonts = 1
" ALE
let g:airline#extensions#ale#error_symbol = "🚨"

"Prettier (JS linter):
let g:prettier#config#semi = 'false'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#print_width = 100

" save and load bookmarks automatically
let g:bookmark_manage_per_buffer = 1

if has("gui_running")
    set guifont=Monospace\ 14
    set guioptions=aegiclA
    set lines=40 columns=140
    colorscheme molokai
endif

" use 256 colors, if supported
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
	set t_Co=256
endif

augroup go_to_last_known_line_when_open_file
    au BufReadPost * 
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
augroup END

augroup highlight_annoying_whitespace_at_eol
    au BufNewFile,BufRead * syntax match annoyingwhitespace '\s\+$' |
                \ highlight annoyingwhitespace ctermbg=red
augroup END

augroup grails_config
    au BufNewFile,BufRead *.gsp setlocal ft=jsp
augroup END

augroup erlang_config
    au BufNewFile,BufRead rebar.config setlocal ft=erlang
    au BufNewFile,BufRead *.app.src setlocal ft=erlang
augroup END

augroup yaml_config
    au FileType yaml setlocal shiftwidth=2 tabstop=2
augroup END

" CSS:
augroup stylesheets_autocomplete_hyphen
    autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

augroup bash_config
    autocmd FileType sh map <leader>r :exec '!clear;'.getline('.')<cr>
augroup END

augroup strace_dump_config
    autocmd BufRead,BufNewFile *.strace setlocal filetype=strace
augroup END

augroup python_config
    " highlight self and tabs
    au FileType python syn match keyword '\<self\>'
    au FileType python syn match pyTAB '^\t\+' | hi pyTAB ctermbg=darkblue

    " setup isort and autopep8 for python formatting
    au FileType python setlocal formatprg=isort\ -\ \|\ autopep8
                \\ --aggressive
                \\ --aggressive
                \\ --pep8-passes\ 50
                \\ --max-line-length\ 100
                \\ -

    au FileType python nnoremap <F9> :Black<CR>
    au FileType python inoremap <F9> <ESC>:Black<CR>a
augroup END


augroup terraform_config
    " au FileType terraform setlocal formatprg=terraform\ fmt\ -
    let g:terraform_fmt_on_save=1
augroup END

augroup elm_config
    au FileType elm set shiftwidth=2 tabstop=2
    au FileType elm setlocal formatprg=elm-format\ --stdin
augroup END

augroup javascript_config
    au FileType javascript set shiftwidth=2 tabstop=2
    au FileType javascriptreact set shiftwidth=2 tabstop=2
    au FileType javascript nnoremap <F9> :Prettier<CR>
    au FileType javascriptreact nnoremap <F9> :Prettier<CR>
    au FileType javascript inoremap <F9> <ESC>:Prettier<CR>a
    au FileType javascriptreact inoremap <F9> <ESC>:Prettier<CR>a
augroup END

augroup gen_tags_for_personal_help
    autocmd BufWritePost ~/.vim/doc/*.txt :helptags ~/.vim/doc
augroup END

augroup lisp_config
    au FileType lisp set lisp
augroup END

augroup ruby_config
    au FileType ruby setlocal shiftwidth=2
augroup END

augroup yjsx_config
    autocmd BufRead,BufNewFile *.yjsx setlocal filetype=xml
augroup END

" enable Emoji substitutions for HTML, Markdown and others
au FileType html,markdown,mmd,text,mail,gitcommit
    \ runtime macros/emoji-ab.vim
