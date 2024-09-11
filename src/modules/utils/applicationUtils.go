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
	version     string
	stage       string
	logLevel    core.LogLevel
)

type StageType string

var StageTypes = struct {
	None  StageType
	Dev   StageType
	Test  StageType
	Final StageType
}{
	None:  "",
	Dev:   "dev",
	Test:  "test",
	Final: "final",
}

func getDefaultPlatformApplicationDir() string {
	switch runtime.GOOS {
	case "windows":
		if runtime.GOARCH == "amd64" {
			return "C:\\Program Files\\Pars\\bin"
		} else if runtime.GOARCH == "386" {
			return "C:\\Program Files (x86)\\Pars\\bin"
		}
		return "C:\\Program Files\\Pars\\bin"
	case "darwin":
		return "/usr/bin"
	case "linux":
		return "/usr/bin"
	case "freebsd":
		return "/usr/bin"
	case "openbsd":
		return "/usr/bin"
	case "netbsd":
		return "/usr/bin"
	default:
		return "/usr/bin"
	}
}

func getDefaultPlatformLibraryDir() string {
	switch runtime.GOOS {
	case "windows":
		if runtime.GOARCH == "amd64" {
			return "C:\\Program Files\\Pars\\lib"
		} else if runtime.GOARCH == "386" {
			return "C:\\Program Files (x86)\\Pars\\lib"
		}
		return "C:\\Program Files\\Pars\\lib"
	case "darwin":
		return "/usr/lib/pars"
	case "linux":
		return "/usr/lib/pars"
	case "freebsd":
		return "/usr/lib/pars"
	case "openbsd":
		return "/usr/lib/pars"
	case "netbsd":
		return "/usr/lib/pars"
	default:
		return "/usr/lib/pars"
	}
}

func getDefaultPlatformPluginDir() string {
	switch runtime.GOOS {
	case "windows":
		if runtime.GOARCH == "amd64" {
			return "C:\\Program Files\\Pars\\plugins"
		} else if runtime.GOARCH == "386" {
			return "C:\\Program Files (x86)\\Pars\\plugins"
		}
		return "C:\\Program Files\\Pars\\plugins"
	case "darwin":
		return "/usr/share/pars/plugins"
	case "linux":
		return "/usr/share/pars/plugins"
	case "freebsd":
		return "/usr/share/pars/plugins"
	case "openbsd":
		return "/usr/share/pars/plugins"
	case "netbsd":
		return "/usr/share/pars/plugins"
	default:
		return "/usr/share/pars/plugins"
	}
}

func getDefaultPlatformDocumentDir() string {
	switch runtime.GOOS {
	case "windows":
		if runtime.GOARCH == "amd64" {
			return "C:\\Program Files\\Pars\\doc"
		} else if runtime.GOARCH == "386" {
			return "C:\\Program Files (x86)\\Pars\\doc"
		}
		return "C:\\Program Files\\Pars\\doc"
	case "darwin":
		return "/usr/share/doc/pars"
	case "linux":
		return "/usr/share/doc/pars"
	case "freebsd":
		return "/usr/share/doc/pars"
	case "openbsd":
		return "/usr/share/doc/pars"
	case "netbsd":
		return "/usr/share/doc/pars"
	default:
		return "/usr/share/doc/pars"
	}
}

func getDefaultPlatformConfigDir() string {
	switch runtime.GOOS {
	case "windows":
		return "C:\\ProgramData\\Pars\\config"
	case "darwin":
		return "/etc/pars"
	case "linux":
		return "/etc/pars"
	case "freebsd":
		return "/etc/pars"
	case "openbsd":
		return "/etc/pars"
	case "netbsd":
		return "/etc/pars"
	default:
		return "/etc/pars"
	}
}

func getDefaultPlatformDataDir() string {
	switch runtime.GOOS {
	case "windows":
		return "C:\\ProgramData\\Pars\\data"
	case "darwin":
		return "/var/lib/pars/data"
	case "linux":
		return "/var/lib/pars/data"
	case "freebsd":
		return "/var/lib/pars/data"
	case "openbsd":
		return "/var/lib/pars/data"
	case "netbsd":
		return "/var/lib/pars/data"
	default:
		return "/var/lib/pars/data"
	}
}

func getDefaultPlatformLogDir() string {
	switch runtime.GOOS {
	case "windows":
		return "C:\\ProgramData\\Pars\\logs"
	case "darwin":
		return "/var/log/pars"
	case "linux":
		return "/var/log/pars"
	case "freebsd":
		return "/var/log/pars"
	case "openbsd":
		return "/var/log/pars"
	case "netbsd":
		return "/var/log/pars"
	default:
		return "/var/log/pars"
	}
}

func getDefaultPlatformCacheDir() string {
	switch runtime.GOOS {
	case "windows":
		return "C:\\ProgramData\\Pars\\cache"
	case "darwin":
		return "/var/cache/pars"
	case "linux":
		return "/var/cache/pars"
	case "freebsd":
		return "/var/cache/pars"
	case "openbsd":
		return "/var/cache/pars"
	case "netbsd":
		return "/var/cache/pars"
	default:
		return "/var/cache/pars"
	}
}

func getDefaultPlatformTempDir() string {
	return os.TempDir()
}

func SetStage(stage string) {
	stage = stage
}
func GetStage() string {
	return stage
}

