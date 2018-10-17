git官网
http://git-scm.com/dowmload
git config --global user.emaill "tianyang_shenshi@126.com"
git config --global user.name "tianyang"
创建版本库 git init
将修改注册到版本库 git add foo.txt bar.txt
git commit --message "tijiao"
检查状态 git status
git rm
克隆版本库
git clone /projects/first-steps /projects/first-steps-clone
假设我们修改了first-steps/foo.txt
操作
cd /projects/first-steps
git add foo.txt
git commit --message "ssss"
然后我们在克隆版本库做一次修改
 cd /projects/first-steps-clone
 git add bar.html
 git commit --message ""
接下来使用pull命令将原版本的提交同步给克隆库
cd /projects/first-steps-clone
git pull
git pull 只在克隆库有作用
要将克隆库的修改pull到原始库中需要
1)cd /proejects/first-steps 
2) git pull  /proejects/first-steps-clone master
git clone --bare /projects/first-steps /projects/frist-steps-bare.git 创建共享库
加入修改了原始版本库，现在向共享库同步提交修改
1)cd /proejects/first-steps 
2) git push /projects/first-steps-bare.git master
克隆库取到共享库的相应修改
1)cd /proejects/first-steps-clone 
2) git pull /projects/first-steps-bare.git master
git diff 77d231f HEAD
git diff 77d231f^! 比较当前提交和上一次提交
git diff 77d231f 05bcfd1 -book/bisection/  限制文件范围
git diff --stat 77d231f 05bcfd1 显示修改的数量
git log -n 3 显示最后三次提交
git log --format=fuller 显示更多细节
git log --oneline 显示概述
--stat 哪些文件
--dirstat 哪些文件夹
--shortstat 多少文件和文件夹被修改
--graph 显示提交关系
git log --pretty=oneline
git log --oneline/-format
git log -stat 
git log --oneline --decorate 在日记中显示标签
git log --graph --pretty=oneline --abbrev-commit
git add命令将修改的文件纳入一个缓存区也叫暂存区
 
比较当前版本库中HEAD提交和暂存区的不同
git diff --staged
比较工作区和缓存区的不同
git diff 

git stash命令将工作区和暂存区的修改保存到一个储藏栈

查看储藏栈
git stash list
恢复之前的储藏
git stash pop stash@{1}
git存文件的方式
git hash-object -w hello.txt
日后访问通过存文件时返回的40位字符
git cat-file -p 28cf6740e

git branch 查看分支命令 带*的为活跃分支 
git branch -a  包含远程分支
git branch -vv  本地分支和远程分支关联关系

创建分支 git branch a-branch
切换到指定分支 git checkout a-branch
为任意一批提交创建分支 git branch still-a-branch ss@##4tt6
从现有分支创建新分支 git branch new-branch   old-branch
强制切换分支  git checkout --force a-branch 
但是会丢失修改 可以使用 git stash 储藏起来  以后使用 git stash pop 恢复之前的储藏
删除分支 git branch -d a-branch 
强制删除分支  git branch -D a-branch
查找删除的分支的提交散列值 git reflog
净化版本 删除不属于当前分支的提交 使用gc命令
合并分支 git merge a-branch
当出现冲突可以使用  git checkout --ours 或者 git checkout --theirs
合并时强制产生一次提交 不使用快速提交 git merge --no-ff a-branch
查看合并之前的父级提交 git log --merges


git remote --verbose 显示用于获取或推送提交的路径
查看远程跟踪分支 git branch -r 
从远程分支中分岔出一个本地分支
git checkout -b feature-b origin/feature-b
git fetch origin feature-b:my-feature-b
将feature-a下新的提交传送给clone所指向的远程版本库
git push origin feature-a
删除远程版本库的分支
git push origin :feature-a
pull=fetch+merge
讨厌钻石链的 使用 git pull --rebase


创建标签
git tag v1.0
git tag v0.9 f52c633
git tag -a v0.1 -m "version 0.1 released" 1094adb
查看标签
git tag
git tag 1.2.3.4 master -m "sssss" 创建标签
删除标签
git tag -d v0.1
git show-ref --dereference --tags
推送某个标签到远程
git push origin v1.0
一次性推送全部尚未推送到远程的本地标签
git push origin --tags
如果标签已经推送到远程，要删除远程标签就麻烦一点，先从本地删除：
git tag -d v0.9
git push origin :refs/tags/v0.9



git  tag -1 显示所有标签
git reset  --hard HEAD^回退到上个版本
git reset  --hard HEAD^^回退到上上个版本
git reset  --hard HEAD~100回退到上100个版本
未添加缓存区回退
git checkout foo.txt
暂存区的修改撤销掉
git reset HEAD readme.txt

本地仓库关联GIThut
git remote add origin git@github.com:tianyang2017/my-notes.git
把本地库的所有内容推送到远程库上：
由于远程库是空的，我们第一次推送master分支时，加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，
还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令。
git push -u origin master


指定本地dev分支与远程origin/dev分支的链接
git branch --set-upstream-to=origin/dev dev

在本地创建和远程分支对应的分支，使用
git checkout -b branch-name origin/branch-name


用git check-ignore命令检查：
git check-ignore -v App.class



给GIT命令取别名
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
接下来就可以使用
git ci
git st
git lg


每个仓库的Git配置文件都放在.git/config文件中

在git bash下查看状态中文文件名全部显示为数字
git config --global core.quotepath false




















 




-





























