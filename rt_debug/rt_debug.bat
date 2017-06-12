@echo off
@rem 解压 src.zip
if not exist .\src ( 
	@echo "unzip src.zip...";
    unzip .\src.zip -d .\src > rt_debug.log 
)

@rem 删除 src\com\sun\java\swing目录并创建jdk_src_classes目录用于存放编译后的class
@echo "delete swing package..."
if exist .\src\com\sun\java\swing (
	RMDIR /Q /S .\src\com\sun\java\swing
)
if not exist .\jdk_src_classes (
	MKDIR .\jdk_src_classes
)

@rem 将源码包中所有的java类都列出到jdk_src_files.txt文件中
DIR /B /S /X .\src\*.java > .\jdk_src_files.txt

@rem 编译源码
@echo "compile..."
.\bin\javac -nowarn -verbose -g -J-Xms128m -J-Xmx1024m -bootclasspath .\jre\lib\rt.jar;.\jre\lib\jce.jar;.\jre\lib\jsse.jar;.\jre\lib\resources.jar;.\jre\lib\charsets.jar;.\jre\lib\deploy.jar;.\lib\tools.jar -sourcepath .\src -classpath .\src -d jdk_src_classes -cp .\jre\lib\rt.jar @jdk_src_files.txt > rt_debug.log 2>&1

@rem 复制rt.jar到jdk_src_classes目录下并打包成rt_debug.jar
@echo "jar..."
COPY .\jre\lib\rt.jar .\jdk_src_classes
CD .\jdk_src_classes  && jar -cf rt_debug.jar * && CD .. && COPY .\jdk_src_classes\rt_debug.jar .

@rem 清除日志信息
@echo "clear..."
RMDIR /Q /S .\jdk_src_classes
RMDIR /Q /S .\src
DEL /Q /S .\jdk_src_files.txt

@echo "done success!"


pause





