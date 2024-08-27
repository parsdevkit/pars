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
	fmt.Printf("Version: %v\n", utils.GetVersion())
	fmt.Printf("OS: %v\n", runtime.GOOS)
	fmt.Printf("Architecture: %v\n", runtime.GOARCH)
	fmt.Printf("Data Directory: %v\n", utils.GetDataLocation())
}

func init() {
}
