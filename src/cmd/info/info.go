package info

import (
	"fmt"
	"runtime"

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
	fmt.Println("New generation SDK")
	fmt.Printf("%-20s: %v\n", "Stage", utils.GetStage())
	fmt.Printf("%-20s: %v\n", "Version", utils.GetVersion())
	fmt.Printf("%-20s: %v\n", "Platform", utils.GetPlatform())
	fmt.Printf("%-20s: %v\n", "OS", runtime.GOOS)
	fmt.Printf("%-20s: %v\n", "Architecture", runtime.GOARCH)

	environment := utils.GetEnvironment()
	if utils.IsEmpty(environment) {
		environment = "default"
	}
	fmt.Printf("%-20s: %v\n", "Environment", environment)

	if utils.GetStage() == string(utils.StageTypes.None) {
		fmt.Printf("%-20s: %v\n", "Codebase Path", utils.GetCodeBaseLocation())
	}
	fmt.Printf("%-20s: %v\n", "Executable Path", utils.GetExecutableLocation())
	fmt.Printf("%-20s: %v\n", "Config Directory", utils.GetConfigLocation())
	fmt.Printf("%-20s: %v\n", "Data Directory", utils.GetDataLocation())
}

func init() {
}
