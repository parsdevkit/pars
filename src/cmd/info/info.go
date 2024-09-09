package info

import (
	"fmt"

	"github.com/spf13/cobra"
	"parsdevkit.net/core/utils"
)

var InfoCmd = &cobra.Command{
	Use:     "info",
	Aliases: []string{""},
	Short:   "About Pars",
	Long:    `About Pars`,
	Run:     executeFunc,
}

func executeFunc(cmd *cobra.Command, args []string) {
	fmt.Printf("Codebase Path: %v\n", utils.GetCodeBaseLocation())
	fmt.Printf("Executable Path: %v\n", utils.GetExecutableLocation())

	// fmt.Println("New generation SDK")
	// fmt.Printf("Stage: %v\n", utils.GetStage())
	// fmt.Printf("Version: %v\n", utils.GetVersion())
	// fmt.Printf("OS: %v\n", runtime.GOOS)
	// fmt.Printf("Architecture: %v\n", runtime.GOARCH)
	// fmt.Printf("Data Directory: %v\n", utils.GetDataLocation())
	// fmt.Printf("VIPER-TEST: %v\n", viper.GetString("app.name"))
}

func init() {
}
