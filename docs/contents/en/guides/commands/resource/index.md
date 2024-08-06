---
title: Resource
tags:
    - resource
---

# Resource

**Command**: `resource`

**Shorthands**: `r`

The `resource` command is a parent command that provides various operations for managing [Resource][resource_concept](s). This command supports subcommands like `list`, `submit`, and `remove` to handle different resource-related tasks.


## Usage
``` {.sh linenums="0" .no-copy}
pars resource [flags]
```
``` {.sh linenums="0" .no-copy}
pars resource [command]
```



## Commands

| Name                          | Description |
|-------------------------------|-------------|
| [`submit`][resource_submit_command]               | Creates new resource |
| [`list`][resource_list_command]             | List all existing resources |
| [`remove`][resource_remove_command]         | Removes one or more specified resources |



???+ tip
    You can use suggestions to list available sub commands. To do this, simply press ++tab++ to proceed. For more details, please visit our [Command Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/commands.md).
	



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



<!-- Additional links -->
[resource_concept]: ../../../getting-started/concept/resource.md
[resource_submit_command]: submit.md
[resource_list_command]: list.md
[resource_remove_command]: remove.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags