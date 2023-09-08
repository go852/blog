---
title: Bash编程
categories:
  - [程序设计,Bash]
tags:
  - 程序设计
  - Bash
date: 2023-04-21 09:05:46
---

## macos升级Bash

macos自带的Bash版本较低，不支持关联数组等一系列功能。因此，需要升级到最新版的Bash。

1. 通过brew安装最新版的bash
2. 在/etc/shells文件末尾增加一行：/usr/local/bin/bash
3. 修改缺省Shell为/usr/local/bin/bash

```bash
brew install bash
if [[ -z $(grep "/usr/local/bin/bash" /etc/shells) ]] ; then sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"; fi
chsh -s /usr/local/bin/bash
```

<!--more-->

## 控制语句：分支与循环

### case

```
case word in [ [(] pattern [ | pattern ] ... ) list ;; ] ... esac

A case command first expands word, and tries to match it against each pattern in turn, using the matching rules described under Pattern Matching below.
The word is expanded using tilde expansion, parameter and variable expansion, arithmetic expansion,  command  substitution,  process  substitution  and quote  removal.  Each pattern examined is expanded using tilde expansion, parameter and variable expansion, arithmetic expansion, command substitution, and process substitution.  If the nocasematch shell option is enabled, the match is performed without regard to  the  case  of  alphabetic  characters.
When  a  match  is  found, the corresponding list is executed.  If the ;; operator is used, no subsequent matches are attempted after the first pattern match.  Using ;& in place of ;; causes execution to continue with the list associated with the next set of patterns.  Using ;;& in place of  ;;  causes the  shell to test the next pattern list in the statement, if any, and execute any associated list on a successful match, continuing the case statement execution as if the pattern list had not matched.  The exit status is zero if no pattern matches.  Otherwise, it is the exit status of the last command executed in list.
```



```bash
func_case(){
  read -p "$(echo -e "请选择0-2:")" choose
  case $choose in
  0)
    echo -e "选择的是0: 继续"
    ;& # 继续往下执行
  1)
    echo -e "选择的是1"
    ;;& # 继续执行*)的表达式
  2)
    echo -e "选择的是2"
    ;; # 退出case
  *)
    echo -e "错误：你选择的不是0-2！"
    ;; # 退出case
  esac
}
func_case
```

### if

```
if list; then list; [ elif list; then list; ] ... [ else list; ] fi

The if list is executed.  If its exit status is zero, the then list is executed.  Otherwise, each elif list is executed in turn, and if its exit status is zero, the corresponding then list is executed and the command completes.  Otherwise, the else list is executed, if present.  The exit status is  the exit status of the last command executed, or zero if no condition tested true.
```

```bash

```

### for

```bash
for name [ [ in [ word ... ] ] ; ] do list ; done
The list of words following in is expanded, generating a list of items.  The variable name is set to each element of this list in turn, and list is executed each time.  If the in word is omitted, the for command executes list once for each positional parameter that is set (see PARAMETERS below).  The return status is the exit status of the last command that executes.  If the expansion of the items following in results in an empty list,  no  commands are executed, and the return status is 0.

for (( expr1 ; expr2 ; expr3 )) ; do list ; done
First,  the  arithmetic  expression  expr1  is evaluated according to the rules described below under ARITHMETIC EVALUATION.  The arithmetic expression expr2 is then evaluated repeatedly until it evaluates to zero.  Each time expr2 evaluates to a non-zero value, list is executed and the arithmetic  expression  expr3  is evaluated.  If any expression is omitted, it behaves as if it evaluates to 1.  The return value is the exit status of the last command in list that is executed, or false if any of the expressions is invalid.
```

### while

```
while list-1; do list-2; done
until list-1; do list-2; done

The  while command continuously executes the list list-2 as long as the last command in the list list-1 returns an exit status of zero.  The until command is identical to the while command, except that the test is negated: list-2 is executed as long as the last command in list-1  returns  a  non-zero exit status.  The exit status of the while and until commands is the exit status of the last command executed in list-2, or zero if none was executed.
```

