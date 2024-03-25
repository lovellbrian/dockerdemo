# dockerdemo
Demonstrate how Docker works and then build a container from scratch in GO

This repository uses submodules and symbolic links, so it is best to clone to a WSL **Linux** file system. Note that `git clone` will not copy the files in the docs submodule by default.  Use this command:

```console
git clone --recurse-submodules https://github.com/lovellbrian/dockerdemo
```
Alternatively, you can use a standard `git clone` command and then fetch the submodule as follows:

```console
git clone https://github.com/lovellbrian/dockerdemo
git submodule --init
git submmodule --update
```
