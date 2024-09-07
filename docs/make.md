## Build and Package with Make

This project provides several `make` commands to streamline the build process and create `.deb` packages.

### Build the Application

```bash
make build
```
This command builds the application.

**Options:**
* **OS** (optional): Specify the target OS. Default is the host machine's OS.
* **ARCH** (optional): Specify the target architecture. Default is the host machine's architecture.


### Create a Debian Binary Package
```bash
make debian-binary-package
```

This command creates a Debian binary package from the project's source code.

**Options:**
* **ARCH** (optional): Specify the target architecture. Default is the host machine's architecture.

### Create a Debian Source PackagePackage
```bash
make debian-source-package
```
This command creates a source .deb package from the project's source code.

### Push the Source Package to PPA
```bash
make debian-source-push-ppa
```

This command pushes the source package to the PPA (Personal Package Archive).


---

This documentation explains how to use the `make` commands for building the application and creating packages. It provides clear instructions on the available options and their default behavior.
