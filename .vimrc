" Global Settings
set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
set laststatus=2 " Show status line always
set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P
set nobackup
set nowritebackup
set nu  " Line numbers on
set wrap  " Line wrapping off
set confirm " Ask me whether I want to save a modified file
set ic " Ignore case when searching
set noerrorbells " Disable error beep
set visualbell t_vb= " Disable error beep for gvim
set nofoldenable " Disable folding when opening a file

" Complex global settings/tweaking

" QuickFix window toggle, from http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
	if exists("g:qfix_win") && a:forced == 0
		cclose
		unlet g:qfix_win
	else
		copen 10
		let g:qfix_win = bufnr("$")
	endif
endfunction
nmap <silent> <Leader>` :QFix <CR>
											

" Formatting (some of these are for coding in C and C++)
set ts=2 " Tabs are 2 spaces
set bs=2 " Backspace over everything in insert mode
set shiftwidth=2 " Tabs under smart indent
set smartindent
set smarttab
set expandtab
" set noexpandtab
filetype indent on  " On Mac, this seems to be off by default
filetype plugin on    " Enable filetype-specific plugins
" compiler ruby         " Enable compiler support for ruby


" File Types
au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript
au BufNewFile,BufRead *.as set noexpandtab
au BufNewFile,BufRead *.hx set noexpandtab
" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" Util Shortcuts
"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>
" CTRL-R reloads the ~/.vimrc file
" nnoremap <c-r> :source ~/.vimrc
" inoremap <c-r> <c-o>:source ~/.vimrc
" vnoremap <c-r> <c-c>:source ~/.vimrc
map <F2> <Esc>:1,$!xmllint --format -<CR>

" Abbr
function! Tlist_Get_Function_Name()
	let i = 0
	let tokens = split(Tlist_Get_Tag_Prototype_By_Line(), '\(\) ')
	while i < len(tokens)
		if tokens[i] == 'function'
			return tokens[i+1]
		endif 
	endwhile
endfunction
" ab tr trace("=Tlist_Get_Tag_Prototype_By_Line().=Tlist_Get_Tagname_By_Line()()");*/

" Plugin Shortcuts and config

" Fuf
let g:fuf_maxMenuWidth = 180
let g:fuf_dir_exclude = '\/$|\v\~$|\.o$|\.exe$|\.bak$|\.swp$|\.swf$|/Debug/|/Bin/|/ClientBin/|/App_Data/'
let g:fuf_abbrevMap = {
	\   "^as2s" : [
	\     "~/svn/integration/trunk/as2/src/**/"
	\   ],
	\   "^as3s" : [
	\     "~/svn/integration/trunk/as3/src/**/"
	\   ],
	\   "^hxs" : [
	\     "~/svn/integration/trunk/hx/src/**/"
	\   ],
	\   "^as2r" : [
	\     "~/svn/integration/trunk/as2/src/renderers/**/"
	\   ],
	\   "^as3r" : [
	\     "~/svn/integration/trunk/as3/src/renderers/**/"
	\   ],
	\   "^as2i" : [
	\     "~/svn/integration/trunk/as2/src/interface/**/"
	\   ],
	\   "^as3i" : [
	\     "~/svn/integration/trunk/as3/src/interface/**/"
	\   ],
	\   "^as2b" : [
	\     "~/svn/integration/trunk/as2/build/"
	\   ],
	\   "^as3b" : [
	\     "~/svn/integration/trunk/as3/build/"
	\   ],
	\   "^ren3" : [
	\     "~/svn/renderers/trunk/as3/**/"
	\   ],
	\   "^ren2" : [
	\     "~/svn/renderers/trunk/as2/**/"
	\   ],
	\   "^r23" : [
	\     "~/svn/r2/trunk/as3/**/"
	\   ],
	\   "^r22" : [
	\     "~/svn/r2/trunk/as2/**/"
	\		],
	\   "^sl3" : [
	\     "~/svn/vip/trunk/silverlight/**/"
	\   ],
	\   "^vip3" : [
	\     "~/svn/vip/trunk/as3/**/"
	\   ],
	\   "^vip2" : [
	\     "~/svn/vip/trunk/as2/**/"
	\   ]
	\ }
nnoremap <c-f> :FufFile <CR> 
nnoremap <c-b> :FufBuffer <CR>
nnoremap <Leader>m :FufMruFile <CR>
nnoremap <silent> <F7> :FufTag <CR>

" NERDTree
nnoremap <silent> <F4> :NERDTreeToggle <CR>

" NERDCommentor
let NERDSpaceDelims = 1


" Grep
nnoremap <silent> <F3> :Rgrep<CR> 
let Grep_Default_Options = '-i'
let Grep_Skip_Dirs = '.svn'
let Grep_Skip_Files = '*~ *.swp tags'
let Grep_Find_Use_Xargs = 0
let Grep_Default_Filelist = '*.rb'


" Taglist
let Tlist_Inc_Winwidth = 0
let Tlist_Close_On_Select = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1

" actionscript language
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'
nnoremap <c-e> :TlistToggle <CR>

" NeoComplCache
" Use neocomplcache. 
let g:NeoComplCache_EnableAtStartup = 1 
" Use smartcase. 
let g:NeoComplCache_SmartCase = 1 
" Use camel case completion. 
let g:NeoComplCache_EnableCamelCaseCompletion = 1 
" Use underbar completion. 
" let g:NeoComplCache_EnableUnderbarCompletion = 1 
" Set minimum syntax keyword length. 
let g:NeoComplCache_MinSyntaxLength = 3 
" Set manual completion length. 
let g:NeoComplCache_ManualCompletionStartLength = 0 
" Set minimum keyword length. 
let g:NeoComplCache_MinKeywordLength = 3 

" Print caching percent in statusline. 
let g:NeoComplCache_CachingPercentInStatusline = 1 

" Define dictionary. 
let g:NeoComplCache_DictionaryFileTypeLists = { 
      \ 'default' : '', 
      \ 'vimshell' : $HOME.'/.vimshell_hist', 
      \ 'scheme' : $HOME.'/.gosh_completions', 
      \ 'scala' : $DOTVIM.'/dict/scala.dict', 
      \ 'ruby' : $DOTVIM.'/dict/ruby.dict' 
      \ } 

" Define keyword. 
if !exists('g:NeoComplCache_KeywordPatterns') 
  let g:NeoComplCache_KeywordPatterns = {} 
endif 
let g:NeoComplCache_KeywordPatterns['default'] = '\h\w*' 

let g:NeoComplCache_SnippetsDir = $HOME.'/snippets' 

" Plugin key-mappings. 
imap <silent><C-l>     <Plug>(neocomplcache_snippets_expand) 
smap <silent><C-l>     <Plug>(neocomplcache_snippets_expand) 
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>" 
inoremap <expr><silent><C-g>     neocomplcache#undo_completion() 
inoremap <expr><C-s>     neocomplcache#complete_common_string()

colo vividchalk
colo vividchalk
