package init

import (
	"fmt"
	"log"
	"os"
	"path/filepath"

	"parsdevkit.net/structs"
	"parsdevkit.net/structs/workspace"

	"parsdevkit.net/operation/services"

	"parsdevkit.net/core/utils"

	"github.com/spf13/cobra"
)

var (
	name string
	path string
)

var maxArgumentCount int = 2

var InitCmd = &cobra.Command{
	Use:     "init [name] [path]",
	Aliases: []string{"i"},
	Short:   "Initialize new Pars workspace",
	Long:    `Create new workspace for Pars, that contains one or more project(s)`,
	Run:     executeFunc,
	Args: func(cmd *cobra.Command, args []string) error {
		if len(args) > maxArgumentCount {
			return fmt.Errorf("Undefined argument(s) found: %v", args[maxArgumentCount:])
		}
		return nil
	},
	ValidArgsFunction: validArguments,
}

func executeFunc(cmd *cobra.Command, args []string) {
	workspaceService := services.NewWorkspaceService(utils.GetEnvironment())

	if len(args) > 0 {
		name = args[0]
	}
	if len(args) > 1 {
		path = args[1]
	}

	if utils.IsEmpty(name) {
		name = "workspace"
		existingDefaultNamedWorkspaces, err := workspaceService.ListByNameStartWith(name)
		if err != nil {
			log.Fatal(err)
		}

		existingDefaultNamedWorkspaceCount := len(*existingDefaultNamedWorkspaces)
		if existingDefaultNamedWorkspaceCount > 0 {
			name = fmt.Sprintf("%v_%d", name, existingDefaultNamedWorkspaceCount)
		}
		// fmt.Printf("Default name (%v), \n", name)
	}
	if utils.IsEmpty(path) {
		path = name
	}

	if !filepath.IsAbs(path) {
		cwd, err := os.Getwd()
		if err != nil {
			fmt.Println("Current working directory not recognized:", err)
			os.Exit(1)
		}
		path = filepath.Join(cwd, path)
	}

	workspace, err := workspaceService.Save(workspace.NewWorkspaceBaseStruct(structs.NewHeader(structs.StructTypes.Workspace, name, structs.Metadata{}), workspace.NewWorkspaceSpecification(0, name, path)))
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("New workspace (%v) created at: %v\n", workspace.Specifications.Name, workspace.Specifications.Path)
}

func init() {
}

func validArguments(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
	if len(args) == 0 {
		return nil, cobra.ShellCompDirectiveNoFileComp
	}

	if len(args) == 1 {
		dirs, _ := filepath.Glob(filepath.Join(toComplete, "*"))
		completions := []string{}

		for _, dir := range dirs {
			if info, err := os.Stat(dir); err == nil && info.IsDir() {
				dir, _ := GetLastComponent(dir)
				completions = append(completions, dir)
			}
		}
		return completions, cobra.ShellCompDirectiveNoSpace | cobra.ShellCompDirectiveDefault
	}

	return nil, cobra.ShellCompDirectiveNoFileComp
}
func GetLastComponent(path string) (string, error) {
	info, err := os.Stat(path)
	if err != nil {
		return "", err
	}

	if info.IsDir() {
		// Get the last directory name
		return filepath.Base(filepath.Clean(path)), nil
	}

	return "", nil
}
