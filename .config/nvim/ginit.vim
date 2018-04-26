if exists('g:GtkGuiLoaded')
" neovim-gtk config

	" Disable GUI tabline (It's neat but only uses windows not tabs)
	call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif

