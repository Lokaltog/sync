" Basic configuration {{{
	syntax on
	filetype plugin indent on

	" Define , as map leader
	let mapleader=','

	" Disable all bells
	set noerrorbells visualbell t_vb=

	set nocompatible
	set tags=tags;.vimtags;
	" General options {{{
		set nobackup
		set noswapfile
		set nomodeline
		set undofile
		set updatecount=200
		set directory=~/.vim/tmp
		set undodir=~/.vim/tmp
		set autochdir
		set backspace=indent,eol,start
		set fileformats=unix,dos
		set fileformat=unix
		set matchpairs+=<:>
		set shortmess=atToOI
		set iskeyword+=_,$,@,%,#
		set whichwrap=b,s,[,]
		set hidden
		set encoding=utf-8
		set termencoding=utf-8
	" }}}
	" Wild menu {{{
		set wildmenu
		set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
		set wildmode=full
	" }}}
" }}}
" UI options {{{
	set laststatus=2
	set fillchars=vert:║,fold:Û
	set hlsearch
	set incsearch
	set number
	set numberwidth=4
	set ruler
	set scrolloff=10
	set sidescrolloff=20
	set showcmd
	set showbreak=Ì
	set virtualedit=all
	set textwidth=0
	set confirm
	set updatetime=1500
	set history=1000
	set undolevels=1000
	set listchars=tab:Ë\ ,trail:í,eol:î
	set pumheight=10

	colo lokaltog
	" Change cursor color in insert mode {{{
		if &term =~ "xterm\\|rxvt"
			silent !echo -ne "]12;\#dd4010\x7"
			let &t_SI="]12;\#89b6e2\x7"
			let &t_EI="]12;\#dd4010\x7"
			au VimLeave * silent !echo -ne "]12;\#dd4010\x7"
		endif
	" }}}
