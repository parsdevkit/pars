---
title: Command
---

# Command Autocompletion and Filtering

The Pars CLI application supports subcommand autocompletion and filtering to enhance the user experience when working with various commands. This feature allows users to easily navigate and select available subcommands. This feature is available for all main commands that have subcommands.

**Usage Notes**

* The autocompletion and filtering features are designed to improve efficiency and reduce errors when specifying subcommands.
* Ensure that the Pars CLI application is properly configured to support autocompletion (see [Autocompletion Configuration](../../setup/configuration/configuration.md#auto-completion) for setup details).
* These features provide flexibility in navigating and selecting subcommands by filtering based on user input.

By utilizing the subcommand autocompletion and filtering capabilities, users can quickly and accurately specify subcommands, enhancing the overall usability of the Pars CLI application.

## Tab Autocompletion

* When typing a main command, pressing the Tab key will list and autocomplete available subcommands.
* If a partial subcommand name is entered, pressing the Tab key will filter and list matching subcommands.

??? example

    ```sh
    pars workspace <Tab>
    ```
    <div class="result" sh>
    <pre>
    list      describe   remove
    </pre>
    </div>

## Filtering

* As you type, the Pars CLI will filter the subcommands based on the entered characters, showing only the relevant options.
* This feature helps in quickly locating and selecting the desired subcommand without typing the full name.

??? example

    ```sh
    pars workspace de<Tab>
    ```
    <div class="result" sh>
    <pre>
    describe
    </pre>
    </div>


## Notes

To enable autocompletion for the Pars CLI application, ensure that the necessary configuration settings are correctly applied. Autocompletion significantly enhances user experience by allowing easy navigation and selection of commands, flags, and arguments.

* Ensure that the Pars CLI application has the necessary permissions and configurations to support autocompletion.
* For more detailed information and advanced configuration options, refer to the [Autocompletion and Filtering Guide][AutoCompletionAndFilteringGuide]
By configuring subcommand autocompletion, users can quickly and accurately specify subcommands, greatly enhancing the overall usability of the Pars CLI application.


<!-- Additional links -->
[AutoCompletionAndFilteringGuide]: /setup/configuration/configuration.md#auto-completion
