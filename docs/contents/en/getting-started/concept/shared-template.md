---
title: Shared Template Concept
tags:
    - template
    - shared
---

# Shared Template


A **Shared Template** can take any context and is used to standardize outputs and manage them from a single point. Shared Templates can be called from any other template.


## Key Features of an Shared Template

- **Context Flexibility**: Can take any context, making it versatile for different types of content.
- **Standardization**: Ensures outputs are standardized and managed from a single point.
- **Reusability**: Can be called from any other template, promoting reusability across projects.

## Shared Template Object Model

Templates can be defined and managed using YAML configuration files. A typical application project configuration in YAML might look like this:

```yaml
Type: Template
Kind: Shared
Name: ResourceNameTemplate
Metadata:
Tags:
Specifications:
  Name: ResourceNameTemplate
  Workspace: CommonWorkspace
  Template:
      Content: |
      // This is a shared template
      // Define your reusable code here
      function exampleFunction() {
          console.log("Hello, World!");
      }
```

For more detailed information on the Shared Template Object Model, refer to the [Shared Template Object Model][shared_template_object_model].



<!-- Additional links -->

[shared_template_object_model]: ../../guides/schemas/object/template/shared-template-object-model.md