```bash
func_main() {
while :
do
  echo "........... V2Ray 一键安装脚本 & 管理脚本 by Paul Ding .........."
  echo
  echo "帮助说明: https://www.gocoin.one/install.html"
  echo
  echo "搭建教程: https://www.gocoin.one/tutor.html"
  echo
  echo " 1. 安装"
  echo
  echo " 2. 卸载"
  echo

  read -p "$(echo -e "请选择 [1-2]:")" choose
  case $choose in
  1)
    echo -e "1: install"
    break
    ;;
  2)
    echo -e "2: uninstall"
    break
    ;;
  *)
    echo -e "错误：你选择的不是1-2！"
    ;;
  esac
done
}
func_main
```

## 判断

### []

### [[ ]]

### test

```
test expr
[ expr ]
Return a status of 0 (true) or 1 (false) depending on the evaluation of the conditional expression expr.  Each operator and operand must be a  separate
argument.   Expressions are composed of the primaries described above under CONDITIONAL EXPRESSIONS.  test does not accept any options, nor does it ac‐
cept and ignore an argument of -- as signifying the end of options.

Expressions may be combined using the following operators, listed in decreasing order of precedence.  The evaluation depends on  the  number  of  argu‐
ments; see below.  Operator precedence is used when there are five or more arguments.
! expr True if expr is false.
( expr )
Returns the value of expr.  This may be used to override the normal precedence of operators.
expr1 -a expr2
True if both expr1 and expr2 are true.
expr1 -o expr2
True if either expr1 or expr2 is true.

test and [ evaluate conditional expressions using a set of rules based on the number of arguments.

0 arguments
	The expression is false.
1 argument
The expression is true if and only if the argument is not null.

2 arguments
If the first argument is !, the expression is true if and only if the second argument is null.  If the first argument is one of the unary condi‐
tional operators listed above under CONDITIONAL EXPRESSIONS, the expression is true if the unary test is true.  If the first argument is  not  a
valid unary conditional operator, the expression is false.

3 arguments
The  following conditions are applied in the order listed.  If the second argument is one of the binary conditional operators listed above under
CONDITIONAL EXPRESSIONS, the result of the expression is the result of the binary test using the first and third arguments as operands.  The  -a
and  -o  operators are considered binary operators when there are three arguments.  If the first argument is !, the value is the negation of the
two-argument test using the second and third arguments.  If the first argument is exactly ( and the third argument is exactly ), the  result  is
the one-argument test of the second argument.  Otherwise, the expression is false.

4 arguments
If the first argument is !, the result is the negation of the three-argument expression composed of the remaining arguments.  Otherwise, the ex‐
pression is parsed and evaluated according to precedence using the rules listed above.

5 or more arguments
The expression is parsed and evaluated according to precedence using the rules listed above.

When used with test or [, the < and > operators sort lexicographically using ASCII ordering.
```

## 变量

### 变量替换

将文件中的chrome替换为icon，只替换第1个

```bash
for file in *.png ; do mv $file ${file/chrome/icon};done
```



## 数组

### 普通数组

声明数组：declare -a ciphers

```
定义：以圆括号开始和结束，以空白符（含空格、制表键、换行符）分割
下标：从0开始
访问数组元素：${array_name[0]}、${array_name[1]}、${array_name[2]}...
访问所有元素：${array_name[*]}或者 ${array_name[@]}
获取数组长度：${#array_name[*]}或者 ${#array_name[@]}

ciphers=(aes-128-gcm aes-256-gcm chacha20-ietf-poly1305)
与下面效果相同
declare -a ciphers=([0]="aes-128-gcm" [1]="aes-256-gcm" [2]="chacha20-ietf-poly1305")
```