func SetVersion(version string) {
	version = version
}
func GetVersion() string {
	return version
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

func GetCodeBaseLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		_, file, _, ok := runtime.Caller(0)
		if !ok {
			fmt.Println("Error getting caller")
		}
		project_root, err := BaseDirFromFilePath(file, "src/modules/utils/applicationUtils.go")
		if err != nil {
			fmt.Println("Error:", err)
		}
		return project_root
	} else if stage == string(StageTypes.Dev) {
		project_root := os.Getenv("PARS_PROJECT_ROOT")

		return project_root
	}

	return ""
}

func GetExecutableLocation() string {

	exePath, err := os.Executable()
	if err != nil {
		fmt.Println("Error:", err)
	}

	// Get the directory containing the executable
	exeDir := filepath.Dir(exePath)
	return exeDir
}

func PrepareLocations() error {
	err := PrepareConfigLocation()
	if err != nil {
		return err
	}
	err = PrepareLogLocation()
	if err != nil {
		return err
	}

	err = PrepareDocumentLocation()
	if err != nil {
		return err
	}

	err = PrepareDataLocation()
	if err != nil {
		return err
	}

	err = PrepareCacheLocation()
	if err != nil {
		return err
	}

	err = PrepareBinariesLocation()
	if err != nil {
		return err
	}

	err = PreparePluginsLocation()
	if err != nil {
		return err
	}

	return nil
}

func GetConfigLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "bin")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "config")
	} else if stage == string(StageTypes.Test) {
		return filepath.Join(GetExecutableLocation(), "config")
	}
	return getDefaultPlatformConfigDir()
}
func PrepareConfigLocation() error {
	path := GetConfigLocation()

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return err
		}
	} else if err != nil {
		return err
	}

	return nil
}

func GetLogLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "log")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "log")
	} else if stage == string(StageTypes.Test) {
		return filepath.Join(GetExecutableLocation(), "log")
	}
	return getDefaultPlatformLogDir()
}
func PrepareLogLocation() error {
	path := GetLogLocation()

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return err
		}
	} else if err != nil {
		return err
	}

	return nil
}

func GetDocumentLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "docs")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "docs")
	} else if stage == string(StageTypes.Test) {
		return filepath.Join(GetExecutableLocation(), "docs")
	}
	return getDefaultPlatformDocumentDir()
}
func PrepareDocumentLocation() error {
	path := GetDocumentLocation()

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return err
		}
	} else if err != nil {
		return err
	}

	return nil
}

func GetDataLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "data")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "data")
	} else if stage == string(StageTypes.Test) {
		return filepath.Join(GetExecutableLocation(), "data")
	}
	return getDefaultPlatformDataDir()
}
func PrepareDataLocation() error {
	path := GetDataLocation()

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return err
		}
	} else if err != nil {
		return err
	}

	return nil
}
func GetDBLocation(environment string) string {
	dbName := "pars.db"

	if !IsEmpty(environment) {
		dbName = fmt.Sprintf("pars-%v.db", environment)
	}

	path := filepath.Join(GetDataLocation(), dbName)
	return path
}

func GetCacheLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "cache")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "cache")
	} else if stage == string(StageTypes.Test) {
		return filepath.Join(GetExecutableLocation(), "cache")
	}
	return getDefaultPlatformCacheDir()
}
func PrepareCacheLocation() error {
	path := GetCacheLocation()

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return err
		}
	} else if err != nil {
		return err
	}

	return nil
}
func GetBinariesLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "bin")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "bin")
	} else if stage == string(StageTypes.Test) {
		return filepath.Join(GetExecutableLocation(), "bin")
	}
	return getDefaultPlatformLibraryDir()
}
func PrepareBinariesLocation() error {
	path := GetBinariesLocation()

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return err
		}
	} else if err != nil {
		return err
	}

	return nil
}
func GetBinaryLocation(name, version string) string {
	return filepath.Join(GetBinariesLocation(), name, version)
}

func GetPluginsLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "plugins")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "plugins")
	} else if stage == string(StageTypes.Test) {
		return filepath.Join(GetExecutableLocation(), "plugins")
	}
	return getDefaultPlatformPluginDir()
}
func PreparePluginsLocation() error {
	path := GetPluginsLocation()

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0755)
		if err != nil {
			return err
		}
	} else if err != nil {
		return err
	}

	return nil
}

func GetPluginLocation(pluginName string) string {
	return filepath.Join(GetPluginsLocation(), pluginName)
}

func GetManagerTemplatesLocation() string {
	return filepath.Join(GetExecutableLocation(), "templates")
}

func GetSourceLocation() string {
	return filepath.Join(GetCodeBaseLocation(), "src")
}

// TODO: Gözden geçirilerek değerlendirilecek
func GetTempsLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "temp")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "temp")
	} else if stage == string(StageTypes.Test) {
		return filepath.Join(GetExecutableLocation(), "temp")
	}
	return getDefaultPlatformTempDir()
}

// TODO: Gözden geçirilerek değerlendirilecek
func GetTestsLocation() string {
	if IsEmpty(stage) || stage == string(StageTypes.None) {
		return filepath.Join(GetCodeBaseLocation(), "tests")
	} else if stage == string(StageTypes.Dev) {
		return filepath.Join(GetCodeBaseLocation(), "tests")
	}
	return ""
}
func GetTestFileLocation(file string) string {
	return filepath.Join(GetTestsLocation(), file)
}

// TODO: Gözden geçirilerek değerlendirilecek
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
