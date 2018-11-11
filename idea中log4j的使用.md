# idea中log4j的使用

## 第一步

* 将log4j包导入idea

  ![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repo20181111152927.png)

  如图，在此处导入log4j的jar包

## 第二步

* 导入其配置文件

```
配置文件//可以直接复制使用，也可以去网上了解一下详细的信息
```

```
# Global logging configuration 开发时候建议使用 debug
log4j.rootLogger=DEBUG, stdout
# Console output...
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%5p [%t] - %m%n
```

## 第三步

* 基本使用操作

* ```java
  import org.apache.log4j.Logger;
  
  public class log4j {
      private static final Logger LOGGER = Logger.getLogger(log4j.class);
      public static void main(String[] args) {
          LOGGER.info("信息");
          LOGGER.error("错误");
          LOGGER.debug("调试");
          LOGGER.warn("警告");
      }
  }
  
  ```

  * 首先，你得注意import的包，一定要是log4j的

  * 其次，注意一下logger的生成方式

  * ```java
     Logger logger=Logger.getLogger("test");
    ```

  * 最后，没啥了，就用着呗

  ## 一个小错误的处理

  ```error
  log4j:WARN No appenders could be found for logger (org.springframework.web.context.ContextLoader). 
  log4j:WARN Please initialize the log4j system properly.
  ```

  我有一次遇到了这个问题

  最后的解决方法是将log4j.properties文件放在src内，跟你的项目包同一等级。

![](https://raw.githubusercontent.com/xunyegege/picgo_repo/master/G%3A%5Cgithub%5Cpicgo_repoimage_7.png)

My github  https://github.com/xunyegege