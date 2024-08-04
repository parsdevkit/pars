---
title: Template Concept
tags:
    - template
---

# Template

A **Template** defines the structure for generating content. It facilitates the automation and simplification of repetitive tasks using tokens to create templates. Similar to Resources, Templates do not have a describe command. Templates can be defined and managed using YAML configuration files. They can be specified globally or within a workspace. Global Templates are accessible throughout the entire application, while workspace-specific Templates are only available within their respective workspaces.

## Key Features of a Template

- **Content Generation**: Defines the structure for generating content.
- **Token Usage**: Automates repetitive tasks using tokens in templates.
- **YAML Configuration**: Templates are defined and managed through YAML files.
- **Scope**: Can be defined globally or within a specific workspace.

### Example YAML Configuration

A typical Template configuration in YAML might look like this:


```yaml
Type: Template
Kind: File
Name: ResponseDto
MetaData:
Specifications:
  Name: LibraryData
  Output: '{{.Resource.Name}}.json'
  Set: EShopping
  Workspace: MyWorks
  Template:
    Content: |
    {
        "name": "{{.Resource.Name}}",
        "description": "This is a data template for {{.Resource.Name}}"
    }
```

## Creating Template

To crete a new template, use the [`template submit`][template_submit_command] command:

```sh
pars template submit --file <file_path>
```


## Listing Templates


To list all available templates, use the [`template list`][template_list_command] command:


```sh
pars template list
```




## Removing Template

To remove a template, use the [`template remove`][template_remove_command] command:


```sh
pars template remove <template_name>
```

## All Template Types

<div class="grid" markdown>

:fontawesome-brands-html5: [Shared Template][shared_template]
{ .card }

:fontawesome-brands-html5: [Code Template][code_template]
{ .card }

:fontawesome-brands-html5: [File Template][file_template]
{ .card }
</div>




<!-- Additional links -->

[shared_template]: ./shared-template.md
[code_template]: ./code-template.md
[file_template]: ./file-template.md
[template_command]: ../../guides/commands/template/index.md
[template_submit_command]: ../../guides/commands/template/submit.md
[template_list_command]: ../../guides/commands/template/list.md
[template_describe_command]: ../../guides/commands/template/describe.md
[template_remove_command]: ../../guides/commands/template/remove.md