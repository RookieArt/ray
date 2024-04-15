# 如何将 upstream 代码同步到 fork 仓库

```bash
# 拉取本项目
git clone https://github.com/RookieArt/ray.git

# 设置 upstream
git remote add upstream https://github.com/ray-project/ray.git

# 拉取 upstream 的所有 branch 和 tag
git fetch upstream

# 同步分支
git push origin "refs/remotes/upstream/*:refs/heads/*" --force

# 同步 tag
git push --tags

```

