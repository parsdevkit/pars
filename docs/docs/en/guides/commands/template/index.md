---
title: Template
tags:
    - template
---

# Template

**Command**: `template`

**Shorthands**: `t`

The `template` command is a parent command that provides various operations for managing [Template][template_concept](s). This command supports subcommands like `list`, `submit`, and `remove` to handle different template-related tasks.


## Usage
``` {.sh linenums="0" .no-copy}
pars template [flags]
```
``` {.sh linenums="0" .no-copy}
pars template [command]
```



## Commands

| Name                          | Description |
|-------------------------------|-------------|
| [`submit`][template_submit_command]               | Creates new template |
| [`list`][template_list_command]             | List all existing templates |
| [`remove`][template_remove_command]         | Removes one or more specified templates |



???+ tip
    You can use suggestions to list available sub commands. To do this, simply press ++tab++ to proceed. For more details, please visit our [Command Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/commands.md).
	



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



<!-- Additional links -->
[template_concept]: ../../../getting-started/concept/template.md
[template_submit_command]: submit.md
[template_list_command]: list.md
[template_remove_command]: remove.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags