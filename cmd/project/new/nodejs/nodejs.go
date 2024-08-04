package nodejs

import (
	"parsdevkit.net/cmd/project/new/nodejs/library"
	"parsdevkit.net/cmd/project/new/nodejs/spa"

	"github.com/spf13/cobra"
)

var nodejsCmd = &cobra.Command{
	Use:     "nodejs",
	Aliases: []string{"a"},
	Short:   "Create new nodejs project",
	Long:    `Create new nodejs project`,
	Run:     executeFunc,
}

func executeFunc(cmd *cobra.Command, args []string) {
	cmd.Help()
}

func init() {
	addSubCommands()
}

func addSubCommands() {
	nodejsCmd.AddCommand(spa.SPACmd)
	nodejsCmd.AddCommand(library.LibraryCmd)
}
