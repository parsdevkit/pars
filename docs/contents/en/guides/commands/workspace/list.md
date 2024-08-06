---
title: Workspace List
tags:
    - workspace
    - list
---

# Workspace List

**Command**: `workspace list`

**Shorthands**: `w l`, `wl`

The `workspace list` command is used to display a list of existing [Workspace][workspace_concept](s). This command helps you view all the workspaces that have been created, along with their status.

You can list all [Workspace][workspace_concept]s, see [`current workspace`][current_workspace_concept] ([`selected workspace`][selected_workspace_concept] and [`active workspace`][active_workspace_concept]) in the list


## Usage
``` {.sh linenums="0" .no-copy}
pars workspace list [flags]
```



??? example

    **Classic usage**
    ```sh
    pars workspace list
    ```
    <div class="result" sh>
    <pre>
    (3) workspace available

    \* OmicronConsulting
    EpsilonEnterprises
    ZetaSystems
    </pre>
    </div>
    
    **Call on selected workspace folder or childs**
    ```sh
    pars workspace list
    ```
    <div class="result" sh>
    <pre>
    (3) workspace available

    \> \* OmicronConsulting
    EpsilonEnterprises
    ZetaSystems
    </pre>
    </div>
    
    **Call on different workspace folder or childs then selected workspace**
    ```sh
    pars workspace list
    ```
    <div class="result" sh>
    <pre>
    (3) workspace available

    \> OmicronConsulting
    \* EpsilonEnterprises
    ZetaSystems
    </pre>
    </div>
    

    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


<!-- Additional links -->
[workspace_concept]: ../../../getting-started/concept/workspace.md
[current_workspace_concept]: ../../../getting-started/concept/workspace.md#current-workspace
[active_workspace_concept]: ../../../getting-started/concept/workspace.md#active-workspace
[selected_workspace_concept]: ../../../getting-started/concept/workspace.md#selected-workspace
[globalflags]: ../index.hmdtml#global-flags
[commonflags]: ../index.md#common-flags