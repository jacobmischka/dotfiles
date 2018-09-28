
" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Standard HiLink will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syntax region svelteInside start=/{/ end=/}/ keepend containedin=TOP,@htmlSvelteContainer
syntax match svelteOperators '=\|\.\|\|:/' contained containedin=svelteInside,@htmlSvelteContainer
syntax match svelteHandlebars '{\|}' contained containedin=svelteInside,@htmlSvelteContainer
syntax match svelteConditionals '\([#/]if\|:else\(if\)\?\|@html\)' contained containedin=svelteInside
syntax match svelteHelpers '\([#/]\(each\|await\)\)\|\(:\(then\|catch\)\)' contained containedin=svelteSection
syntax region svelteQString start=/'/ skip=/\\'/ end=/'/ contained containedin=svelteInside
syntax region svelteDQString start=/"/ skip=/\\"/ end=/"/ contained containedin=svelteInside

syntax match htmlTagName contained "\<[A-Z][.0-9_a-z]*\>"

" Clustering
syntax cluster htmlSvelteContainer add=htmlHead,htmlTitle,htmlString,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,htmlLink,htmlBold,htmlUnderline,htmlItalic,htmlValue


" Hilighting
" svelteInside hilighted as Number, which is rarely used in html
" you might like change it to Function or Identifier
HtmlHiLink svelteVariable Number
HtmlHiLink svelteVariableUnescape Number
HtmlHiLink sveltePartial Number
HtmlHiLink svelteSection Number
HtmlHiLink svelteMarkerSet Number

HtmlHiLink svelteHandlebars Special
HtmlHiLink svelteOperators Operator
HtmlHiLink svelteConditionals Conditional
HtmlHiLink svelteHelpers Repeat
HtmlHiLink svelteQString String
HtmlHiLink svelteDQString String

syn region svelteScriptTemplate start=+<script [^>]*type *=[^>]*\(text\)\?/\(svelte\)[^>]*>+
\                       end=+</script>+me=s-1 keepend
\                       contains=svelteInside,@htmlSvelteContainer,htmlTag,htmlEndTag,htmlTagName,htmlSpecialChar

let b:current_syntax = "svelte"
delcommand HtmlHiLink
