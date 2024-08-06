---
title: Group Concept
tags:
    - group
---

# Group

A **Group** is a framework used to collectively manage multiple projects. It organizes the relationships and dependencies among these projects, providing a unified and efficient management system. By grouping projects together, it simplifies processes such as building, testing, and deploying, ensuring that all projects within the group are consistently handled.



## Key Features of a Group

- **Unified Management**: Manage multiple projects together under a single entity.
- **Collective Operations**: Perform operations like build, test, and remove on all projects within a Group simultaneously.
- **Organized Structure**: Projects within a Group are organized under a common directory path and package name.



## Group Object Model

Groups can be defined and managed using YAML configuration files. This allows for easy setup and modification of Group details. A typical Group configuration in YAML might look like this:

```yaml
Type: Group
Name: UserManagementGroup
Metadata:
  Tags: [backend, user-management]
Specifications:
  Name: UserManagement
  Path: src/user_management
  Package: [com, example, user]
```


For more detailed information on the Group Object Model, refer to the [Group Object Model][group_object_model].

## Creating Group

To initialize a new group, use the [`group submit`][group_submit_command] command:

```sh
pars group submit --file <file_path>
```


## Listing Groups


To list all available groups, use the [`group list`][group_list_command] command:


```sh
pars group list
```


## Group Details

To view details of a specific group, use the [`group describe`][group_describe_command] command:


```sh
pars group describe <group_name>
```


## Removing Group

To remove a group, use the [`group remove`][group_remove_command] command:


```sh
pars group remove <group_name>
```

## Grouping Projects

Projects within a Group can be collectively processed using the Group name. For example, under the "ProductService" Group, projects like `ProductApi` and `ProductCore` can be deleted, built, and tested simultaneously using the Group name. These projects can reside within the Group's directory path and be grouped under the Group's package name.

## Usage

When a project is within a Group, the project access ID is used in the format `groupname\projectname`. If you want to build all projects within a Group, you can use the following command:


```bash
pars build "groupname\"
```

```bash
pars project remove "groupname\"
```

<!-- Additional links -->

[group_object_model]: ../../guides/schemas/object/group/group-object-model.md
[group_command]: ../../guides/commands/group/index.md
[group_submit_command]: ../../guides/commands/group/submit.md
[group_list_command]: ../../guides/commands/group/list.md
[group_describe_command]: ../../guides/commands/group/describe.md
[group_remove_command]: ../../guides/commands/group/remove.md