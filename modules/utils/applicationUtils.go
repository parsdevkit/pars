package utils

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/sirupsen/logrus"
	"parsdevkit.net/core"
)

var (
	environment string
	logLevel    core.LogLevel
)

func SetEnvironment(env string) {
	environment = env
}
func GetEnvironment() string {
	return environment
}

func SetLogLevel(LogLevel core.LogLevel) {
	logLevel = LogLevel
}
func GetLogLevel() core.LogLevel {
	return logLevel
}

func GetExecutionLocation() string {

	path := GetCodeBaseLocation()

	if IsEmpty(path) {
		exePath, err := os.Executable()
		if err != nil {
			panic(err)
		}

		path = filepath.Dir(exePath)
	}

	return path
}

func GetCodeBaseLocation() string {

	return os.Getenv("PARS_PROJECT_ROOT")
}

func GetPluginsLocation() string {

	return filepath.Join(GetExecutionLocation(), "plugins")
}

func GetTestsLocation() string {
	return filepath.Join(GetExecutionLocation(), "tests")
}
func GetTestFileLocation(file string) string {
	return filepath.Join(GetTestsLocation(), file)
}

func GenerateTestArea() string {
	parsTestDir := GetTestsLocation()
	file, err := os.Getwd()
	if err != nil {
		logrus.Fatalf("Error occured when getting test file location: %v", err)
	}

	if strings.ToLower(filepath.VolumeName(parsTestDir)) == strings.ToLower(filepath.VolumeName(file)) {
		drive := filepath.VolumeName(parsTestDir)

		testArea := strings.TrimPrefix(filepath.Join(strings.ToUpper(drive), file[len(drive):]), parsTestDir)
		testArea = strings.TrimPrefix(testArea, "/")
		testArea = strings.TrimPrefix(testArea, "\\")

		return filepath.Join(testArea)

	} else {
		logrus.Fatalf("Test Drivers are not same")
	}
	return ""

}
func GetTestFileFromCurrentLocation(file string) string {
	return GetTestFileLocation(filepath.Join(GenerateTestArea(), file))
}

func GetUnitTestsLocation() string {
	return filepath.Join(GetTestsLocation(), "unit")
}

func GetUnitTestFileLocation(file string) string {
	return filepath.Join(GetUnitTestsLocation(), file)
}

func GetE2ETestsLocation() string {
	return filepath.Join(GetTestsLocation(), "e2e")
}
func GetE2ETestFileLocation(file string) string {
	return filepath.Join(GetE2ETestsLocation(), file)
}

func GetIntegrationTestsLocation() string {
	return filepath.Join(GetTestsLocation(), "integration")
}
func GetIntegrationTestFileLocation(file string) string {
	return filepath.Join(GetIntegrationTestsLocation(), file)
}

func GetScenarioTestsLocation() string {
	return filepath.Join(GetTestsLocation(), "scenario")
}
func GetScenarioTestFileLocation(file string) string {
	return filepath.Join(GetScenarioTestsLocation(), file)
}

func GetBenchmarkTestsLocation() string {
	return filepath.Join(GetTestsLocation(), "benchmark")
}
func GetBenchmarkTestFileLocation(file string) string {
	return filepath.Join(GetBenchmarkTestsLocation(), file)
}

func GetBinariesLocation() string {

	return filepath.Join(GetExecutionLocation(), "binaries")
}
func GetDataLocation() string {
	executionLocation := GetExecutionLocation()
	path := filepath.Join(executionLocation, "data")

	_, err := os.Stat(path)
	if os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return ""
		}
	}

	return path
}
func GetBinaryLocation(name, version string) string {

	return filepath.Join(GetBinariesLocation(), name, version)
}

func GetPluginLocation(pluginName string) string {

	return filepath.Join(GetPluginsLocation(), pluginName)
}

func GetDBLocation(environment string) string {
	dbName := "pars.db"

	if !IsEmpty(environment) {
		dbName = fmt.Sprintf("pars-%v.db", environment)
	}

	path := filepath.Join(GetDataLocation(), dbName)
	return path
}

func GetManagerTemplatesLocation() string {
	return filepath.Join(GetExecutionLocation(), "templates")
}
