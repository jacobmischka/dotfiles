if exists('g:GtkGuiLoaded')
" neovim-gtk config

	" Disable default external features
	call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
	call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)

	" Increase font size
	call rpcnotify(1, 'Gui', 'Font', 'Fira Code Regular 12')
endif

function! GuiFontSize(new_size)
  call rpcnotify(1, 'Gui', 'Font', 'Fira Code Regular ' . a:new_size)
endfunction

command! -nargs=1 GuiFontSize call GuiFontSize(<f-args>)

