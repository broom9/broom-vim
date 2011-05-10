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
let mapleader=","
set autoread


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
au BufNewFile,BufRead *.py set noexpandtab
au BufNewFile,BufRead *.java set noexpandtab
au BufNewFile,BufRead *.h set noexpandtab
au BufNewFile,BufRead *.m set noexpandtab
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
map <F11> :set hls!<Bar>set hls?<CR>
map <F10> :set paste!<Bar>set paste?<CR>
map <F9>  :set wrap!<Bar>set wrap?<CR>

map <F6>  :%s//\r/g<CR>
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>



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
let g:fuf_dir_exclude = '\/$|\v\~$|\.o$|\.exe$|\.bak$|\.swp$|\.swf$|/Debug/|/Bin/|/ClientBin/|/App_Data/|\.class$'
let g:fuf_abbrevMap = {
	\   "^hc" : [
	\     "~/svn/hc/**/"
	\   ],
	\   "^jss" : [
	\     "~/svn/integration/trunk/js/**/"
	\   ],
	\   "^andr" : [
	\     "~/svn/integration/trunk/android/**/"
	\   ],
	\   "^coco" : [
	\     "~/svn/integration/trunk/cocoa/**/"
	\   ],
	\   "^as2s" : [
	\     "~/svn/integration/trunk/as2/src/**/"
	\   ],
	\   "^old3" : [
	\     "~/svn/integration/as3_old_src/**/"
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
	\   "^r2js" : [
	\     "~/svn/r2/trunk/js/**/"
	\   ],
	\   "^r2an" : [
	\     "~/svn/r2/trunk/android/**/"
	\   ],
	\   "^sl3" : [
	\     "~/svn/vip/silverlight/**/"
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


" Ack
nnoremap <F3> :Ack 

" xobjc
nnoremap <c-x> <ESC>:!python ~/svn/integration/trunk/tools/cocoa/xobjc/xobjc.py %<CR>


" Taglist
let Tlist_Inc_Winwidth = 0
let Tlist_Close_On_Select = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1

" actionscript language
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'
nnoremap <c-e> :TlistToggle <CR>

colo ir_black
