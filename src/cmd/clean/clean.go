package clean

import (
	"fmt"
	"log"
	"os"

	"parsdevkit.net/operation/services"

	"parsdevkit.net/core/utils"

	parsCMDCommon "parsdevkit.net/core/cmd"

	"github.com/spf13/cobra"
)

var (
	name          string
	workspaceName string
)

var CleanCmd = &cobra.Command{
	Use:     "clean",
	Aliases: []string{"c"},
	Short:   "Clean project(s)",
	Long:    `Clean project(s)`,
	Run:     executeFunc,
}

func executeFunc(cmd *cobra.Command, args []string) {
	if utils.IsEmpty(name) {
		if len(args) == 0 {
			fmt.Println("Please provide a project name")
			os.Exit(1)
		} else if len(args) > 0 {
			name = args[0]
		}
	}

	if utils.IsEmpty(name) {
		cmd.Help()
		os.Exit(0)
	}

	workspaceName = parsCMDCommon.GetActiveWorkspaceName(workspaceName)

	projectService := services.NewApplicationProjectService(utils.GetEnvironment())
	project, err := projectService.Clean(name, workspaceName)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Project (" + project.Name + ") cleaned")
}

func init() {
	CleanCmd.Flags().StringVarP(&name, "name", "n", "", "Project name")

	CleanCmd.Flags().StringVarP(&workspaceName, "workspace", "w", "", "Workspace name")
	// RemoveCommand.Flags().StringVarP(&force, "force", "", "", "Force to delete")

	// if err := RemoveCommand.MarkFlagRequired("force"); err != nil {
	// 	fmt.Println(err)
	// }
}