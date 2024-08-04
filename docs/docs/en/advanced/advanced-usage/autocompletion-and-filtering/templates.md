---
title: Template
---

# Template Autocompletion and Filtering

The Pars CLI application supports template autocompletion and filtering to enhance the user experience when specifying template names. This feature allows users to easily navigate and select available templates. This feature is available for commands that require template names, such as the `--template` flag and other relevant arguments.

**Usage Notes**

* The autocompletion and filtering features are designed to improve efficiency and reduce errors when specifying templates.
* Ensure that the Pars CLI application has the necessary permissions to access the template configurations being listed.
* These features provide flexibility in navigating and selecting templates by filtering based on user input.

By utilizing the template autocompletion and filtering capabilities, users can quickly and accurately specify templates, enhancing the overall usability of the Pars CLI application.

## Tab Autocompletion

* When specifying a template, pressing the Tab key will list and autocomplete available templates.
* If a partial template name is entered, pressing the Tab key will filter and list matching templates.

??? example

    ```sh
    pars template describe <Tab>
    ```
    <div class="result" sh>
    <pre>
    AlphaTemplate      BetaTemplate     GammaTemplate
    </pre>
    </div>

## Filtering

* As you type, the CLI will filter the templates based on the entered characters, showing only the relevant options.
* This feature helps in quickly locating and selecting the desired template without typing the full name.

??? example

    ```sh
    pars template describe Al<Tab>
    ```
    <div class="result" sh>
    <pre>
    AlphaTemplate
    </pre>
    </div>



## Notes

To enable autocompletion for the Pars CLI application, ensure that the necessary configuration settings are correctly applied. Autocompletion significantly enhances user experience by allowing easy navigation and selection of commands, flags, and arguments.

* Ensure that the Pars CLI application has the necessary permissions and configurations to support autocompletion.
* For more detailed information and advanced configuration options, refer to the [Autocompletion and Filtering Guide][AutoCompletionAndFilteringGuide]
By configuring subcommand autocompletion, users can quickly and accurately specify templates, greatly enhancing the overall usability of the Pars CLI application.


<!-- Additional links -->
[AutoCompletionAndFilteringGuide]: /setup/configuration/configuration.md#auto-completion
