---
title: Project
tags:
    - project
---

# Project

**Command**: `project`

**Shorthands**: `p`

The `project` command is a parent command that provides various operations for managing [Project][project_concept](s). This command supports subcommands like `list`, `submit`, `describe`, and `remove` to handle different project-related tasks.


## Usage
``` {.sh linenums="0" .no-copy}
pars project [flags]
```
``` {.sh linenums="0" .no-copy}
pars project [command]
```



## Commands

| Name                          | Description |
|-------------------------------|-------------|
| [`submit`][project_submit_command]               | Creates new project |
| [`list`][project_list_command]             | List all existing projects |
| [`describe`][project_describe_command]     | Shows detailed information about a specified project |
| [`remove`][project_remove_command]         | Removes one or more specified projects |



???+ tip
    You can use suggestions to list available sub commands. To do this, simply press ++tab++ to proceed. For more details, please visit our [Command Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/commands.md).
	



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



<!-- Additional links -->
[project_concept]: ../../../getting-started/concept/project.md
[project_submit_command]: submit.md
[project_list_command]: list.md
[project_describe_command]: describe.md
[project_remove_command]: remove.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags