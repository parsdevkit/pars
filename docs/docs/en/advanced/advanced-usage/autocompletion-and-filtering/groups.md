---
title: Group
---

# Group Autocompletion and Filtering

The Pars CLI application supports group autocompletion and filtering to enhance the user experience when specifying group names. This feature allows users to easily navigate and select available groups. This feature is available for commands that require group names, such as the `--group` flag and other relevant arguments.

**Usage Notes**

* The autocompletion and filtering features are designed to improve efficiency and reduce errors when specifying groups.
* Ensure that the Pars CLI application has the necessary permissions to access the group configurations being listed.
* These features provide flexibility in navigating and selecting groups by filtering based on user input.

By utilizing the group autocompletion and filtering capabilities, users can quickly and accurately specify groups, enhancing the overall usability of the Pars CLI application.

## Tab Autocompletion

* When specifying a group, pressing the Tab key will list and autocomplete available groups.
* If a partial group name is entered, pressing the Tab key will filter and list matching groups.

??? example

    ```sh
    pars group remove <Tab>
    ```
    <div class="result" sh>
    <pre>
    AlphaGroup      BetaGroup     GammaGroup
    </pre>
    </div>

## Filtering

* As you type, the CLI will filter the groups based on the entered characters, showing only the relevant options.
* This feature helps in quickly locating and selecting the desired group without typing the full name.

??? example

    ```sh
    pars group remove Al<Tab>
    ```
    <div class="result" sh>
    <pre>
    AlphaGroup
    </pre>
    </div>



## Notes

To enable autocompletion for the Pars CLI application, ensure that the necessary configuration settings are correctly applied. Autocompletion significantly enhances user experience by allowing easy navigation and selection of commands, flags, and arguments.

* Ensure that the Pars CLI application has the necessary permissions and configurations to support autocompletion.
* For more detailed information and advanced configuration options, refer to the [Autocompletion and Filtering Guide][AutoCompletionAndFilteringGuide]
By configuring subcommand autocompletion, users can quickly and accurately specify groups, greatly enhancing the overall usability of the Pars CLI application.


<!-- Additional links -->
[AutoCompletionAndFilteringGuide]: /setup/configuration/configuration.md#auto-completion
