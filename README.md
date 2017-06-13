# rt_debug
将jdk的源码进行重新编译，用于局部变量的调试

## 重编译原因

jdk提供的rt.jar进行debug调试时不能查看到局部变量的值，这是因为sun对rt.jar的类编译时，去除了调试信息，所以我们必须重新编译jdk源码并打包成rt.jar


## 编译步骤

1. 解压jdk安装目录下的src.zip文件
2. 遍历src目录下的所有java类路径并保存到某个txt文件中
3. 使用javac命令编译src目录下的java源码（对照上一步生成的路径文件）
4. 复制rt.jar到编译后的classes目录下并打包成rt_debug.jar


## 懒人专用

> 可以直接跳过上面的步骤，直接生成rt_debug.jar包

#### window 环境

1. 将 [rt_debug.bat](./rt_debug/rt_debug.bat) 放到jdk安装目录下
2. 双击运行，会自动生成rt_debug.jar包
3. 将rt_debug.jar包添加到jre环境中。(如果是Eclipse，【Window】 -> 【preferences】 -> [Java] -> [Installed JRE] -> 选择指定的jdk版本 -> [Add Extenal JARs] -> 选择刚编译生成的rt_debug.jar -> 将此rt_debug.jar [Up] 到 rt.jar之上) 