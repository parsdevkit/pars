---
title: Workspace
---

# Workspace Autocompletion and Filtering

The Pars CLI application supports workspace autocompletion and filtering to enhance the user experience when specifying workspace names. This feature allows users to easily navigate and select available workspaces. This feature is available for commands that require workspace names, such as the `--workspace` flag and other relevant arguments.

**Usage Notes**

* The autocompletion and filtering features are designed to improve efficiency and reduce errors when specifying workspaces.
* Ensure that the Pars CLI application has the necessary permissions to access the workspace configurations being listed.
* These features provide flexibility in navigating and selecting workspaces by filtering based on user input.

By utilizing the workspace autocompletion and filtering capabilities, users can quickly and accurately specify workspaces, enhancing the overall usability of the Pars CLI application.

## Tab Autocompletion

* When specifying a workspace, pressing the Tab key will list and autocomplete available workspaces.
* If a partial workspace name is entered, pressing the Tab key will filter and list matching workspaces.

??? example

    ```sh
    pars workspace describe <Tab>
    ```
    <div class="result" sh>
    <pre>
    OmicronConsulting      EpsilonEnterprises     ZetaSystems
    </pre>
    </div>

## Filtering

* As you type, the CLI will filter the workspaces based on the entered characters, showing only the relevant options.
* This feature helps in quickly locating and selecting the desired workspace without typing the full name.

??? example

    ```sh
    pars workspace describe Om<Tab>
    ```
    <div class="result" sh>
    <pre>
    OmicronConsulting
    </pre>
    </div>



## Notes

To enable autocompletion for the Pars CLI application, ensure that the necessary configuration settings are correctly applied. Autocompletion significantly enhances user experience by allowing easy navigation and selection of commands, flags, and arguments.

* Ensure that the Pars CLI application has the necessary permissions and configurations to support autocompletion.
* For more detailed information and advanced configuration options, refer to the [Autocompletion and Filtering Guide][AutoCompletionAndFilteringGuide]
By configuring subcommand autocompletion, users can quickly and accurately specify workspaces, greatly enhancing the overall usability of the Pars CLI application.


<!-- Additional links -->
[AutoCompletionAndFilteringGuide]: /setup/configuration/configuration.md#auto-completion
