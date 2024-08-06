package main

import (
	"parsdevkit.net/cmd"
)

func main() {

	cmd.Execute()
	// logLevel := utils.GetLogLevel()

	// if logLevel != core.LogLevels.None {
	// 	if logrusLogLevel, err := log.ParseLevel(string(logLevel)); err != nil {
	// 		fmt.Println(err)
	// 	} else {
	// 		log.SetLevel(logrusLogLevel)
	// 	}
	// } else {
	// 	fmt.Println("Zaten istenmiyor!!!")
	// }
}
