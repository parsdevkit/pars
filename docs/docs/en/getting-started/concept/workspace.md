---
title: Workspace Concept
tags:
    - workspace
---

# Workspace

## Definition
> A workspace is the primary structure where you organize and manage your projects. Each workspace can contain multiple projects and related structures.


* Working area for one or more project
* Physical folder location

You can use [`init`][init_command] command to create fresh workspace or you can use the [`workspace`][workspace_command] command to perform operations

[workspace_command]: ../../guides/commands/workspace/index.md
[init_command]: ../../guides/commands/init/index.md


## Terminology



### Selected Workspace

**Selected workspace** is the workspace that you have explicitly chosen. It might not necessarily be the one you are currently working in but is marked as your preferred workspace.



???+ example
    
    In the workspace list, the selected workspace is indicated by a `selected` label.

    ```sh
    pars workspace list
    ```
    <div class="result" sh>
    <pre>
    (4) workspace available

    \* workspace_0 (selected)
    workspace_1
    workspace_2
    workspace_3
    </pre>
    </div>



### Active Workspace

**Active workspace** is the workspace that is associated with your current directory or any parent directory. It represents the workspace that is actively in use within the context of your current location in the file system.

???+ example
    
    In the workspace list, the active workspace is indicated by an `active` label.

    ```sh
    pars workspace list
    ```
    <div class="result" sh>
    <pre>
    (4) workspace available

    \* workspace_0 (active)
    workspace_1 (selected)
    workspace_2
    workspace_3
    </pre>
    </div>



### Current Workspace

**Current workspace** is determined based on the presence of an active workspace. If an active workspace exists, it is considered the current workspace, regardless of which workspace is selected. If no active workspace is present, the selected workspace becomes the current workspace.


???+ example
    
    If the current workspace is only selected, it is indicated as below:


    ```sh
    pars workspace list
    ```
    <div class="result" sh>
    <pre>
    (4) workspace available

    \* workspace_0 (selected)
    workspace_1
    workspace_2
    workspace_3
    </pre>
    </div>



    If the current workspace is both active and selected, it is indicated as below:

    ```sh
    pars workspace list
    ```
    <div class="result" sh>
    <pre>
    (4) workspace available

    \* workspace_0 (active & selected)
    workspace_1
    workspace_2
    workspace_3
    </pre>
    </div>
    
    If the current workspace is only active, it is indicated as below:


    ```sh
    pars workspace list
    ```
    <div class="result" sh>
    <pre>
    (4) workspace available

    \* workspace_0(active)
    workspace_1 (selected)
    workspace_2
    workspace_3
    </pre>
    </div>
    

By understanding these distinctions, you can better navigate and manage your workspaces within the system. Here is a quick summary of the labels used in the workspace list:

- `active` : Active workspace
- `selected` : Selected workspace
- `active & selected` : Both Active and Selected
- `*` : Current workspace

This structure ensures you always know which workspace is in use and how they are identified within the system.


## Initializing Workspace

To initialize a new workspace, use the [`init`][init_command] command:

```sh
pars init <workspace_name>
```


## Listing Workspaces


To list all available workspaces, use the [`workspace list`][workspace_list_command] command:


```sh
pars workspace list
```


## Workspace Details

To view details of a specific workspace, use the [`workspace describe`][workspace_describe_command] command:


```sh
pars workspace describe <workspace_name>
```


## Removing Workspace

To remove a workspace, use the [`workspace remove`][workspace_remove_command] command:


```sh
pars workspace remove <workspace_name>
```

## Changing Current Workspace

To change the active workspace, navigate to the desired workspace directory and use the [`workspace --switch`][workspace_command_switch_flag] command:


```sh
pars workspace --switch <workspace_name>
```


By keeping these commands and concepts in mind, you can efficiently manage your workspaces in Pars.




<!-- Additional links -->

[init_command]: ../../guides/commands/init/index.md
[workspace_command]: ../../guides/commands/workspace/index.md
[workspace_list_command]: ../../guides/commands/workspace/list.md
[workspace_describe_command]: ../../guides/commands/workspace/describe.md
[workspace_remove_command]: ../../guides/commands/workspace/remove.md
[workspace_command_switch_flag]: ../../guides/commands/workspace/index.md#-switch