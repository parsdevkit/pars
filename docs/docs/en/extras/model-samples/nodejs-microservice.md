---
title: NodeJS Microservice Project
hide:
- navigation
---

# NodeJS Microservice Project


This guide provides a step-by-step example of creating a basic NodeJS microservice project. It includes the necessary configurations for platform, runtime, language, and dependencies.





```yaml
type: Project
kind: Application
name: Example.NodeJSMicroservice
metadata:
  tags: [backend, nodejs]
specifications:
  name: NodeJSMicroservice
  platform:
    type: NodeJS
    version: 14
  runtime:
    type: NodeJS
    version: 14
  language:
    type: JavaScript
    version: ES6
  project_type: webapi
  package: com.example.nodejsmicroservice
  path: /services/nodejsmicroservice
  configuration:
    layers:
    - name: Controllers
      path: controllers
      package: com.example.nodejsmicroservice.controllers
    - name: Services
      path: services
      package: com.example.nodejsmicroservice.services
    dependencies:
    - name: express
      version: 4.17.1
    - name: mongoose
      version: 5.10.9
```


## Key Sections Explained

- **type**: The type of the project. Always set to `Project`.
- **kind**: The kind of the project. Should be `Application`.
- **name**: A unique identifier for your project.
- **metadata**: Additional information about your project. Here, tags like `backend` and `nodejs` are used.
- **specifications**: Detailed configuration of your project.
    - **name**: The name of the project instance.
    - **platform**: Specifies the platform type and version. Here, `NodeJS` version 14 is used.
    - **runtime**: Specifies the runtime environment. Here, `NodeJS` version 14 is used.
    - **language**: Specifies the programming language and version. Here, `JavaScript` version ES6 is used.
    - **project_type**: The type of the project. Here, it is a `webapi`.
    - **package**: The package or namespace for the project.
    - **path**: The relative path where the project will be located.
    - **configuration**: Configuration details for the project.
        - **layers**: Defines the directory and package structure.
        - **dependencies**: Lists the external dependencies, such as NPM packages.



## Detailed Steps
1. **Set Project Type and Kind**:
      - Ensure `type` is `Project` and `kind` is `Application`.

2. **Provide Unique Name**:
      - Set a unique name for the project under `name` (e.g., `Example.NodeJSMicroservice`).

3. **Add Metadata Tags**:
      - Use `metadata` to add tags like `backend` and `nodejs`.

4. **Define Specifications**:
      - **name**: The name of the project instance (e.g., `NodeJSMicroservice`).
      - **platform**: Specify the platform type and version (e.g., `NodeJS` version 14).
      - **runtime**: Specify the runtime environment (e.g., `NodeJS` version 14).
      - **language**: Specify the programming language and version (e.g., `JavaScript` version ES6).
      - **project_type**: Define the type of the project (e.g., `webapi`).
      - **package**: Define the package or namespace for the project (e.g., `com.example.nodejsmicroservice`).
      - **path**: Specify the relative path where the project will be located (e.g., `/services/nodejsmicroservice`).

5. **Configure Layers**:
      - Define layers for organizing the project's directory and package structure.
      - Example layers:
          - Controllers: Manages HTTP requests.
          - Services: Contains business logic.

6. **Specify Dependencies**:
      - List external dependencies using NPM packages.
      - Example dependencies:
          - `express` version 4.17.1
          - `mongoose` version 5.10.9



--- 
This example shows how to configure a basic NodeJS microservice project with the necessary settings for platform, runtime, language, layers, and dependencies. Follow these steps and use the YAML structure provided to create a fully functional NodeJS microservice project.

By following this guide, you will have a clear understanding of how to set up a basic NodeJS microservice project with the required configurations. This serves as a foundation for more advanced configurations and customizations.
