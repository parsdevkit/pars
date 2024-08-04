# Pars <!-- omit in toc -->
[![Build Pars On Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new/?repo=github)
<img align="right" src="./artwork/logo-only.svg" height="150px" style="padding-left: 20px"/>

[![Scala Steward badge](https://img.shields.io/badge/Scala_Steward-helping-blue.svg?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAQCAMAAAARSr4IAAAAVFBMVEUAAACHjojlOy5NWlrKzcYRKjGFjIbp293YycuLa3pYY2LSqql4f3pCUFTgSjNodYRmcXUsPD/NTTbjRS+2jomhgnzNc223cGvZS0HaSD0XLjbaSjElhIr+AAAAAXRSTlMAQObYZgAAAHlJREFUCNdNyosOwyAIhWHAQS1Vt7a77/3fcxxdmv0xwmckutAR1nkm4ggbyEcg/wWmlGLDAA3oL50xi6fk5ffZ3E2E3QfZDCcCN2YtbEWZt+Drc6u6rlqv7Uk0LdKqqr5rk2UCRXOk0vmQKGfc94nOJyQjouF9H/wCc9gECEYfONoAAAAASUVORK5CYII=)](https://scala-steward.org)
[![License](https://img.shields.io/github/license/eikek/docspell.svg?style=for-the-badge&color=steelblue)](https://github.com/eikek/docspell/blob/master/LICENSE.txt)
[![Docker Pulls](https://img.shields.io/docker/pulls/docspell/restserver?color=steelblue&style=for-the-badge&logo=docker)](https://hub.docker.com/u/docspell)
[![Gitter chat](https://img.shields.io/gitter/room/eikek/docspell?style=for-the-badge&color=steelblue&logo=gitter)](https://gitter.im/eikek/docspell)

<p align="center">
  <a href="https://twitter.com/docusaurus"><img src="https://img.shields.io/twitter/follow/docusaurus.svg?style=social" align="right" alt="Twitter Follow" /></a>
  <a href="#backers" alt="sponsors on Open Collective"><img src="https://opencollective.com/Docusaurus/backers/badge.svg" /></a>
  <a href="#sponsors" alt="Sponsors on Open Collective"><img src="https://opencollective.com/Docusaurus/sponsors/badge.svg" /></a>
  <a href="https://www.npmjs.com/package/@docusaurus/core"><img src="https://img.shields.io/npm/v/@docusaurus/core.svg?style=flat" alt="npm version"></a>
  <a href="https://github.com/facebook/docusaurus/actions/workflows/tests.yml"><img src="https://github.com/facebook/docusaurus/actions/workflows/tests.yml/badge.svg" alt="GitHub Actions status"></a>
  <a href="CONTRIBUTING.md#pull-requests"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs Welcome"></a>
  <a href="https://discord.gg/docusaurus"><img src="https://img.shields.io/discord/102860784329052160.svg" align="right" alt="Discord Chat" /></a>
  <a href= "https://github.com/prettier/prettier"><img alt="code style: prettier" src="https://img.shields.io/badge/code_style-prettier-ff69b4.svg"></a>
  <a href="#license"><img src="https://img.shields.io/github/license/sourcerer-io/hall-of-fame.svg?colorB=ff0000"></a>
  <a href="https://github.com/facebook/jest"><img src="https://img.shields.io/badge/tested_with-jest-99424f.svg" alt="Tested with Jest"></a>
  <a href="https://argos-ci.com" target="_blank" rel="noreferrer noopener" aria-label="Covered by Argos"><img src="https://argos-ci.com/badge.svg" alt="Covered by Argos" width="133" height="20" /></a>
  <a href="https://gitpod.io/#https://github.com/facebook/docusaurus"><img src="https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod" alt="Gitpod Ready-to-Code"/></a>
  <a href="https://app.netlify.com/sites/docusaurus-2/deploys"><img src="https://api.netlify.com/api/v1/badges/9e1ff559-4405-4ebe-8718-5e21c0774bc8/deploy-status" alt="Netlify Status"></a>
  <a href="https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Ffacebook%2Fdocusaurus%2Ftree%2Fmain%2Fexamples%2Fclassic&project-name=my-docusaurus-site&repo-name=my-docusaurus-site"><img src="https://vercel.com/button" alt="Deploy with Vercel"/></a>
  <a href="https://app.netlify.com/start/deploy?repository=https://github.com/slorber/docusaurus-starter"><img src="https://www.netlify.com/img/deploy/button.svg" alt="Deploy to Netlify"></a>
</p>

# Pars Guide to Documentation

See this project on
[readthedocs.org](http://docs-guide.readthedocs.org/en/latest/) or read
* [user guide md](docs/index.md)
* [maintainer guide md](docs/index.md)
* [contrubitor guide md](docs/index.md)


## Getting Started

- [Pars Guide to Documentation](#pars-guide-to-documentation)
  - [Getting Started](#getting-started)
  - [Introduction](#introduction)
  - [Languages](#languages)
  - [Features](#features)
  - [Future Features](#future-features)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Installing binaries](#installing-binaries)
    - [Linux](#linux)
    - [Windows](#windows)
    - [MacOS](#macos)
  - [Docker](#docker)
  - [Building from Source](#building-from-source)
  - [Configuration](#configuration)
  - [Backup](#backup)
  - [Restore](#restore)
  - [Upgrade](#upgrade)
  - [Uninstall](#uninstall)
  - [Quickstart](#quickstart)
    - [Temel Komutlar](#temel-komutlar)
    - [Örnek Senaryo](#örnek-senaryo)
  - [Documentation](#documentation)
  - [Releases](#releases)
  - [Currently Supported Platforms](#currently-supported-platforms)
  - [Contributing](#contributing)
  - [READMEs](#readmes)
  - [Reporting Issues - Help](#reporting-issues---help)
    - [Bugs](#bugs)
    - [Feature Requests](#feature-requests)
    - [Questions](#questions)
  - [Engage with us](#engage-with-us)
    - [Share your story](#share-your-story)
    - [Subscribe for Updates](#subscribe-for-updates)
  - [History](#history)
  - [License](#license)
  - [Community](#community)
  - [Contact](#contact)
  - [Thanks :purple\_heart:](#thanks-purple_heart)
  - [Contributors](#contributors)
  - [Backers](#backers)
  - [Support](#support)
  - [Sponsors](#sponsors)



**Pars**, geliştiricilerin günlük görevlerini daha verimli bir şekilde yapmalarına yardımcı olmak için tasarlanmış açık kaynaklı bir komut satırı aracıdır. Pars, çeşitli otomasyon, veri işleme ve sistem yönetimi görevlerini basitleştirir.

Bu belge, `pars` komut satırı uygulamasının (CLI) kullanımını açıklar. `pars`, geliştirici araçları, proje modelleme, kod generation ve diğer yardımcı çözümler ile ilgili çeşitli işlemleri gerçekleştirmek için kullanılan bir araçtır.

**İçerik:**

1. **Giriş:**
    - `pars` nedir?
    - Neden `pars` kullanmalısınız?
    - `pars` Özellikleri
2. **Kurulum:**
    - `pars` nasıl kurulur?
3. **Kullanım:**
    - Temel Kullanım
    - Komutlar
        - `init`
        - `workspace`
        - `project`
    - Seçenekler
        - Küresel Seçenekler
        - Komut Seçenekleri
4. **Örnekler:**
    - Basit bir çalışma alanını tanımlama
    - Tüm çalışma alanlarını listeleme
    - Bir çalışma alanını kaldırma
5. **Yardım ve Destek:**
    - Yardım alma
    - Hata bildirimi
6. **Ek:**
    - Lisans
    - Katkıda Bulunma

## Introduction

## Languages

You can see in which language an app is written. Currently there are following languages:

- ![c_icon] - C language.
- ![cpp_icon] - C++ language.
- ![c_sharp_icon] - C# language.
- ![clojure_icon] - Clojure language.
- ![coffee_script_icon] - CoffeeScript language.
- ![css_icon] - CSS language.
- ![go_icon] - Go language.
- ![elm_icon] - Elm language.
- ![haskell_icon] - Haskell language.
- ![javascript_icon] - JavaScript language.
- ![lua_icon] - Lua language.
- ![objective_c_icon] - Objective-C language.
- ![python_icon] - Python language.
- ![ruby_icon] - Ruby language.
- ![rust_icon] - Rust language.
- ![shell_icon] - Shell language.
- ![swift_icon] - Swift language.
- ![typescript_icon] - TypeScript language.
- 
## Features

- Kolay kurulum ve yapılandırma
- Esnek ve genişletilebilir komut seti
- Yüksek performanslı veri işleme
- Çoklu platform desteği (Windows, macOS, Linux)

## Future Features

## Requirements

## Installation

## Installing binaries
### Linux
### Windows
* Download Source Code
* Installer
* Choco
* WGet
### MacOS
## Docker
## Building from Source
## Configuration
## Backup
## Restore
## Upgrade
## Uninstall

## Quickstart

### Temel Komutlar

- **Yardım Komutu:**
    ```sh
    mycli --help
    ```

- **Versiyon Bilgisi:**
    ```sh
    mycli --version
    ```

- **Örnek Komut:**
    ```sh
    mycli run --task example
    ```

### Örnek Senaryo

Aşağıda, MyCLI'nin kullanımıyla ilgili basit bir senaryo bulunmaktadır:

```sh
# Dosyaları listeleme
mycli list --directory /path/to/directory

# Veri dosyasını işleme
mycli process --input data.csv --output results.json
```

## Documentation
 * [OpenKM Knowledge Center](https://docs.openkm.com/kcenter/view/okm-6.3-com/)
 * [Hardware and software requirements](https://docs.openkm.com/kcenter/view/okm-6.3-com/hardware-and-software-requirements.html)
 * [Installation](https://docs.openkm.com/kcenter/view/okm-6.3-com/installation.html)
 * [Using the installer](https://docs.openkm.com/kcenter/view/okm-6.3-com/using-the-installer.html)
 * [Troubleshooting](https://docs.openkm.com/kcenter/view/okm-6.3-com/troubleshooting.html)
 * [Administration guide](https://docs.openkm.com/kcenter/view/okm-6.3-com/administration-guide.html)
 * [User guide](https://docs.openkm.com/kcenter/view/okm-6.3-com/user-guide.html)
 * [Migration guide](https://docs.openkm.com/kcenter/view/okm-6.3-com/migration-guide.html)
 * [Development guide](https://docs.openkm.com/kcenter/view/okm-6.3-com/development.html)
 * [Known issues, limitations, troubleshooting, FAQ](https://docs.openkm.com/kcenter/view/okm-6.3-com/development.html)
 * [Translation](https://docs.openkm.com/kcenter/view/okm-6.3-com/development.html)

- [Changelog](https://github.com/will-stone/browserosaurus/releases)
- [Help](https://github.com/will-stone/browserosaurus/discussions/categories/q-a)
- [Supporting a new browser or app](guide/supporting-a-browser-or-app.md)
- [Setting up for development](guide/setting-up-for-development.md)
- [Privacy policy](guide/privacy.md)

## Releases
 - [Version 1.1](https://github.com/nbolar/PlayStatus/setup/tag/v1.1)  - 2014-07-06: Added the option to enable/disable automatic updates occurring once a week
 - [Version 1.0](https://github.com/nbolar/PlayStatus/setup/tag/v1.0) - 2013-09-15: Added automatic upgrade capability.

## Currently Supported Platforms
* Dotnet
* Nodejs
* Angular

## Contributing

MyCLI açık kaynaklı bir projedir ve katkılarınızı beklemektedir! Katkıda bulunmak için şu adımları izleyebilirsiniz:

1. **Projeyi Forklayın:**
    ```sh
    git fork https://github.com/kullaniciadi/MyCLI.git
    ```

2. **Yeni Bir Dal Oluşturun:**
    ```sh
    git checkout -b yeni-ozellik
    ```

3. **Değişikliklerinizi Yapın ve Commitleyin:**
    ```sh
    git commit -am 'Yeni özelliği ekle'
    ```

4. **Değişiklikleri Push Edin:**
    ```sh
    git push origin yeni-ozellik
    ```

5. **Pull Request Oluşturun:**
    GitHub üzerinde, ana depoya değişikliklerinizi içeren bir Pull Request oluşturun.




## READMEs

In addition to the README you're reading right now, this repo includes other READMEs that describe the purpose of each subdirectory in more detail:

- [content/README.md](content/README.md)
- [content/graphql/README.md](content/graphql/README.md)
- [content/rest/README.md](content/rest/README.md)
- [contributing/README.md](contributing/README.md)
- [data/README.md](data/README.md)
- [data/reusables/README.md](data/reusables/README.md)
- [data/variables/README.md](data/variables/README.md)
- [src/README.md](src/README.md)


## Reporting Issues - Help
OpenKM Open Source Community Edition is supported by developers and technical enthusiasts via [the forum](http://forum.openkm.com) of the user community. If you want to raise an issue, please follow the below recommendations:
 * Before you post a question, please search the question to see if someone has already reported it / asked for it.
 * If the question does not already exist, create a new post.
 * Please provide as much detailed information as possible with the issue report. We need to know the version of OpenKM, Operating System, browser and whatever you think might help us to understand the problem or question.

### Bugs

Please file an issue for bugs, missing documentation, or unexpected behavior.

[**See Bugs**](https://github.com/johnste/finicky/issues?q=is%3aopen+is%3aissue+label%3abug)

### Feature Requests

Please file an issue to suggest new features. Vote on feature requests by adding
a 👍.

[**See Feature Requests**](https://github.com/johnste/finicky/labels/feature%20request)

### Questions

Have any other questions or need help? Please feel free to reach out to me on [Mastodon](https://mastodon.se/@john) or [Twitter](https://twitter.com/johnste_).


## Engage with us

### Share your story
We’d love to hear about [your experience][] and potentially feature it on our
[Blog][].

### Subscribe for Updates
Once a month our marketing team releases an email update with news about product
releases, company related topics, events and use cases. [Sign Up!][]


## History

This program was developed originally by Mauricio Piacentini
([@piacentini](https://github.com/piacentini)) from Tabuleiro Producoes as
the Arca Database Browser. The original version was used as a free companion
tool to the Arca Database Xtra, a commercial product that embeds SQLite
databases with some additional extensions to handle compressed and binary data.

The original code was trimmed and adjusted to be compatible with standard
SQLite 2.x databases. The resulting program was renamed SQLite Database
Browser, and released into the Public Domain by Mauricio. Icons were
contributed by [Raquel Ravanini](http://www.raquelravanini.com), also from
Tabuleiro. Jens Miltner ([@jmiltner](https://github.com/jmiltner)) contributed
the code to support SQLite 3.x databases for the 1.2 release.



## License

The GitHub product documentation in the assets, content, and data folders are licensed under a [CC-BY license](LICENSE).

All other code in this repository is licensed under the [MIT license](LICENSE-CODE).

When using the GitHub logos, be sure to follow the [GitHub logo guidelines](https://github.com/logos).

## Community
## Contact

We have a few channels for contact:

- [Discord](https://discord.gg/docusaurus):
  - `#general` for those using Docusaurus.
  - `#contributors` for those wanting to contribute to the Docusaurus core.
- [@docusaurus](https://twitter.com/docusaurus) on Twitter
- [GitHub Issues](https://github.com/facebook/docusaurus/issues)
* Stackoverflow
* Youtube


## Thanks :purple_heart:

Thanks for all your contributions and efforts towards improving the GitHub documentation. We thank you for being part of our :sparkles: community :sparkles:!



## Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)]. <a href="https://github.com/facebook/docusaurus/graphs/contributors"><img src="https://opencollective.com/Docusaurus/contributors.svg?width=890&button=false" /></a>

## Backers

Thank you to all our backers! 🙏 [Become a backer](https://opencollective.com/Docusaurus#backer)

<a href="https://opencollective.com/Docusaurus#backers" target="_blank"><img src="https://opencollective.com/Docusaurus/backers.svg?width=890"></a>

## Support

Hey friend! Help me out for a couple of :beers:!  <span class="badge-patreon"><a href="https://www.patreon.com/serhiilondar" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>

## Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website. [Become a sponsor](https://opencollective.com/Docusaurus#sponsor)

<a href="https://opencollective.com/Docusaurus/sponsor/0/website" target="_blank"><img src="https://opencollective.com/Docusaurus/sponsor/0/avatar.svg"></a> <a href="https://opencollective.com/Docusaurus/sponsor/1/website" target="_blank"><img src="https://opencollective.com/Docusaurus/sponsor/1/avatar.svg"></a>

---
references
* readmes
  - https://github.com/github/docs/tree/main
  - https://github.com/firstcontributions/first-contributions
  - https://github.com/serhii-londar/open-source-mac-os-apps  #Graphics
  - https://github.com/bevyengine/bevy
  - https://github.com/nextcloud/server
  - https://github.com/swagger-api/swagger-ui
  - https://github.com/NvChad/NvChad
  - https://github.com/luong-komorebi/Awesome-Linux-Software?tab=readme-ov-file
  - https://github.com/bevyengine/bevy


* https://docs.nextcloud.com/server/latest/developer_manual/



* installation
  * https://github.com/sqlitebrowser/sqlitebrowser
* releases
  * https://github.com/jeromelebel/MongoHub-Mac
* features
  * https://github.com/pbek/QOwnNotes
* CLI samples
  * https://www.mkdocs.org/user-guide/cli/
  * https://classic.yarnpkg.com/en/docs/cli/