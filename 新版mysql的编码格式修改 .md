# 新版mysql的编码格式修改  
在mysql5.7里面输入中文，会出现  
![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20181009191933.png)  
这样的错误  


大家在网上可以的查得到那些修改方法，什么创建数据库的时候设置好编码格式啥的，但是那样都不治标。  
最优的方法就是修改my.ini文件  


## 但是新版的sql，my.ini文件地址却换了  
真实地址为：C:\ProgramData\MySQL\MySQL Server 5.7  
有人的是隐藏文件，需要修改查看方式  

![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20181009192252.png)  

我们打开ini文件，加上几个单词  
![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20181009192356.png)  
## 嗯，这样就好了  

