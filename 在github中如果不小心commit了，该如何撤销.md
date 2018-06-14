# 在github中如果不小心commit了，该如何撤销
![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo%E7%A7%BB%E5%8A%A8.gif)  
在这里，笔者不小心将一个200多m的文件放进了github仓库里，并且还commit了。（笔者使用的是sourcetree来操作github仓库的，这个不影响，使用命令的朋友也ok）    
push是肯定搞不定的，因为github限制了单文件大小必须小于100m。  
如果现在不将先前的这个commit撤销的话，后面的东西是上传不了的。  
## 解决方法如下  
我们打开命令行  
![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20180614115007.png)  
输入 git log  
![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20180614120521.png)  
我们发现，刚刚commit的是我画的一号圈，这个是我们不小心commit的。我们需要回到之前的那个版本，那就是我画的二号圈。  
现在我们将二号圈的commit后面的那个数字复制下来（那个是commit的hash值）。
## 输入回退命令  
git reset --hard (+上面让你复制的commit hash值)  ![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20180614120820.png)  
然后  
![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20180614120837.png)  
哦了  
我们看下效果  
![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repohuitui.gif)  
现在上面的push提示消失了。  
我们再看下版本迭代记录  
![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20180614121104.png)  
现在的版本跟我们commit log记录的时间一致。  
###  大功告成  
在此也欢迎大家加入我的github项目，一起发展，一起完善，也感谢小伙伴们点star。  
github地址：https://github.com/xunyegege/source  
