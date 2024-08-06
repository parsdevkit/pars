---
title: Path
---

# Path Autocompletion and Filtering

The Pars CLI application supports path autocompletion and filtering to enhance the user experience when specifying paths. This feature allows users to easily navigate and select files or directories within the current directory or by using absolute paths. This feature is available not only for the `--file` flag but also for other arguments that accept paths as input.

**Usage Notes**

* The autocompletion and filtering features are designed to improve efficiency and reduce errors when specifying paths.
* Ensure that the Pars CLI application has the necessary permissions to access the directories and files being listed.
* These features are available for both relative and absolute paths, providing flexibility in navigating the filesystem.

By utilizing the path autocompletion and filtering capabilities, users can quickly and accurately specify paths, enhancing the overall usability of the Pars CLI application.


## Tab Autocompletion

* When specifying a path, pressing the Tab key will list and autocomplete available files and directories within the current directory.
* If a partial path is entered, pressing the Tab key will filter and list matching files and directories.

??? example

    ``` sh
    pars group new --file <Tab>
    ```
    <div class="result" sh>
    <pre>
    OrionTech.yaml      NeptuneDev.yaml     ApexSolutions.yaml
    </pre>
    </div>



## Filtering

* As you type, the Pars CLI will filter the files and directories based on the entered characters, showing only the relevant options.
* This feature helps in quickly locating and selecting the desired file or directory without typing the full path.

??? example

    ``` sh
    pars group new --file ne<Tab>
    ```
    <div class="result" sh>
    <pre>
    NeptuneDev.yaml
    </pre>
    </div>

## Absolute Path Support

* Users can also enter absolute paths. Pressing the Tab key will list and autocomplete files and directories starting from the specified root.
* This is useful for navigating the entire filesystem and selecting files or directories located in different parts of the system.



??? example
    ``` sh
    pars group new --file C:/samples/<Tab>
    ```
    <div class="result" sh>
    <pre>
    OrionTech.yaml      NeptuneDev.yaml     ApexSolutions.yaml
    </pre>
    </div>



## Notes

To enable autocompletion for the Pars CLI application, ensure that the necessary configuration settings are correctly applied. Autocompletion significantly enhances user experience by allowing easy navigation and selection of commands, flags, and arguments.

* Ensure that the Pars CLI application has the necessary permissions and configurations to support autocompletion.
* For more detailed information and advanced configuration options, refer to the [Autocompletion and Filtering Guide][AutoCompletionAndFilteringGuide]
By configuring subcommand autocompletion, users can quickly and accurately specify paths, greatly enhancing the overall usability of the Pars CLI application.


<!-- Additional links -->
[AutoCompletionAndFilteringGuide]: /setup/configuration/configuration.md#auto-completion
