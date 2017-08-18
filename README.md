## Introduction

根据个人工作中的需求对命令行的进行了一些扩展（包含添加新命令和改造已有命令），本项目**基于ubuntu和ubuntu的衍生版本**（暂不支持RedHat系列以及Mac OS），并且扩展只针对**bash**（暂不支持其他shell）
</br></br>

## Install

1. cd ~
2. git clone https://github.com/PowerfulSpider/system_config.git
3. cd system_config
4. sudo ./intall.sh
5. source ~/.bashrc
  </br>

**注意：**

- 如果system_config中的部分命令与已有命令名称相同，可以在安装完后修改~/system_config/.bashrc中的冲突命令的名称，修改完之后，执行source ~/.bashrc
  </br></br>

## Features

扩展或新增的命令集合：cd、of、putclip、up、re、s
</br></br>

## Documentation

1. **cd**

cd命令会创建一个文件.dir_history，在你进入任何一个目录的时候，该目录的绝命路径将会被存储到.dir_history中，供下次执行cd命令时使用。

```sh
user@user-OptiPlex-3046:~
$ cd sys con
0) /home/user/system_config
1) /home/user/system_config/.cache
2) /home/user/system_config/test
=> est
0) /home/user/system_config/test
=> 0
user@user-OptiPlex-3046:~/system_config/test
$ 
```

支持多个词语过滤.dir_history中的历史路径，.dir_history中的路径只有完全包含这些过滤词时才会被打印，在打印完之后，可以继续输入词语过滤或者直接输入序号进入序号对应的路径。

**注意：**

- 如果序号为0的路径就是你想进入的路径，直接*Enter*就可以，不需要输入0
- 路径会根据使用记录自动排序，越近访问的越靠前
  </br></br>

2. **re**

re是查找历史命名记录的命令，其使用方法和cd命令基本相同。

```sh
user@user-OptiPlex-3046:~/system_config
$ re git clone acc
0) re git clone acc
1) git clone git@192.168.3.15:data-integration/com.kgtdata.access.client.git
2) git clone 192.168.3.15:data-integration/com.kgtdata.access.client.git
=> @
0) git clone git@192.168.3.15:data-integration/com.kgtdata.access.client.git
=> 
```

re命令同样支持多个词语过滤.bash_history的历史命令，.bash_history中的历史命令只有完全包含这些过滤词时才会被打印，在打印完之后，可以继续输入词语过滤或者直接输入序号（序号对应的历史命令将会被保存到系统剪贴板中）。

**注意：**

- 如果序号为0的历史命令就是你需要的历史命令，直接*Enter*就可以，不需要输入0
- 历史命令会根据使用记录自动排序，越近访问的越靠前
  </br></br>

3. **of**

of命令是在命令行中打开文件管理器的命令，其使用方法和cd命令基本相同。

```sh
user@user-OptiPlex-3046:~$ of sys
0) /home/user/system_config
1) /home/user/system_config/test
2) /home/user/system_config/.cache
3) /sys
=> 
```

of命令同样支持支持多个词语过滤.dir_history中的历史路径，.dir_history中的路径只有完全包含这些过滤词时才会被打印，在打印完之后，可以继续输入词语过滤或者直接输入序号打开序号对应路径的文件夹。

**注意：**

- 如果序号为0的路径就是你想打开的，直接*Enter*就可以，不需要输入0
- 路径会根据使用记录自动排序，越近访问的越靠前
  </br></br>

4. **s**


s命令是在终端中用firefox搜索的命令

```sh
user@user-OptiPlex-3046:~
$ s kw1 kw2 ... kwn
0) https://www.bing.com/search?q=keyword
1) https://www.baidu.com/s?wd=keyword
=> 1
```

可以自定义搜索引擎，上面显示了两个搜索引擎（百度和bing）

s命令在打印完候选项之后，同样可以输入词语继续过滤或者输入序号（firefox会自动打开并搜索）

**注意：**

- 如果序号为0的候选项就是你想要使用的搜索引擎，直接*Enter*就可以，不需要输入0
  </br></br>
  
5. **putclip**


putclip命令是在终端中通过管道复制文本到系统剪贴板的命令

```sh
user@user-OptiPlex-3046:~/xul/java_workspace
$ pwd|putclip
user@user-OptiPlex-3046:~/xul/java_workspace
$ cat text.txt|putclip
```

使用putclip命令之后，再粘贴，便可将先前放到系统剪贴板中的文本粘贴出来
  </br></br>


## Disclaimer

参考了大师的作品：https://github.com/baohaojun/system-config
</br></br>


## License

GPLv3
