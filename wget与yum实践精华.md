# wget与yum

### yum介绍

> Yum(全称为 Yellow dogUpdater, Modified)是一个在Fedora和RedHat以及CentOS中的Shell前端软件包管理器。基于[RPM](https://baike.so.com/doc/1772529-1874476.html)包管理，能够从指定的[服务器](https://www.baidu.com/s?wd=%E6%9C%8D%E5%8A%A1%E5%99%A8&tn=24004469_oem_dg&rsv_dl=gh_pc_csdn)自动下载RPM包并且安装，可以自动处理依赖性关系，并且一次安装所有依赖的软件包，无须繁琐地一次次下载、安装。yum提供了查找、安装、删除某一个、一组甚至全部软件包的命令，而且命令简洁而又好记。



### wget介绍

> wget是一个从网络上自动下载文件的自由工具。它支持HTTP，HTTPS和FTP协议。



## 安装（分为安装yum与wget）

### 一、安装yum

①下载最新的yum-3.2.28.tar.gz并解压（建议去官网看最新版本）

```linux
wget http://yum.baseurl.org/download/3.2/yum-3.2.28.tar.gz
tar xvf yum-3.2.28.tar.gz 
```

②进入目录，开始安装

```linux
cd yum-3.2.28  
yummain.py install yum 
```

```error
如果结果提示错误： CRITICAL:yum.cli:Config Error: Error accessing file for config file:///etc/

可能是原来是缺少配置文件。在etc目录下面新建yum.conf文件，然后再次运行 yummain.py install yum，顺利完成安装。
```

③更新系统

```linux
yum check-update  
yum update  
yum clean all 
```



### 二、安装wget

```linux
yum install wget
```

嗯，就这样就好了

### 三、如果电脑上没有yum，也没有wget怎么办

重装吧……至少会有一个的，理论上讲。



## 使用技巧

### 一、wget使用技巧

wget虽然功能强大，但是使用起来还是比较简单的。
基本的语法是：wget [参数列表] "URL"   

用" 双引号"引起来可以避免因URL中有特殊字符造成的下载出错。  

```linux
实例
使用wget下载单个文件

命令：

wget http://www.minjieren.com/wordpress-3.1-zh_CN.zip
```

```linux
实例*参考其他博客
实例2：使用wget -O下载并以不同的文件名保存

命令：

: wget -O wordpress.zip http://www.minjieren.com/download.aspx?id=1080

说明：

wget默认会以最后一个符合”/”的后面的字符来命令，对于动态链接的下载通常文件名会不正确。

错误：下面的例子会下载一个文件并以名称download.aspx?id=1080保存

wget http://www.minjieren.com/download?id=1

即使下载的文件是zip格式，它仍然以download.php?id=1080命令。

正确：为了解决这个问题，我们可以使用参数-O来指定一个文件名：

wget -O wordpress.zip http://www.minjieren.com/download.aspx?id=1080

实例3：使用wget –limit -rate限速下载

命令：

wget --limit-rate=300k http://www.minjieren.com/wordpress-3.1-zh_CN.zip

说明：

当你执行wget的时候，它默认会占用全部可能的宽带下载。但是当你准备下载一个大文件，而你还需要下载其它文件时就有必要限速了。

实例4：使用wget -c断点续传

命令：

wget -c http://www.minjieren.com/wordpress-3.1-zh_CN.zip

说明：

使用wget -c重新启动下载中断的文件，对于我们下载大文件时突然由于网络等原因中断非常有帮助，我们可以继续接着下载而不是重新下载一个文件。需要继续中断的下载时可以使用-c参数。

实例5：使用wget -b后台下载

命令：

wget -b http://www.minjieren.com/wordpress-3.1-zh_CN.zip

说明：

对于下载非常大的文件的时候，我们可以使用参数-b进行后台下载。

wget -b http://www.minjieren.com/wordpress-3.1-zh_CN.zip

Continuing in background, pid 1840.

Output will be written to `wget-log'.

你可以使用以下命令来察看下载进度：

tail -f wget-log

实例6：伪装代理名称下载

命令：

wget --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" http://www.minjieren.com/wordpress-3.1-zh_CN.zip

说明：

有些网站能通过根据判断代理名称不是浏览器而拒绝你的下载请求。不过你可以通过–user-agent参数伪装。

实例7：使用wget –spider测试下载链接

命令：

wget --spider URL

说明：

当你打算进行定时下载，你应该在预定时间测试下载链接是否有效。我们可以增加–spider参数进行检查。

wget --spider URL

如果下载链接正确，将会显示

wget --spider URL

Spider mode enabled. Check if remote file exists.

HTTP request sent, awaiting response... 200 OK

Length: unspecified [text/html]

Remote file exists and could contain further links,

but recursion is disabled -- not retrieving.

这保证了下载能在预定的时间进行，但当你给错了一个链接，将会显示如下错误

wget --spider url

Spider mode enabled. Check if remote file exists.

HTTP request sent, awaiting response... 404 Not Found

Remote file does not exist -- broken link!!!

你可以在以下几种情况下使用spider参数：

定时下载之前进行检查

间隔检测网站是否可用

检查网站页面的死链接

实例8：使用wget –tries增加重试次数

命令：

wget --tries=40 URL

说明：

如果网络有问题或下载一个大文件也有可能失败。wget默认重试20次连接下载文件。如果需要，你可以使用–tries增加重试次数。

实例9：使用wget -i下载多个文件

命令：

wget -i filelist.txt

说明：

首先，保存一份下载链接文件

cat > filelist.txt

url1

url2

url3

url4

接着使用这个文件和参数-i下载

实例10：使用wget –mirror镜像网站

命令：

wget --mirror -p --convert-links -P ./LOCAL URL

说明：

下载整个网站到本地。

–miror:开户镜像下载

-p:下载所有为了html页面显示正常的文件

–convert-links:下载后，转换成本地的链接

-P ./LOCAL：保存所有文件和目录到本地指定目录

实例11：使用wget –reject过滤指定格式下载

命令：
wget --reject=gif ur

说明：

下载一个网站，但你不希望下载图片，可以使用以下命令。

实例12：使用wget -o把下载信息存入日志文件

命令：

wget -o download.log URL

说明：

不希望下载信息直接显示在终端而是在一个日志文件，可以使用

实例13：使用wget -Q限制总下载文件大小

命令：

wget -Q5m -i filelist.txt

说明：

当你想要下载的文件超过5M而退出下载，你可以使用。注意：这个参数对单个文件下载不起作用，只能递归下载时才有效。

实例14：使用wget -r -A下载指定格式文件

命令：

wget -r -A.pdf url

说明：

可以在以下情况使用该功能：

下载一个网站的所有图片

下载一个网站的所有视频

下载一个网站的所有PDF文件

实例15：使用wget FTP下载

命令：

wget ftp-url

wget --ftp-user=USERNAME --ftp-password=PASSWORD url

说明：

可以使用wget来完成ftp链接的下载。

使用wget匿名ftp下载：

wget ftp-url

使用wget用户名和密码认证的ftp下载

wget --ftp-user=USERNAME --ftp-password=PASSWORD url
```

*编译安装命令*

```linux
# tar zxvf wget-1.9.1.tar.gz 

# cd wget-1.9.1 

# ./configure 

# make 

# make install 
```











## 二、yum命令

>1 安装
>yum install 全部安装
>yum install package1 安装指定的安装包package1
>yum groupinsall group1 安装程序组group1

> 2 更新和升级
> yum update 全部更新
> yum update package1 更新指定程序包package1
> yum check-update 检查可更新的程序
> yum upgrade package1 升级指定程序包package1
> yum groupupdate group1 升级程序组group1

> 3 查找和显示
> yum info package1 显示安装包信息package1
> yum list 显示所有已经安装和可以安装的程序包
> yum list package1 显示指定程序包安装情况package1
> yum groupinfo group1 显示程序组group1信息yum search string 根据关键字string查找安装包

> 4 删除程序
> yum remove | erase package1 删除程序包package1
> yum groupremove group1 删除程序组group1
> yum deplist package1 查看程序package1依赖情况

> 5 清除缓存
> yum clean packages 清除缓存目录下的软件包
> yum clean headers 清除缓存目录下的 headers
> yum clean oldheaders 清除缓存目录下旧的 headers
> yum clean, yum clean all (= yum clean packages; yum clean oldheaders) 清除缓存目录下的软件包及旧的header





```
<div>欢迎大家加入我的github项目</div>
<a href="https://github.com/xunyegege/source">全栈工程师进阶学习站</a><br>
<a href="https://github.com/xunyegege/gavin_note">我个人的学习及生活小记录</a><br>
<a href="https://github.com/xunyegege/report_gather">行业内最新最群的报告，工作日每日更新</a><br>
```