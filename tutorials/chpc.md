# CHPC Utah Tutorial

This tutorial is particularly for commands that are hard to find in the official CHPC documentation.

## Some Facts

- Your home directory has a default quota of **50G**

## Startup

```
$ ssh <your UNID- for eg: u1419632>@notchpeak.chpc.utah.edu
Password: <CIS password>
```

## What Can You Access?

- You have certain *accounts/partitions* allocated to you. Each partition (belonging to a specific account) has some resources. 

Want to find out what partitions you have? 

```
$ myallocation
```

You know your partition, but you want to know what resources your partition has? 

```
sinfo -p <partition name>
```
If you want to know more about specific kinds of resources- like, say, GPUs:

```
sinfo -p <partition name> -O <type of resource>. 
```

Type `man sinfo` to learn more. 

## Interactive Jobs

Want to run an interactive job- i.e: want to get a (temporary) node that you can run programs on the same way you can run in the command line? Use the `salloc` command. As always, type `man salloc` to learn more. Here's an example command:

```
salloc --time=1:00:00 --ntasks 2 --nodes=1 --account=soc-gpu-np --gres=gpu:a100:1 --mem=40GB --partition=soc-gpu-np
```

You probably don't want to use a A100 to debug your program. Consider looking at what less-powerful GPUs you have access to (as shown above) and using one of those. SLURM will automatically allocate a node to you and ssh you to that node.
