" ----------------------------------------------------------------------------
" WARNING: THIS PLUGIN IS DEPRECATED
"
" This plugin is deprecated in favour of vim-searchlist, which supports both Vim
" and Neovim.
"
"     https://github.com/joechrisellis/vim-searchlist
"
" ----------------------------------------------------------------------------
"
" nvim-searchlist - adds a searchlist to Neovim.
"
" Maintainer:   UNMAINTAINED
" Version:      0.1.0
" License:      Same terms as Vim itself (see |license|)
" Location:     plugin/searchlist.vim
" Website:      https://github.com/joechrisellis/nvim-searchlist
"
" Use this command to get help on nvim-searchlist:
"
"     :help searchlist

if exists("g:loaded_searchlist")
    finish
endif
let g:loaded_searchlist = 1

" Hook AddEntry in to the common search commands.
function! s:CreateSearchMaps() abort
    for l:searchcmd in ["/", "?", "*", "#", "g*", "g#"]
        exe "nnoremap " . l:searchcmd . " :<C-u>call searchlist#AddEntry()<cr>" . l:searchcmd
    endfor
    " gd and gD don't write to the command-line when they are used, so we have
    " to include <silent> in their mappings (otherwise, we'll end up seeing
    " :call searchlist#AddEntry() in the command-line)
    for l:searchcmd in ["gd", "gD"]
        exe "nnoremap <silent> " . l:searchcmd . " :<C-u>call searchlist#AddEntry()<cr>" . l:searchcmd
    endfor
endfunction

" Create maps for jumping back and forth in the searchlist.
function! s:CreateJumpMaps() abort
    nnoremap <silent> g\ :<C-u>call searchlist#JumpBackwards()<cr>
    nnoremap <silent> g/ :<C-u>call searchlist#JumpForwards()<cr>
endfunction

function! s:CreateAllMaps() abort
    call s:CreateSearchMaps()
    call s:CreateJumpMaps()
endfunction

" Users can change this if they want to set their own maps or if they already
" have maps for the common search commands and want to tie them in with
" nvim-searchlist.
let g:searchlist_maps = "all"

if g:searchlist_maps ==? "all"
    call s:CreateAllMaps()
elseif g:searchlist_maps ==? "search_only"
    call s:CreateSearchMaps()
elseif g:searchlist_maps ==? "jump_only"
    call s:CreateJumpMaps()
endif
