---
title: Pars Commands
tags:
    - env
    - log-level
    - logLevelEnum
---


# Commands

The `pars` command is the root command for managing workspaces, groups, and other tasks. It supports various subcommands and global flags to provide flexibility and control over different environments and logging levels.


## Usage
``` {.sh linenums="0" .no-copy}
pars [type] [command] [options] [flags]
```

???+ tip
    Aliases are shorthands for commands and flags in example, `workspace remove` shorthand is `w r`


## Commands

| Name                         | Description |
|------------------------------|-------------|
| [`init`][init]               | Creates a new workspace |
| [`workspace`][workspace]     | Manages workspaces, including list, describe, and remove |
| [`group`][group]             | Manages groups |
| [`completion`][completion]   | Provides autocompletion support for the CLI |

### `init`

The `init` command is used to create a new workspace. This is the only way to create a workspace in the application.

### `workspace`
The `workspace` command is used to manage workspaces. It supports subcommands like `list`, `describe`, and `remove`.

### `group`
The `group` command is used to manage groups. It supports subcommands like `list`, `new`, `describe`, and `remove`.

### `completion`
The `completion` command provides autocompletion support for the CLI.




???+ tip
    You can use suggestions to list available sub commands. To do this, simply press ++tab++ to proceed. For more details, please visit our [Command Autocompletion and Filtering Guide](../advanced-usage/autocompletion-and-filtering/commands.md).




## Global Flags

| Name          | Datatype    | Required | Default | Description |
|---------------|-------------|-----------|-----------------------|-------------|
| `env`, `e`    | `string`    | false     | `workspace`           | Provides full isolation for tasks and processes, operating within the specified environment. |
| `log-level`   | [`LogLevelEnum`][LogLevelEnum] | false     | `Error`     | Sets the logging level to control the verbosity of log output (e.g., debug, info). |


### `env`
* Aliases `e`
* Datatype: `string`
* Type: `text`
* Multiplicity: Optional
* Default: `none`
* Description: Provides full isolation for tasks and processes. Only operates within the specified  <pars:Environment> when the flag is set.


??? example

    **Specific environment** : 
        [`workspace list`][workspace_list] in specific environment

    ```sh
    pars workspace list --env my-env
    ```
    <div class="result" sh>
    (0) workspace available

    Running on 'my-env' environment
    </div>



### `log-level`
* Datatype: [`LogLevelEnum`][LogLevelEnum]
* Type: `enum`
* Multiplicity: Optional
* Default: `Error`
* Valid Values: `Silence`, `Verbose`, `Info`, `Warn`, `Error`, `Fatal`
* Description: Sets the logging level to control the verbosity of log output. Useful for debugging and monitoring.






??? example

    **Set logging level** : 
        [`workspace list`][workspace_list] with `verbose` logging

    ```sh
    pars workspace list --log-level verbose
    ```
    <div class="result" sh>
    (0) workspace available
    </div>



## Common Flags

| Name          | Datatype    | Required | Default | Description |
|---------------|-------------|-----------|-----------------|-------------|
| `help`, `h`    | `none`     | false     | `""`              |  Displays usage information and summaries for commands. |



### `help`
* Aliases `h`
* Datatype: `none`
* Type: `none`
* Multiplicity: Optional | Single
* Default: `none`
* Description: Displays usage information and summaries for commands.



??? example

    **Print help details for command** : 
        See [`workspace list`][workspace_list] help details

    ```sh
    pars workspace list --help
    ```
    <div class="result" sh>
    <pre>
    List workspace project(s)

    Usage:
      pars workspace list [flags]

    Aliases:
      list, l
    
    Examples:
      pars workspace list [flags]
      pars wl [flags]
    
    Flags:
      -h, --help   help for list
    
    Global Flags:
          --config string        config file (default is $HOME/.cli.yaml)
      -e, --env string           Environment (dev, prod, test, ...)
          --log-level LogLevel   Select log level [Silence Verbose Info Warn Error Fatal] (default Error)
    </pre>
    </div>




---
This documentation provides a comprehensive overview of the `pars` root command, its subcommands, and global flags. Utilize these commands and flags to effectively manage workspaces, groups, and other related tasks within the CLI application.


<!-- Additional links -->
[init]: init/index.md
[workspace]: workspace/index.md
[workspace_list]: workspace/list.md
[group]: group/index.md
[completion]: completion/index.md
[LogLevelEnum]: ../schemas/enum/logLevelEnum.md