```bash
ciphers=(aes-128-gcm aes-256-gcm chacha20-ietf-poly1305)
echo ${ciphers[*]}
echo ${ciphers[@]}
echo ${#ciphers[@]}

echo ${ciphers[@]:1} # 下标1及之后的元素
echo ${ciphers[@]:1:2} # 下标1及之后共2个元素
echo ${!ciphers[@]} # 显示所有下标，与关联数组的键名类似

for ((i=0;i<${#ciphers[@]};i++)); do echo "\${ciphers}[$i]:" ${ciphers[i]}; done

for cipher in ${ciphers[@]}; do 
  echo $cipher
  echo ${cipher:0:3} # 显示前3个字符
  echo ${cipher: -1} # 减号'-'前面留至少一个空格，取自字符串末尾反向1个字符
  echo ${cipher: -10} # 减号'-'前面留至少一个空格，取自字符串末尾反向10个字符
done
```

### 关联数组

声明关联数组：declare -A

```
方式一：
declare -A sites
sites["google"]="www.google.com"
sites["taobao"]="www.taobao.com"

方式二：
sites=([google]="www.google.com" [taobao]="www.taobao.com" )

方式三：
declare -A sites=([google]="www.google.com" [taobao]="www.taobao.com" )
```

在数组前加一个感叹号 !可以获取数组的所有键名，例如：

```bash
declare -A sites
sites["google"]="www.google.com"
sites["taobao"]="www.taobao.com"
echo ${sites["google"]}
echo ${!sites[@]}
echo ${sites[@]}

for key in ${!sites[@]}; do 
  echo ${key}: ${sites[${key}]}
done
```

<img src="image-20230301080243717.png" alt="image-20230301080243717" style="zoom: 33%;" />

```bash
declare -A mydict=(
  ["name"]="guess" 
  ["old"]=18 
  ["favorite"]="coconut"
  ["my description"]="I am a student"
)
echo ${mydict[@]}
for key in ${!mydict[@]}; do 
  echo ${key}: ${mydict[${key}]}
done
```

<img src="image-20230301080103823.png" alt="image-20230301080103823" style="zoom: 33%;" />

## 函数function

```
Shell Function Definitions
A shell function is an object that is called like a simple command and executes a compound command with a new set of positional parameters.   Shell  functions
are declared as follows:

fname () compound-command [redirection]
function fname [()] compound-command [redirection]
This defines a function named fname.  The reserved word function is optional.  If the function reserved word is supplied, the parentheses are optional.
The body of the function is the compound command compound-command (see Compound Commands above).  That command is usually a list of commands between  { and  }, but may be any command listed under Compound Commands above, with one exception: If the function reserved word is used, but the parentheses are not supplied, the braces are required.  compound-command is executed whenever fname is specified as the name of a simple command.  When in posix  mode, fname  must  be  a valid shell name and may not be the name of one of the POSIX special builtins.  In default mode, a function name can be any unquoted shell word that does not contain $.  Any redirections (see REDIRECTION below) specified when a function is defined are performed when the  function  is executed.   The  exit  status  of  a function definition is zero unless a syntax error occurs or a readonly function with the same name already exists.
When executed, the exit status of a function is the exit status of the last command executed in the body.
```

## command

![image-20230225081736571](image-20230225081736571.png)

```bash
[[ $(command -v wget) ]] || sudo apt install wget
```

## echo

带颜色输出

