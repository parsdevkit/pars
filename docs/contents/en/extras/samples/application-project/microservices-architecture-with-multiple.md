---
title: Microservices Architecture with Multiple Projects
hide:
- navigation
---

# Microservices Architecture with Multiple Projects

This guide provides a step-by-step example of setting up a microservices architecture with multiple interconnected projects. It includes the necessary configurations for platform, runtime, language, and dependencies.


```yaml
# Project 1: User Service (Dotnet WebAPI)
type: Project
kind: Application
name: Example.ServiceA
metadata:
  tags: [backend, dotnet, serviceA]
specifications:
  name: ServiceA
  platform:
    type: Dotnet
    version: 6
  runtime:
    type: Dotnet
    version: 6
  language:
    type: CSharp
    version: 9
  project_type: webapi
  package: com.example.serviceA
  path: /services/serviceA
  configuration:
    layers:
    - name: Controllers
      path: controllers
      package: com.example.serviceA.controllers
    - name: Services
      path: services
      package: com.example.serviceA.services
    dependencies:
    - name: Microsoft.EntityFrameworkCore
      version: 5.0.0
    - name: Microsoft.AspNetCore.Mvc
      version: 2.2.0


---
# Project 2: Product Service (NodeJS Microservice)
type: Project
kind: Application
name: Example.ServiceB
metadata:
  tags: [backend, nodejs, serviceB]
specifications:
  name: ServiceB
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
  package: com.example.serviceB
  path: /services/serviceB
  configuration:
    layers:
    - name: Controllers
      path: controllers
      package: com.example.serviceB.controllers
    - name: Services
      path: services
      package: com.example.serviceB.services
    dependencies:
    - name: express
      version: 4.17.1
    - name: mongoose
      version: 5.10.9

---
# Project 3: Order Service (Go Lang Backend Service)
type: Project
kind: Application
name: Example.ServiceC
metadata:
  tags: [backend, golang, serviceC]
specifications:
  name: ServiceC
  platform:
    type: Go
    version: 1.16
  runtime:
    type: Go
    version: 1.16
  language:
    type: Go
    version: 1.16
  project_type: webapi
  package: com.example.serviceC
  path: /services/serviceC
  configuration:
    layers:
    - name: Handlers
      path: handlers
      package: com.example.serviceC.handlers
    - name: Services
      path: services
      package: com.example.serviceC.services
    dependencies:
    - name: github.com/gin-gonic/gin
      version: 1.7.2
    - name: github.com/jinzhu


```


## Key Sections Explained

**Project 1: User Service (Dotnet WebAPI)**

- **type**: The type of the project. Always set to `Project`.
- **kind**: The kind of the project. Should be `Application`.
- **name**: A unique identifier for your project.
- **metadata**: Additional information about your project. Here, tags like `backend`, `dotnet`, and `microservice` are used.
- **specifications**: Detailed configuration of your project.
    - **name**: The name of the project instance.
    - **platform**: Specifies the platform type and version. Here, `Dotnet` version 6 is used.
    - **runtime**: Specifies the runtime environment. Here, `Dotnet` version 6 is used.
    - **language**: Specifies the programming language and version. Here, `CSharp` version 9 is used.
    - **project_type**: The type of the project. Here, it is a `webapi`.
    - **package**: The package or namespace for the project.
    - **path**: The relative path where the project will be located.
    - **configuration**: Configuration details for the project.
        - **layers**: Defines the directory and package structure.
        - **dependencies**: Lists the external dependencies, such as NuGet packages.


**Project 2: Product Service (NodeJS Microservice)**

- **type**: The type of the project. Always set to `Project`.
- **kind**: The kind of the project. Should be `Application`.
- **name**: A unique identifier for your project.
- **metadata**: Additional information about your project. Here, tags like `backend`, `nodejs`, and `microservice` are used.
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


**Project 3: Order Service (Go Lang Backend Service)**

- **type**: The type of the project. Always set to `Project`.
- **kind**: The kind of the project. Should be `Application`.
- **name**: A unique identifier for your project.
- **metadata**: Additional information about your project. Here, tags like `backend`, `go`, and `microservice` are used.
- **specifications**: Detailed configuration of your project.
    - **name**: The name of the project instance.
    - **platform**: Specifies the platform type and version. Here, `Go` version 1.16 is used.
    - **runtime**: Specifies the runtime environment. Here, `Go` version 1.16 is used.
    - **language**: Specifies the programming language and version. Here, `Go` version 1.16 is used.
    - **project_type**: The type of the project. Here, it is a `webapi`.
    - **package**: The package or namespace for the project.
    - **path**: The relative path where the project will be located.
    - **configuration**: Configuration details for the project.
        - **layers**: Defines the directory and package structure.
        - **dependencies**: Lists the external dependencies, such as Go modules.



