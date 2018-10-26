**新特性**

**1、本地变量类型推断**

什么是局部变量类型推断？

```
var javastack = "javastack";  
System.out.println(javastack); 
复制代码
```

大家看出来了，局部变量类型推断就是左边的类型直接使用 var 定义，而不用写具体的类型，编译器能根据右边的表达式自动推断类型，如上面的 String 。

```
var javastack = "javastack"; 
复制代码
```

就等于：

```
String javastack = "javastack"; 
复制代码
```

**2、字符串加强**

Java 11 增加了一系列的字符串处理方法，如以下所示。

```
// 判断字符串是否为空白  

" ".isBlank();                // true  

// 去除首尾空格  

" Javastack ".strip();          // "Javastack"  

// 去除尾部空格   

" Javastack ".stripTrailing();  // " Javastack"  

// 去除首部空格   

" Javastack ".stripLeading();   // "Javastack "  

// 复制字符串  

"Java".repeat(3);             // "JavaJavaJava"  

// 行数统计  

"A\nB\nC".lines().count();    // 3 
复制代码
```

**3、集合加强**

自 Java 9 开始，Jdk 里面为集合（List/ Set/ Map）都添加了 of 和 copyOf 方法，它们两个都用来创建不可变的集合，来看下它们的使用和区别。

**示例1：**

```
var list = List.of("Java", "Python", "C");  

var copy = List.copyOf(list);  

System.out.println(list == copy);   // true 
复制代码
```

**示例2：**

```
var list = new ArrayList<String>();  

var copy = List.copyOf(list);  

System.out.println(list == copy);   // false 

复制代码
```

示例1和2代码差不多，为什么一个为true,一个为false?

来看下它们的源码：

```
static <E> List<E> of(E... elements) {  

    switch (elements.length) { // implicit null check of elements  

        case 0:  

            return ImmutableCollections.emptyList();  

        case 1:  

            return new ImmutableCollections.List12<>(elements[0]);  

        case 2:  

            return new ImmutableCollections.List12<>(elements[0], elements[1]);  

        default:  

            return new ImmutableCollections.ListN<>(elements);  

    }  

}  

static <E> List<E> copyOf(Collection<? extends E> coll) {  

    return ImmutableCollections.listCopy(coll);  

}  

static <E> List<E> listCopy(Collection<? extends E> coll) {  

    if (coll instanceof AbstractImmutableList && coll.getClass() != SubList.class) {  

        return (List<E>)coll;  

    } else {  

        return (List<E>)List.of(coll.toArray());  

    }  

} 
复制代码
```

可以看出 copyOf 方法会先判断来源集合是不是 AbstractImmutableList 类型的，如果是，就直接返回，如果不是，则调用 of 创建一个新的集合。

示例2因为用的 new 创建的集合，不属于不可变 AbstractImmutableList 类的子类，所以 copyOf 方法又创建了一个新的实例，所以为false.

注意：使用 of 和 copyOf 创建的集合为不可变集合，不能进行添加、删除、替换、排序等操作，不然会报 java.lang.UnsupportedOperationException 异常。

上面演示了 List 的 of 和 copyOf 方法，Set 和 Map 接口都有。

**4、Stream 加强**

Stream 是 Java 8 中的新特性，Java 9 开始对 Stream 增加了以下 4 个新方法。

1. 增加单个参数构造方法，可为null

```
Stream.ofNullable(null).count(); // 0 
复制代码
```

1. 增加 takeWhile 和 dropWhile 方法

```
Stream.of(1, 2, 3, 2, 1)  

    .takeWhile(n -> n < 3)  

    .collect(Collectors.toList());  // [1, 2] 
复制代码
```

从开始计算，当 n < 3 时就截止。

```
Stream.of(1, 2, 3, 2, 1)  

    .dropWhile(n -> n < 3)  

    .collect(Collectors.toList());  // [3, 2, 1] 
复制代码
```

这个和上面的相反，一旦 n < 3 不成立就开始计算。

3）iterate重载

这个 iterate 方法的新重载方法，可以让你提供一个 Predicate (判断条件)来指定什么时候结束迭代。

如果你对 JDK 8 中的 Stream 还不熟悉，可以看之前分享的这一系列教程。

**5、Optional 加强**

Opthonal 也增加了几个非常酷的方法，现在可以很方便的将一个 Optional 转换成一个 Stream, 或者当一个空 Optional 时给它一个替代的。

