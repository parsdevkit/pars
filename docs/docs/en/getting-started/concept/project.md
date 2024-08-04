---
title: Project Concept
tags:
    - project
---

# Project

A **Project** is positioned within a workspace defined by either a group or a set. It serves as the fundamental unit of work, encompassing various types of development projects such as web APIs, mobile applications, web services, and microservices. Projects can be defined and managed using YAML configuration files.


This structured approach simplifies project management, especially in large-scale applications with multiple interdependent projects. By leveraging the Project concepts, developers can ensure consistency and efficiency in their workflows.

## Key Features of a Project

- **Workspace Integration**: Positioned within a workspace defined by a group or set.
- **Group Integration**: If defined within a group, it resides under the group's path and package.
- **Development Focus**: Represents the core system of work (e.g., software development projects).
- **YAML Configuration**: Projects are defined and managed through YAML files.
- **Command Support**: Includes commands for submit, list, describe, and remove.
- **Project Types**: Supports various project types based on the project's "Kind".


## Project Object Model

Projects can be defined and managed using YAML configuration files. A typical project configuration in YAML might look like this:

```yaml
Type: Project
Kind: Application
Name: NodeShop.ProductService
Metadata:
    Tags: [backend, nodejs]
Specifications:
    Name: ProductService
    Set: NodeShop
    Workspace: MyWorks
```



## Creating Project

To crete a new project, use the [`project submit`][project_submit_command] command:

```sh
pars project submit --file <file_path>
```


## Listing Projects


To list all available projects, use the [`project list`][project_list_command] command:


```sh
pars project list
```


## Project Details

To view details of a specific project, use the [`project describe`][project_describe_command] command:


```sh
pars project describe <project_name>
```


## Removing Project

To remove a project, use the [`project remove`][project_remove_command] command:


```sh
pars project remove <project_name>
```

## All Project Types

<div class="grid" markdown>

:fontawesome-brands-html5: [Application Project][application_project]
{ .card }

</div>




<!-- Additional links -->

[application_project]: ./application-project.md
[project_command]: ../../guides/commands/project/index.md
[project_submit_command]: ../../guides/commands/project/submit.md
[project_list_command]: ../../guides/commands/project/list.md
[project_describe_command]: ../../guides/commands/project/describe.md
[project_remove_command]: ../../guides/commands/project/remove.md