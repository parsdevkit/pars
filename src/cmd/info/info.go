package info

import (
	"fmt"
	"runtime"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
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
	if utils.IsEmpty(utils.GetStage()) || utils.GetStage() == string(utils.StageTypes.None) {
		fmt.Printf("Codebase Path: %v\n", utils.GetCodeBaseLocation())
	}
	fmt.Printf("Executable Path: %v\n", utils.GetExecutableLocation())
	fmt.Printf("Stage: %v\n", utils.GetStage())
	fmt.Printf("Version: %v\n", utils.GetVersion())
	fmt.Printf("OS: %v\n", runtime.GOOS)
	fmt.Printf("Architecture: %v\n", runtime.GOARCH)
	fmt.Printf("Data Directory: %v\n", utils.GetDataLocation())
	fmt.Printf("VIPER-TEST: %v\n", viper.GetString("app.name"))
}

func init() {
}