```bash
echo -e '\e[31m'hello 31'\e[0m'
echo -e '\e[32m'hello 32'\e[0m'
echo -e '\e[33m'hello 33'\e[0m'
echo -e '\e[34m'hello 34'\e[0m'
echo -e '\e[35m'hello 35'\e[0m'
echo -e '\e[36m'hello 36'\e[0m'
echo -e '\e[37m'hello 37'\e[0m'
echo -e '\e[39m'hello 39'\e[0m'

echo -e '\e[91m'hello 91'\e[0m'
echo -e '\e[92m'hello 92'\e[0m'
echo -e '\e[93m'hello 93'\e[0m'
echo -e '\e[94m'hello 94'\e[0m'
echo -e '\e[95m'hello 95'\e[0m'
echo -e '\e[96m'hello 96'\e[0m'
echo -e '\e[97m'hello 97'\e[0m'

echo -e '\e[40m'hello 40'\e[0m'
echo -e '\e[41m'hello 41'\e[0m'
echo -e '\e[42m'hello 42'\e[0m'
echo -e '\e[43m'hello 43'\e[0m'
echo -e '\e[44m'hello 44'\e[0m'
echo -e '\e[45m'hello 45'\e[0m'
echo -e '\e[46m'hello 46'\e[0m'
echo -e '\e[47m'hello 47'\e[0m'
echo -e '\e[49m'hello 49'\e[0m'

echo -e '\e[100m'hello 100'\e[0m'
echo -e '\e[101m'hello 101'\e[0m'
echo -e '\e[102m'hello 102'\e[0m'
echo -e '\e[103m'hello 103'\e[0m'
echo -e '\e[104m'hello 104'\e[0m'
echo -e '\e[105m'hello 105'\e[0m'
echo -e '\e[106m'hello 106'\e[0m'
echo -e '\e[107m'hello 107'\e[0m'
```

| 背景 | 背景 | 字体 |    字体    | 前景 |    前景    |
| :--: | ---- | :--: | :--------: | :--: | :--------: |
| code | 说明 | code |    说明    | code |    说明    |
|  40  | 黑   |  0   |    默认    |  31  |  红（浅）  |
|  41  | 红   |  1   |    粗体    |  32  |  绿（浅）  |
|  42  | 绿   |  2   |    淡化    |  33  |  黄（浅）  |
|  43  | 黄   |  3   |    斜体    |  34  |  蓝（浅）  |
|  44  | 蓝   |  4   |   下划线   |  35  | 品红（浅） |
|  45  | 品红 |  5   |    闪烁    |  36  |  青（浅）  |
|  46  | 青   |  7   |    反转    |  37  |  白（浅）  |
|  47  | 白   |  8   |    隐藏    |  39  |    默认    |
|  49  | 默认 |  9   |   删除线   |  90  |  黑（亮）  |
| 101  | 黑   |  21  |  双下划线  |  91  |  红（亮）  |
| 102  | 红   |  22  |    默认    |  92  |  绿（亮）  |
| 102  | 绿   |  23  |  取消斜体  |  93  |  黄（亮）  |
| 103  | 黄   |  24  | 取消下划线 |  94  |  蓝（亮）  |
| 104  | 蓝   |  25  |  取消闪烁  |  95  | 品红（亮） |
| 105  | 青   |  27  |  取消反转  |  96  |  青（亮）  |
| 106  | 品红 |  28  |  取消隐藏  |  97  |  白（亮）  |
| 107  | 白   |  29  | 取消删除线 |      |            |
|      |      |      |            |      |            |

```bash
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

_red hello red
_green hello green
_yellow hello yellow
_magenta hello magenta
_cyan hello cyan
```

## hostnamectl

命令使用说明：

![hostnamectl帮助信息](image-20230225090316984.png)

执行命令及运行结果

```bash
hostnamectl status
```

![hostnamextl status运行结果](image-20230225090348448.png)

## id

获得用户或组ID：

![id帮助信息](image-20230225080741054.png)

![id常用命令选项](image-20230225080922038.png)

root用户与组的ID均为0，因此判断是否为root用户使用$(id -n)是否为0即可。

```bash
red='\e[91m'
none='\e[0m'
[[ $(id -u) != 0 ]] && echo -e "\n 请使用 ${red}root ${none}用户运行 ${yellow}~(^_^) ${none}\n" && exit 1
```

## read

