#阿里云服务器配置nginx，小白系列教程  
**（假设大家都会一点linux命令）**
---
##楼主写了个网页，想将其放到阿里服务器上使其通过域名访问。  
###前提条件，你的有个阿里云服务器跟域名。这个具体操作我就不教你们了，网上都有。  
###我的服务器是 linux centOs版本的，一开始什么都没装。所以，我们从零开始。（假设大家都安装好了centos系统）  
###1、安装nginx
……安装帖，我推荐个  
https://blog.csdn.net/chichengit/article/details/80807354  
但是这里有点要注意，博文里的软件链接有些已经版本过老了，可以自行去软件官网找一下最新的版本，然后下载安装。  
##现在假设大家都装好了nginx  
###假设大家都有一个网页包，也就是![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20180728164343.png)  
###现在我按照我习惯来放这个包。  
###![](https://ws1.sinaimg.cn/mw690/8937c74fgy1ftpo6q1punj205n04rmx0.jpg)  
###我把包放在/var/www/html这个文件夹下面。  
###我们把网页包放好了，就该去配置nginx了额  
###我们找到安装nginx的文件夹  
###我这边是/usr/local/nginx  
![](https://ws1.sinaimg.cn/mw690/8937c74fgy1ftpoaj1mgdj2058074jr9.jpg)  
###打开conf文件夹，里面有nginx.conf文件  
###使用vim 打开该文件  
###不要被那么长的配置文件给吓到了。我们只需修改三个地方就ok  
###①在第一行，写  user  root
###②找到sever，  


	server {
        listen       80;
        server_name  seekhub.pythonforever.com;
       # index  index.html;
       # root  /var/www/html;
          
        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   /var/www/html;
            index  index.html index.htm;
        }
###server_name写你的域名
###上面和下面都有那个root跟index  
###root后面加你的网页包路径  
###index后面加你的首页文件名  
###保存  退出  
##然后重启下nginx  （如何重启，自己百度）  
重启方法：进入nginx可执行目录sbin下，输入命令./nginx -s reload 即可
