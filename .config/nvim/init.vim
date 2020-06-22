" 自动安装 plug-vim
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs --insecure \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"------------------------- vim-plug 区域 --------------------------
call plug#begin()

" 自动补全工具
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Go 相关工具
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}

" 颜色主题
Plug 'altercation/vim-colors-solarized'

" vim-plug 加入插件 defx, defx-icons
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'kristijanhusak/defx-icons'
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
"------------------------- vim-plug 区域 --------------------------

" 界面美化
set laststatus=2 " 总是显示状态栏
set ruler " 行号显示
set number " 高亮当前行	
set hlsearch " 高亮搜索内容

" 缩进配置
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Solarized 主题配置
" syntax enable
" if has("gui_runing")              "如果在图形用户界面
"     set background=light          "设置背景色为亮色
" else                              "设置背景色为深色
"     set background=dark           "就开启256色支持，默认为8色  
"     set t_Co=256
" endif
" colorscheme solarized

" Coc 配置
" If hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Coc 配色调整
colorscheme
highlight Pmenu ctermfg=0 ctermbg=14 guibg=Magenta

" defx 设置
" 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
let g:maplocalleader=';'
nnoremap <silent> <LocalLeader>e
\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal signcolumn=no
	" 使用回车打开文件，如果是文件则【打开】，如果是目录则【开启或关闭目录树】
	nnoremap <silent><buffer><expr> <CR> 
				\ defx#is_directory() ?
				\ defx#do_action('open_or_close_tree') :
				\ defx#do_action('multi', ['drop', 'quit'])
	"" [h<Left>] 关闭目录树
	"nnoremap <silent><buffer><expr> h defx#do_action('multi', ['close_tree'])
	"nnoremap <silent><buffer><expr> <Left> defx#do_action('multi', ['close_tree'])
	"" [l<Right>] 开启目录树
	"nnoremap <silent><buffer><expr> l defx#do_action('multi', ['open_tree'])
	"nnoremap <silent><buffer><expr> <Right> defx#do_action('multi', ['open_tree'])
	" f 搜索文件
	"nnoremap <silent><buffer><expr> f defx#do_action('multi', ['search'])
	" 按 n 创建文件
	nnoremap <silent><buffer><expr> n defx#do_action('new_file')
	" 按 d 切换文件夹，D 回到上一个文件夹
	nnoremap <silent><buffer><expr> d defx#do_action('open_directory')
	nnoremap <silent><buffer><expr> D defx#do_action('cd', '..')
	" 按 q 关闭defx
	nnoremap <silent><buffer><expr> q defx#do_action('quit')
	" 按 r 重命名文件
	nnoremap <silent><buffer><expr> r defx#do_action('rename')
endfunction


autocmd FileType defx call s:defx_mappings()

call defx#custom#option('_', {
	\ 'columns': 'indent:git:icons:filename',
	\ 'winwidth': 25,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'listed': 1,
	\ 'show_ignored_files': 0,
	\ 'root_marker': '≡ ',
	\ 'ignored_files': 
	\	  '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp',
	\ })

" airline 设置
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