```
read [-ers] [-a aname] [-d delim] [-i text] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [name ...]

One line is read from the standard input, or from the file descriptor fd supplied as an argument to the -u option, split into words as described  above
under  Word  Splitting,  and the first word is assigned to the first name, the second word to the second name, and so on.  If there are more words than
names, the remaining words and their intervening delimiters are assigned to the last name.  If there are fewer words read from the  input  stream  than
names,  the remaining names are assigned empty values.  The characters in IFS are used to split the line into words using the same rules the shell uses
for expansion (described above under Word Splitting).  The backslash character (\) may be used to remove any special meaning  for  the  next  character
read and for line continuation.  Options, if supplied, have the following meanings:
-a aname
The  words  are  assigned  to sequential indices of the array variable aname, starting at 0.  aname is unset before any new values are assigned.
Other name arguments are ignored.
-d delim
The first character of delim is used to terminate the input line, rather than newline.  If delim is the empty string, read will terminate a line
when it reads a NUL character.
-e     If  the  standard  input is coming from a terminal, readline (see READLINE above) is used to obtain the line.  Readline uses the current (or de‐
fault, if line editing was not previously active) editing settings, but uses Readline's default filename completion.
-i text
If readline is being used to read the line, text is placed into the editing buffer before editing begins.
-n nchars
read returns after reading nchars characters rather than waiting for a complete line of input, but honors a delimiter if fewer than nchars char‐
acters are read before the delimiter.
-N nchars
read  returns  after reading exactly nchars characters rather than waiting for a complete line of input, unless EOF is encountered or read times
out.  Delimiter characters encountered in the input are not treated specially and do not cause read to return until nchars characters are  read.
The result is not split on the characters in IFS; the intent is that the variable is assigned exactly the characters read (with the exception of
backslash; see the -r option below).
-p prompt
Display prompt on standard error, without a trailing newline, before attempting to read any input.  The prompt is displayed  only  if  input  is
coming from a terminal.
-r     Backslash does not act as an escape character.  The backslash is considered to be part of the line.  In particular, a backslash-newline pair may
not then be used as a line continuation.
-s     Silent mode.  If input is coming from a terminal, characters are not echoed.
-t timeout
Cause read to time out and return failure if a complete line of input (or a specified number of characters) is not read within timeout  seconds.
timeout  may  be a decimal number with a fractional portion following the decimal point.  This option is only effective if read is reading input
from a terminal, pipe, or other special file; it has no effect when reading from regular files.  If read times out, read saves any partial input
read into the specified variable name.  If timeout is 0, read returns immediately, without trying to read any data.  The exit status is 0 if in‐
put is available on the specified file descriptor, non-zero otherwise.  The exit status is greater than 128 if the timeout is exceeded.
-u fd  Read input from file descriptor fd.

If no names are supplied, the line read, without the ending delimiter but otherwise unmodified, is assigned to the variable REPLY.  The exit status  is
zero,  unless end-of-file is encountered, read times out (in which case the status is greater than 128), a variable assignment error (such as assigning
to a readonly variable) occurs, or an invalid file descriptor is supplied as the argument to -u.
```



```bash
read -p "$(echo -e "请选择0-2:")" choose
echo $choose
```

## rename

支持正则表达式以及多个文件，如：

```bash
rename 's|chrome|icon|' *.png # 将所有.png文件名中的chrome替换为icon

rename 's|icon|chrome|' *.png # 将所有.png文件名中的icon替换为chrome
```



## uname

![uname帮助信息](image-20230225081622896.png)

## uuidgen

![uuidgen帮助信息](image-20230225082343000.png)

```bash
uuidgen -r # 随机产生uuid
echo $(uuidgen -r)
```

## 网络功能

### 获取公网IP地址

```bash
ip=$(curl -s "https://ifconfig.me/")
echo $ip

getip (){
  echo $(curl -s "https://ifconfig.me/") #利用标准输出返回ip值
}
echo $(getip)
```

