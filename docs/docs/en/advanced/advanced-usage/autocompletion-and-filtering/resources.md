---
title: Resource
---

# Resource Autocompletion and Filtering

The Pars CLI application supports resource autocompletion and filtering to enhance the user experience when specifying resource names. This feature allows users to easily navigate and select available resources. This feature is available for commands that require resource names, such as the `--resource` flag and other relevant arguments.

**Usage Notes**

* The autocompletion and filtering features are designed to improve efficiency and reduce errors when specifying resources.
* Ensure that the Pars CLI application has the necessary permissions to access the resource configurations being listed.
* These features provide flexibility in navigating and selecting resources by filtering based on user input.

By utilizing the resource autocompletion and filtering capabilities, users can quickly and accurately specify resources, enhancing the overall usability of the Pars CLI application.

## Tab Autocompletion

* When specifying a resource, pressing the Tab key will list and autocomplete available resources.
* If a partial resource name is entered, pressing the Tab key will filter and list matching resources.

??? example

    ```sh
    pars resource remove <Tab>
    ```
    <div class="result" sh>
    <pre>
    ProductCategory_SeedData      ProductBrand_SeedData     Product_SeedData
    </pre>
    </div>

## Filtering

* As you type, the CLI will filter the resources based on the entered characters, showing only the relevant options.
* This feature helps in quickly locating and selecting the desired resource without typing the full name.

??? example

    ```sh
    pars resource remove ProductCat<Tab>
    ```
    <div class="result" sh>
    <pre>
    ProductCategory_SeedData
    </pre>
    </div>



## Notes

To enable autocompletion for the Pars CLI application, ensure that the necessary configuration settings are correctly applied. Autocompletion significantly enhances user experience by allowing easy navigation and selection of commands, flags, and arguments.

* Ensure that the Pars CLI application has the necessary permissions and configurations to support autocompletion.
* For more detailed information and advanced configuration options, refer to the [Autocompletion and Filtering Guide][AutoCompletionAndFilteringGuide]
By configuring subcommand autocompletion, users can quickly and accurately specify resources, greatly enhancing the overall usability of the Pars CLI application.


<!-- Additional links -->
[AutoCompletionAndFilteringGuide]: /setup/configuration/configuration.md#auto-completion
