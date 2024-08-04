---
title: Group
tags:
    - group
---

# Group

**Command**: `group`

**Shorthands**: `g`

The `group` command is a parent command that provides various operations for managing [Group][group_concept](s). This command supports subcommands like `list`, `submit`, `describe`, and `remove` to handle different group-related tasks.


## Usage
``` {.sh linenums="0" .no-copy}
pars group [flags]
```
``` {.sh linenums="0" .no-copy}
pars group [command]
```



## Commands

| Name                          | Description |
|-------------------------------|-------------|
| [`submit`][group_submit_command]               | Creates new group |
| [`list`][group_list_command]             | List all existing groups |
| [`describe`][group_describe_command]     | Shows detailed information about a specified group |
| [`remove`][group_remove_command]         | Removes one or more specified groups |



???+ tip
    You can use suggestions to list available sub commands. To do this, simply press ++tab++ to proceed. For more details, please visit our [Command Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/commands.md).
	



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



<!-- Additional links -->
[group_concept]: ../../../getting-started/concept/group.md
[group_submit_command]: submit.md
[group_list_command]: list.md
[group_describe_command]: describe.md
[group_remove_command]: remove.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags