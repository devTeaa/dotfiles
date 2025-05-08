" Start visual line selection from the current line to the end (excluding newline)
nnoremap V v$h

" Scroll down half a page and center the cursor line
nnoremap <C-d> <C-d>zz

" Scroll up half a page and center the cursor line
nnoremap <C-u> <C-u>zz

" Move to the next search result, center it, and open any folds
nnoremap n nzzzv

" Move to the previous search result, center it, and open any folds
nnoremap N Nzzzv

" Mark current position and go to definition
nnoremap gd mzgd

" Go back to marked position
nnoremap gb `z

