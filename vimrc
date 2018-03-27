" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"           for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  tags = 'source'
  activate_this = "{} {}".format(tags,os.path.join(project_base_dir, 'bin/activate'))
  #execfile(activate_this, dict(__file__=activate_this))
  #print(activate_this)
  os.system(activate_this)
EOF

if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile        " keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

"去除VI一致性,必须
set nocompatible

"必须             
filetype off

"设置Vundle的运行路径
set rtp+=/opt/vim8/share/vim/bundle/vundle.vim

call vundle#begin('/opt/vim8/share/vim/bundle')
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
"添加YouCompleteMe代码补全插件
Plugin 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'
"使用tab键切换窗口与目录树
Plugin 'jistr/vim-nerdtree-tabs'
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
"python语法检测
Plugin 'scrooloose/syntastic'
"添加PEP8代码风格检查
Plugin 'nvie/vim-flake8'
"配色方案
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
"代码折叠插件
Plugin 'tmhedberg/SimpylFold'
"自动缩进
Plugin 'vim-scripts/indentpython.vim'
"在vim的normal模式下搜索文件
Plugin 'kien/ctrlp.vim'
call vundle#end()

filetype plugin indent on


if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
call togglebg#map("<F5>")

"开启代码折叠
set foldmethod=indent
set foldlevel=99
"设置快捷键为空格
noremap <space> za
"显示折叠代码的文档字符串
let g:SimpylFold_docstring_preview=1

syntax on
colorscheme darkblue
set showmatch
set nu

"taglist 设置                                                                             
"
let Tlist_Auto_Open=1                                                                     
set tags=tags                                                                             
set autochdir                                                                             
:set pastetoggle=<F11>
vnoremap <Leader>y "+y

"只显示当前文件的tags
let Tlist_Enable_Fold_Column = 0
let Tlist_Show_One_File = 1                                                           
"设置taglist宽度
let Tlist_WinWidth=30
"taglist 窗口是最后一个窗口，则退出VIM
let Tlist_Eixt_OnlyWindow=1
"在VIM窗口右侧显示taglist窗口                                                             
let Tlist_Use_Right_Window=1
"F4默认打开/关闭taglist
nnoremap <silent><F4> :TlistToggle<CR>