## Detailed Steps

**Project 1: User Service (Dotnet WebAPI)**

1. **Set Project Type and Kind**:
      - Ensure `type` is `Project` and `kind` is `Application`.

2. **Provide Unique Name**:
      - Set a unique name for the project under `name` (e.g., `UserService`).

3. **Add Metadata Tags**:
      - Use `metadata` to add tags like `backend`, `dotnet`, and `microservice`.

4. **Define Specifications**:
      - **name**: The name of the project instance (e.g., `UserService`).
      - **platform**: Specify the platform type and version (e.g., `Dotnet` version 6).
      - **runtime**: Specify the runtime environment (e.g., `Dotnet` version 6).
      - **language**: Specify the programming language and version (e.g., `CSharp` version 9).
      - **project_type**: Define the type of the project (e.g., `webapi`).
      - **package**: Define the package or namespace for the project (e.g., `com.example.microservices.userservice`).
      - **path**: Specify the relative path where the project will be located (e.g., `/services/userservice`).

5. **Configure Layers**:
      - Define layers for organizing the project's directory and package structure.
      - Example layers:
          - Controllers: Manages HTTP requests.
          - Services: Contains business logic.

6. **Specify Dependencies**:
      - List external dependencies using NuGet packages.
      - Example dependencies:
          - `Microsoft.EntityFrameworkCore` version 5.0.0
          - `Microsoft.AspNetCore.Mvc` version 2.2.0


**Project 2: Product Service (NodeJS Microservice)**

1. **Set Project Type and Kind**:
      - Ensure `type` is `Project` and `kind` is `Application`.

2. **Provide Unique Name**:
      - Set a unique name for the project under `name` (e.g., `ProductService`).

3. **Add Metadata Tags**:
      - Use `metadata` to add tags like `backend`, `nodejs`, and `microservice`.

4. **Define Specifications**:
      - **name**: The name of the project instance (e.g., `ProductService`).
      - **platform**: Specify the platform type and version (e.g., `NodeJS` version 14).
      - **runtime**: Specify the runtime environment (e.g., `NodeJS` version 14).
      - **language**: Specify the programming language and version (e.g., `JavaScript` version ES6).
      - **project_type**: Define the type of the project (e.g., `webapi`).
      - **package**: Define the package or namespace for the project (e.g., `com.example.microservices.productservice`).
      - **path**: Specify the relative path where the project will be located (e.g., `/services/productservice`).

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


**Project 3: Order Service (Go Lang Backend Service)**

1. **Set Project Type and Kind**:
      - Ensure `type` is `Project` and `kind` is `Application`.

2. **Provide Unique Name**:
      - Set a unique name for the project under `name` (e.g., `OrderService`).

3. **Add Metadata Tags**:
      - Use `metadata` to add tags like `backend`, `go`, and `microservice`.

4. **Define Specifications**:
      - **name**: The name of the project instance (e.g., `OrderService`).
      - **platform**: Specify the platform type and version (e.g., `Go` version 1.16).
      - **runtime**: Specify the runtime environment (e.g., `Go` version 1.16).
      - **language**: Specify the programming language and version (e.g., `Go` version 1.16).
      - **project_type**: Define the type of the project (e.g., `webapi`).
      - **package**: Define the package or namespace for the project (e.g., `com.example.microservices.orderservice`).
      - **path**: Specify the relative path where the project will be located (e.g., `/services/orderservice`).

5. **Configure Layers**:
      - Define layers for organizing the project's directory and package structure.
      - Example layers:
          - Controllers: Manages HTTP requests.
          - Services: Contains business logic.

6. **Specify Dependencies**:
      - List external dependencies using Go modules.
      - Example dependencies:
          - `github.com/gorilla/mux` version v1.8.0
          - `github.com/jinzhu/gorm` version v1.9.16


---

This example shows how to configure a microservice project consist of Dotnet WebAPI, NodeJS and Go Lang backend projects for the Services by different platforms with the necessary settings for platform, runtime, language, layers, and dependencies. Follow these steps and use the YAML structure provided to create a fully functional Dotnet WebAPI project for the User Service.

By following this guide, you will have a clear understanding of how to set up a microservice project with the required configurations. This serves as a foundation for more advanced configurations and customizations.