" }}}
" Status line {{{
	set statusline=
	set statusline+=%1*%(%{substitute(fugitive#statusline(),'GIT\(\\([a-z0-9\\-_\\.]\\+\\)\)','\ Í\ \\1\ │','gi')}%*%) " Git branch (User1)
	set statusline+=%< " Separator, truncate
	set statusline+=\ %f " File (relative path)
	set statusline+=%7*%(%{cfi#format('\ in\ %s','')}%)%*
	set statusline+=%2*%(\ %{SyntasticStatuslineFlag()}%)%*
	set statusline+=%2*%(\ %M%)%* " Modified (+, -) (User2)
	set statusline+=%3*%(\ [%R%H%W]%)%* " RO,HLP,PRV (User3)
	set statusline+=\ %= " Separator, left/right
	set statusline+=%6*%(\ %{&fileformat}%)%* " File format
	set statusline+=%6*%(\ %{(&fenc==''?&enc:&fenc)}%)%* " File encoding
	set statusline+=\ %(%l:%c%V%)
	set statusline+=\ %1*│%* " Group end
	set statusline+=%4*%(%{strlen(&ft)?'\ '.&ft.'\ ':''}%1*│%)%* " File type (User4)
	set statusline+=\ %5*%P\ %* " Percentage (User5) (always 3 in length)
"	set statusline+=\ %{synIDattr(synID(line('.'),col('.'),1),'name')}
" }}}
" Layout / Text formatting {{{
	set autoindent
	set wrap
	set formatoptions=tcroqn1
	set ignorecase
	set linebreak
	set shiftwidth=6
	set tabstop=6
	set smartcase
	set smartindent
	set smarttab
	set startofline
	set completeopt=menu,menuone,longest,preview
" }}}
" Folding {{{
	set foldenable
	set foldmethod=marker
	set foldlevel=1
	set foldcolumn=0

	function! VimFold()
		let t=getline(v:foldstart)
		let w=strlen(matchstr(t, '^\s*'))
		let t=substitute(t, '^\W*', '', '')
		let t=substitute(t, '\W*$', '', '')
		let n=v:foldend - v:foldstart + 1

		return repeat(repeat(' ', &tabstop), w).t.' Î'.n.' ÝÏ '
	endfunction

	au FileType vim set foldlevel=0 foldtext=VimFold()
" }}}
" Mappings {{{
	" F key mappings {{{
		nnoremap <silent><F7> :LustyJuggler<CR>
		nnoremap <silent><F8> :TlistToggle<CR>
		nnoremap <silent><F9> :LustyBufferExplorer<CR>
		nnoremap <silent><F10> :NERDTreeToggle<CR>
		nnoremap <silent><F11> :GundoToggle<CR>
	" }}}
	" Quick edit .vimrc {{{
		nnoremap <Leader>ev :e $MYVIMRC<CR>
		nnoremap <Leader>sv :so $MYVIMRC<CR>
	" }}}
	" Enter command mode quickly {{{
		nnoremap ; :
	" }}}
	" Navigate by visual lines {{{
		noremap k gk
		noremap j gj
	" }}}
	" Tab indenting in visual mode {{{
		vnoremap <Tab> >gv
		vnoremap <S-Tab> <gv
	" }}}
	" Clear search highlighting {{{
		nnoremap <silent> <Leader>/ :silent noh<cr>
	" }}}
	" Sudo write {{{
		command! -bar -nargs=0 W  silent! exec "write !sudo tee % >/dev/null"  | silent! edit!
	" }}}
	" Write and make file executable {{{
		command! -bar -nargs=0 WX silent! exec "write !chmod a+x % >/dev/null" | silent! edit!
	" }}}
	" Fix broken vim regexes when searching {{{
		" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines
		nnoremap / /\v
		vnoremap / /\v
	" }}}
	" Easier bracket matching {{{
		nnoremap <Tab> %
	" }}}
	" Vertically split window and select it  {{{
		nnoremap <Leader>w <C-w>v<C-w>l
	" }}}
	" Easier split window navigation {{{
		nnoremap H <C-w>h
		nnoremap J <C-w>j
		nnoremap K <C-w>k
		nnoremap L <C-w>l
	" }}}
	" Mouse toggle {{{
		fun! ToggleMouse()
			if !exists("old_mouse")
				let old_mouse = "ar"
			endif

			if &mouse == ""
				let &mouse = old_mouse
				echo "Mouse is for Vim (" . &mouse . ")"
			else
				let old_mouse = &mouse
				let &mouse=""
				echo "Mouse is for terminal"
			endif
		endfunction

		nnoremap <F12> :call ToggleMouse()<CR>
	" }}}
	" Line moving {{{
		function! MoveLineUp()
			call MoveLineOrVisualUp(".", "")
		endfunction

		function! MoveLineDown()
			call MoveLineOrVisualDown(".", "")
		endfunction

		function! MoveVisualUp()
			call MoveLineOrVisualUp("'<", "'<,'>")
			normal gv
		endfunction

		function! MoveVisualDown()
			call MoveLineOrVisualDown("'>", "'<,'>")
			normal gv
		endfunction

		function! MoveLineOrVisualUp(line_getter, range)
			let l_num=line(a:line_getter)
			if l_num - v:count1 - 1 < 0
				let move_arg="0"
			else
				let move_arg=a:line_getter." -".(v:count1 + 1)
			endif
			call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
		endfunction

		function! MoveLineOrVisualDown(line_getter, range)
			let l_num=line(a:line_getter)
			if l_num + v:count1 > line("$")
				let move_arg="$"
			else
				let move_arg=a:line_getter." +".v:count1
			endif
			call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
		endfunction

		function! MoveLineOrVisualUpOrDown(move_arg)
			let col_num=virtcol(".")
			execute "silent! ".a:move_arg
			execute "normal! ".col_num."|"
		endfunction

		nnoremap <silent> <Leader>k :<C-u>call MoveLineUp()<CR>
		nnoremap <silent> <Leader>j :<C-u>call MoveLineDown()<CR>
		vnoremap <silent> <Leader>k :<C-u>call MoveVisualUp()<CR>
		vnoremap <silent> <Leader>j :<C-u>call MoveVisualDown()<CR>
	" }}}
" }}}
" Autocommands {{{
	augroup general " {{{
		autocmd!
		" Custom psql highlighting {{{
			au BufNewFile,BufRead *.sql set ft=psql foldmethod=marker
		" }}}
		" Nginx highlighting {{{
			au BufNewFile,BufRead /etc/nginx/conf/* set ft=nginx
		" }}}
		" Script templates {{{
			au BufNewFile *.sh  so ~/.vim/templates/tpl.sh
			au BufNewFile *.py  so ~/.vim/templates/tpl.py
			au BufNewFile *.php so ~/.vim/templates/tpl.php
		" }}}
		" Help file settings {{{
			au FileType help setl nonumber statusline=%f%<
			au FileType help nnoremap <buffer><space> <c-]> " Space selects subject
			au FileType help nnoremap <buffer><bs> <c-T> " Backspace to go back
			au FileType help wincmd L
			au FileType help vertical resize 80
		" }}}
		" Override SASS defaults {{{
			au FileType sass set sw=6 ts=6 noet
		" }}}
		" Disable whitespace trimming on patch files {{{
			au FileType diff au! whitespace
		" }}}
		" Enable Syntastic for selected filetypes {{{
			au BufNewFile,BufRead php,html,javascript,python,ruby,sh SyntasticEnable
		" }}}
	augroup END " }}}
	augroup list " {{{
		autocmd!
		" Set list on selected filetypes {{{
			au filetype vim setl list
			au filetype html,css,javascript,php,python,ruby setl list
		" }}}
	augroup END " }}}
	augroup whitespace " {{{
		autocmd!
		" Remove trailing whitespace on write {{{
			au BufWritePre * :call setline(1, map(getline(1, "$"), 'substitute(v:val, "\\s\\+$", "","")'))
		" }}}
	augroup END " }}}
	augroup mail " {{{
		autocmd!
		" Fix mutt mail formatting {{{
			fun! MuttMail()
				set tw=72 wrap fo+=tcqan1
				au! whitespace

				if getline(1) == ""
					" Write new mail
					norm O
					startinsert
				else
					" Reply to mail
					silent %!~/sync/bin/mail-filter reply
					norm jgqapO
					norm o
					startinsert
				endif
			endfun

			au BufRead /tmp/mutt-* call MuttMail()
		" }}}
	augroup END " }}}
" }}}
" Plugin settings {{{
	" EasyTags settings {{{
		let g:easytags_cmd='/usr/bin/ctags'
		let g:easytags_resolve_links=1
		let g:easytags_on_cursorhold=0
		let g:easytags_always_enabled=1
	" }}}
	" PHP highlighting settings {{{
		let g:php_folding=0
		let g:php_html_in_strings=1
		let g:php_parent_error_close=1
		let g:php_parent_error_open=1
		let g:php_no_shorttags=1
	" }}}
	" Python highlighting settings {{{
		let g:python_highlight_all=1
		let g:python_show_sync=1
		let g:python_print_as_function=1
	" }}}
	" delimitMate settings {{{
		let g:delimitMate_unbalanced_parens=1
		let g:delimitMate_balance_matchpairs=1

		au FileType mail,text,vim let b:delimitMate_autoclose=0
	" }}}
	" Disable annoying sql bindings {{{
		let g:ftplugin_sql_omni_key_right="<C-S-M-Right>"
		let g:ftplugin_sql_omni_key_left="<C-S-M-Left>"
	" }}}
	" NERD tree settings {{{
		let g:NERDTreeChristmasTree=1
		let g:NERDTreeCaseSensitiveSort=1
		let g:NERDTreeQuitOnOpen=1
		let g:NERDTreeWinPos='right'
		let g:NERDTreeWinSize=50
		let g:NERDTreeShowBookmarks=1
	" }}}
	" Taglist settings {{{
		let g:Tlist_WinWidth=50
		let g:Tlist_Close_On_Select=1
		let g:Tlist_Compact_Format=1
		let g:Tlist_Display_Tag_Scope=1
		let g:Tlist_Exit_OnlyWindow=1
		let g:Tlist_File_Fold_Auto_Close=1
		let g:Tlist_GainFocus_On_ToggleOpen=1
		let g:Tlist_Use_Right_Window=1
		let g:Tlist_Process_File_Always=1
	" }}}
	" Syntastic settings {{{
		let g:syntastic_enable_signs=1
		let g:syntastic_auto_loc_list=1
	" }}}
	" Gundo settings {{{
		let g:gundo_right=1
		let g:gundo_width=50
	" }}}
	" current-func-info settings {{{
		let g:cfi_php_show_params=1
	" }}}
" }}}
