---
title: Shared Template Design
---

# Shared Template Design


## Overview

The `Design` component is a crucial part of the template generation process. It defines the structure, layout, and coding conventions that the generated code will follow. This ensures that the generated code is clean, maintainable, and consistent with project standards.


## Purpose

The primary purpose of the `Design` component is to outline the blueprint for the code templates. It provides a standardized framework that guides how the dynamic content will be inserted into the template. This helps in maintaining uniformity across different parts of the codebase and ensures that best practices are followed.


## Structure


## Usage

The `Design` component is used as follows:

1. **Define the Template Structure:** Begin by outlining the overall structure of the template. This includes identifying where dynamic content will be placed and ensuring the layout adheres to coding standards.
2. **Specify Placeholders:** Insert placeholders in the template where dynamic content will be substituted. These placeholders are marked using a specific syntax (e.g., `{{...}}`).
3. **Maintain Coding Conventions:** Ensure that the template follows the project's coding conventions, including naming standards, indentation, and commenting practices.
4. **Integrate with Context Data:** The design relies on context data to fill in the placeholders. This context data is provided during the template generation process and includes details like resource names, attributes, and additional configurations.
5. **Facilitate Reusability and Consistency:** By standardizing the template design, it becomes easier to reuse the template across different projects or parts of the project, ensuring consistency and reducing redundancy.


## Benefits

* **Consistency:** Ensures that all generated code follows the same structure and conventions.
* **Maintainability:** Makes it easier to update and maintain the code by adhering to a standardized template.
* **Efficiency:** Speeds up the development process by providing a ready-made structure that developers can use to quickly generate necessary code components.
* **Quality:** Helps in maintaining a high standard of code quality by embedding best practices within the template design.




## Examples

???+ example


    ```csharp
    using System;
    using System.Collections.Generic;
    {{- range $a := .SectionData.Imports }}
    using {{$a.Package}};
    {{- end }}

    namespace {{.SectionData.Package}}
    {
        public class {{.Resource.Name}}Service
        {
            private readonly IRepository<{{.Resource.Name}}> _repository;

            public {{.Resource.Name}}Service(IRepository<{{.Resource.Name}}> repository)
            {
                _repository = repository;
            }

            public IEnumerable<{{.Resource.Name}}> GetAll()
            {
                return _repository.GetAll();
            }

            public {{.Resource.Name}} GetById(Guid id)
            {
                return _repository.GetById(id);
            }

            public void Create({{.Resource.Name}} entity)
            {
                _repository.Add(entity);
            }

            public void Update({{.Resource.Name}} entity)
            {
                _repository.Update(entity);
            }

            public void Delete(Guid id)
            {
                _repository.Remove(id);
            }
        }
    }
    ```

---
This document provides an overview of the `Design` component, explaining its structure, purpose, usage, and benefits. It serves as a guide for developers to understand the importance of the design in the template generation process and how to effectively utilize it to produce clean, maintainable code.











