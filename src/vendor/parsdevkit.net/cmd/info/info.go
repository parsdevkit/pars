package info

import (
	"fmt"

	"github.com/spf13/cobra"
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
	fmt.Printf("Version: %v\n", "beta-0.0.1")
}

func init() {
}
