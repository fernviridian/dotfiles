execute pathogen#infect()

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

set softtabstop=2
set shiftwidth=2
set expandtab
set nu
set autoindent

" " Show trailing whitepace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+\%#\@<!$/ containedin=AL

syntax on
colorscheme summerfruit256
set t_Co=256
