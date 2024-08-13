package utils

import (
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"strings"

	"github.com/sirupsen/logrus"
	"parsdevkit.net/core"
)

var (
	environment string
	logLevel    core.LogLevel
)

func getDefaultPlatformApplicationDir() string {
	switch runtime.GOOS {
	case "windows":
		if runtime.GOARCH == "amd64" {
			return "C:\\Program Files\\pars"
		} else if runtime.GOARCH == "386" {
			return "C:\\Program Files (x86)\\pars"
		}
		return "C:\\Program Files\\pars"
	case "darwin":
		return "/usr/local/bin"
	case "linux":
		return "/usr/local/bin"
	case "freebsd":
		return "/usr/local/bin"
	case "openbsd":
		return "/usr/local/bin"
	case "netbsd":
		return "/usr/local/bin"
	default:
		return "/usr/local/bin"
	}
}

func getDefaultPlatformDataDir() string {
	switch runtime.GOOS {
	case "windows":
		if runtime.GOARCH == "amd64" {
			return "C:\\Program Files\\pars\\data"
		} else if runtime.GOARCH == "386" {
			return "C:\\Program Files (x86)\\pars\\data"
		}
		return "C:\\Program Files\\pars\\data"
	case "darwin":
		return "/usr/local/var/pars/data"
	case "linux":
		return "/var/lib/pars/data"
	case "freebsd":
		return "/var/db/pars/data"
	case "openbsd":
		return "/var/db/pars/data"
	case "netbsd":
		return "/var/db/pars/data"
	default:
		return "/tmp/pars/data"
	}
}

func getDefaultPlatformConfigDir() string {
	switch runtime.GOOS {
	case "windows":
		if runtime.GOARCH == "amd64" {
			return "C:\\Program Files\\pars\\config"
		} else if runtime.GOARCH == "386" {
			return "C:\\Program Files (x86)\\pars\\config"
		}
		return "C:\\Program Files\\pars\\config"
	case "darwin":
		return "/usr/local/etc/pars"
	case "linux":
		return "/etc/pars"
	case "freebsd":
		return "/usr/local/etc/pars"
	case "openbsd":
		return "/etc/pars"
	case "netbsd":
		return "/etc/pars"
	default:
		return "/tmp/pars/config"
	}
}

func getDefaultPlatformTempDir() string {
	return os.TempDir()
}

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

	path := os.Getenv("PARS_PROJECT")

	if IsEmpty(path) {
		path = getDefaultPlatformApplicationDir()
	}

	return path
}
func GetPluginsLocation() string {
	return filepath.Join(GetExecutionLocation(), "plugins")
}

func GetBinariesLocation() string {
	return filepath.Join(GetExecutionLocation(), "binaries")
}
func GetDataLocation() string {
	path := getDefaultPlatformDataDir()

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return err.Error()
		}
	} else if err != nil {
		return ""
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

func GetCodeBaseLocation() string {
	return os.Getenv("PARS_PROJECT_ROOT")
}

func GetSourceLocation() string {
	return filepath.Join(GetCodeBaseLocation(), "src")
}

func GetTempsLocation() string {
	return filepath.Join(GetCodeBaseLocation(), "temp")
}
func GetTestsLocation() string {
	return filepath.Join(GetCodeBaseLocation(), "tests")
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