```
Optional.of("javastack").orElseThrow();     // javastack  

Optional.of("javastack").stream().count();  // 1  

Optional.ofNullable(null)  

    .or(() -> Optional.of("javastack"))  

    .get();   // javastack 
复制代码
```

**6、InputStream 加强**

InputStream 终于有了一个非常有用的方法：transferTo，可以用来将数据直接传输到 OutputStream，这是在处理原始数据流时非常常见的一种用法，如下示例。

```
var classLoader = ClassLoader.getSystemClassLoader();  

var inputStream = classLoader.getResourceAsStream("javastack.txt");  

var javastack = File.createTempFile("javastack2", "txt");  

try (var outputStream = new FileOutputStream(javastack)) {  

    inputStream.transferTo(outputStream);  

} 
复制代码
```

**7、HTTP Client API**

这是 Java 9 开始引入的一个处理 HTTP 请求的的孵化 HTTP Client API，该 API 支持同步和异步，而在 Java 11 中已经为正式可用状态，你可以在 [java.net](https://link.juejin.im/?target=http%3A%2F%2Fjava.net) 包中找到这个 API。

来看一下 HTTP Client 的用法：

```
var request = HttpRequest.newBuilder()  

    .uri(URI.create("https://javastack.cn"))  

    .GET()  

    .build();  

var client = HttpClient.newHttpClient();  

// 同步  

HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());  

System.out.println(response.body());  

// 异步  

client.sendAsync(request, HttpResponse.BodyHandlers.ofString())  

    .thenApply(HttpResponse::body)  

    .thenAccept(System.out::println); 
复制代码
```

上面的 .GET() 可以省略，默认请求方式为 Get！

更多使用示例可以看这个 API，后续有机会再做演示。

现在 Java 自带了这个 HTTP Client API，我们以后还有必要用 Apache 的 HttpClient 工具包吗？

**8、化繁为简，一个命令编译运行源代码**

看下面的代码。

```
// 编译  
javac Javastack.java  


// 运行  
java Javastack 
复制代码
```

在我们的认知里面，要运行一个 Java 源代码必须先编译，再运行，两步执行动作。而在未来的 Java 11 版本中，通过一个 java 命令就直接搞定了，如以下所示。

```
java Javastack.java 
复制代码
```

**更多新特性**

新发布的Java 11在新特性方面，提供了17个JEP(JDK Enhancement Proposal 特性增强提议)



![img](https://user-gold-cdn.xitu.io/2018/10/25/166a8d9eb8622118?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)



上图是Oracle公布的Java 11包含的所有新特性，其中几个重点的新特性为：

**ZGC：可扩展的低延迟垃圾收集器**

ZGC是一款号称可以保证每次GC的停顿时间不超过10MS的垃圾回收器，并且和当前的默认垃圾回收起G1相比，吞吐量下降不超过15%。

**Epsilon：什么事也不做的垃圾回收器**

Java 11还加入了一个比较特殊的垃圾回收器——Epsilon，该垃圾收集器被称为“no-op”收集器，将处理内存分配而不实施任何实际的内存回收机制。 也就是说，这是一款不做垃圾回收的垃圾回收器。这个垃圾回收器看起来并没什么用，主要可以用来进行性能测试、内存压力测试等，Epsilon GC可以作为度量其他垃圾回收器性能的对照组。大神Martijn说，Epsilon GC至少能够帮助理解GC的接口，有助于成就一个更加模块化的JVM。

**增强var用法**

Java 10中增加了本地变量类型推断的特性，可以使用var来定义局部变量。尽管这一特性被很多人诟病，但是并不影响Java继续增强他的用法，在Java 11中，var可以用来作为Lambda表达式的局部变量声明。

**移除Java EE和CORBA模块**

早在发布Java SE 9的时候，Java就表示过，会在未来版本中将Java EE和CORBA模块移除，而这样举动终于在Java 11中实施。终于去除了Java EE和CORBA模块。

**HTTP客户端进一步升级**

JDK 9 中就已对 HTTP Client API 进行标准化，然后通过JEP 110，在 JDK 10 中进行了更新。在本次的Java 11的更新列表中，由以JEP 321进行进一步升级。该API通过CompleteableFutures提供非阻塞请求和响应语义，可以联合使用以触发相应的动作。 JDK 11完全重写了该功能。现在，在用户层请求发布者和响应发布者与底层套接字之间追踪数据流更容易了，这降低了复杂性，并最大程度上提高了HTTP / 1和HTTP / 2之间的重用的可能性。