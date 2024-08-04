---
title: Enumeration
---

# Enumeration Autocompletion and Filtering

The Pars CLI application supports enumeration completion for arguments and flags that accept predefined (enum) values. This feature provides suggestions and filtering for these parameters, enhancing user experience and reducing errors.

**Usage Notes**

* The enumeration completion feature is designed to improve efficiency and reduce errors when specifying parameters with predefined values.
* Ensure that the Pars CLI application has access to the necessary enumeration definitions to provide accurate suggestions.
* These features are available for both arguments and flags, providing flexibility in specifying predefined values.


By utilizing the path autocompletion and filtering capabilities, users can quickly and accurately specify paths, enhancing the overall usability of the Pars CLI application.


## Tab Autocompletion

* When specifying an argument or flag with predefined values, pressing the Tab key will list and autocomplete the available options.
* If a partial value is entered, pressing the Tab key will filter and list matching options.

E

    ``` sh
    pars workspace describe --view <Tab>
    ```
    <div class="result" sh>
    <pre>
    flat          hierarchical
    </pre>
    </div>



## Filtering

* As you type, the Pars CLI will filter the predefined values based on the entered characters, showing only the relevant options.
* This helps in quickly locating and selecting the desired value without typing the full option.

??? example

    ``` sh
    pars workspace describe --view h<Tab>
    ```
    <div class="result" sh>
    <pre>
    hierarchical
    </pre>
    </div>


## Notes

To enable autocompletion for the Pars CLI application, ensure that the necessary configuration settings are correctly applied. Autocompletion significantly enhances user experience by allowing easy navigation and selection of commands, flags, and arguments.

* Ensure that the Pars CLI application has the necessary permissions and configurations to support autocompletion.
* For more detailed information and advanced configuration options, refer to the [Autocompletion and Filtering Guide][AutoCompletionAndFilteringGuide]
By configuring subcommand autocompletion, users can quickly and accurately specify paths, greatly enhancing the overall usability of the Pars CLI application.


<!-- Additional links -->
[AutoCompletionAndFilteringGuide]: /setup/configuration/configuration.md#auto-completion
