" Inserts character at end of current line, replacing cursor position after
function! Ender()
	let endchar = nr2char(getchar())
	execute "normal \<End>a".endchar
	normal `e
endfunction

