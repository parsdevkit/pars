---
title: Resource Concept
tags:
    - resource
---

# Resource

A **Resource** defines the main structures within a project, outlining the various elements that the project comprises. Unlike Projects, Resources do not have a describe command. Resources can be defined and managed using YAML configuration files. They can be specified globally or within a workspace. Global Resources are accessible throughout the entire application, while workspace-specific Resources are only available within their respective workspaces.

## Key Features of a Resource

- **Project Integration**: Defines the main structures within a project.
- **YAML Configuration**: Resources are defined and managed through YAML files.
- **Scope**: Can be defined globally or within a specific workspace.

### Example YAML Configuration

A typical Resource configuration in YAML might look like this:


```yaml
Type: Resource
Kind: Object
Name: LibraryData
MetaData:
Specifications:
  Name: LibraryData
  Set: EShopping
  Workspace: MyWorks
```




## Creating Resource

To crete a new resource, use the [`resource submit`][resource_submit_command] command:

```sh
pars resource submit --file <file_path>
```


## Listing Resources


To list all available resources, use the [`resource list`][resource_list_command] command:


```sh
pars resource list
```




## Removing Resource

To remove a resource, use the [`resource remove`][resource_remove_command] command:


```sh
pars resource remove <resource_name>
```

## All Resource Types

<div class="grid" markdown>

:fontawesome-brands-html5: [Object Resource][object_resource]
{ .card }

:fontawesome-brands-html5: [Data Resource][data_resource]
{ .card }
</div>




<!-- Additional links -->

[object_resource]: ./object-resource.md
[data_resource]: ./data-resource.md
[resource_command]: ../../guides/commands/resource/index.md
[resource_submit_command]: ../../guides/commands/resource/submit.md
[resource_list_command]: ../../guides/commands/resource/list.md
[resource_describe_command]: ../../guides/commands/resource/describe.md
[resource_remove_command]: ../../guides/commands/resource/remove.md