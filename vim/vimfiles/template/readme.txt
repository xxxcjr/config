快速从模板建立文件
来源：http://www.gracecode.com/archives/2414/
OCTOBER 8, 2008
最近很多人被我“拉下水”尝试 (g)Vim，为了支持他们，我会编写些 Vim 脚本方便大家。

这里有个现成的需求，就是很多从 Editplus 转过来的同学，想让 Vim 有从模板新建文件的功能。那么，这篇文章可能就是你们想要的。

安装步骤

下载代码包以后，解压缩到 $VIMRUNTIME 目录。重新启动 Vim，输入

:NewTemplate xhtml
就可以建立个 XHTML 模板，如果是 Vim 7.0 以上的版本，还有个命令

:NewTemplateTab xhtml
即可在新的标签页中新建文件。当然可以映射快捷键，快速新建常用的文件类型，比如我的

" 新建 XHTML 的快捷键
map nn :NewTemplateTab xhtml<cr>
在 normal 模式下，连续按两次 n 就可以在新标签页建立 xhtml 文件了。

配置脚本

此插件文件的路径在

$VIMRUNTIME/plugin/Template.vim
下，主要有两个配置选项，默认为

let g:TemplatePath=$VIM.'/vimfiles/template/'
let g:TemplateCursorFlag='#cursor#'
其中，g:TemplatePath 为模板路径，而 g:TemplatePathCursorFlag 则为新建模板以后鼠标移动到的位置（如无指定，则移动到文件底部）。

增加模板

脚本支持用户新建模板，找到 g:TemplatePath 中的 xhtml.tpl 目录。参考其中的内容

<html>
...
    <body>
        #cursor#
    </body>
</html>
应该很容易理解。比如需要新建 python 模板。则在 g:TemplatePath 中建立 python.tpl 并加入 #cursor# 的位置即可。