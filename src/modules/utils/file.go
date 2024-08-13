package utils

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

func GetOnlyFileName(file string) string {

	extension := filepath.Ext(file)
	fileWithoutExt := file[0 : len(file)-len(extension)]

	return fileWithoutExt
}

func FindBasePath(absolutePath, relativePath string) string {

	return strings.TrimRight(absolutePath, relativePath)

}

func PathToArray(path string) []string {
	var separator string = "/"

	if strings.Contains(path, "/") {
		separator = "/"
	} else if strings.Contains(path, `\`) {
		separator = `\`
	}
	parts := strings.Split(path, separator)

	if len(parts) > 0 && parts[0] == "" {
		parts = parts[1:]
	}
	return parts
}
func CombinePaths(paths ...[]string) []string {
	var folders []string
	for _, path := range paths {
		folders = append(folders, path...)
	}

	return folders
}
func PathWithDot(path string) string {

	// if IsEmpty(path) {
	// 	return "."
	// }

	return filepath.Join(".", path)
}

func GetFilesInPath(path string) ([]string, error) {
	var files []string

	fileInfo, err := os.Stat(path)
	if err != nil {
		return files, err
	}

	if fileInfo.IsDir() {
		err = filepath.Walk(path, func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}
			if !info.IsDir() {
				files = append(files, path)
			}
			return nil
		})
	} else {
		files = append(files, path)
	}

	if err != nil {
		return files, err
	}

	return files, nil
}
func FindRelativePath(path1, path2 string) (string, error) {
	relativePath, err := filepath.Rel(filepath.ToSlash(path1), filepath.ToSlash(path2))
	if err != nil {
		return "", err
	}
	if !filepath.IsAbs(relativePath) {
		relativePath = filepath.Join(relativePath, "./")
	}
	return relativePath, nil
}

func WalkDir(paths ...string) ([]string, error) {
	var files []string
	for _, path := range paths {
		if path == "." {
			currentDir, err := os.Getwd()
			if err != nil {
				fmt.Println("Error getting current directory:", err)
				return nil, err
			}
			err = filepath.Walk(currentDir, func(filePath string, info os.FileInfo, err error) error {
				if err != nil {
					return err
				}
				if !info.IsDir() && (strings.HasSuffix(filePath, ".yaml") || strings.HasSuffix(filePath, ".yml")) {
					files = append(files, filePath)
				}
				return nil
			})
			if err != nil {
				fmt.Println("Error walking current directory:", err)
				return nil, err
			}
		} else {
			absolutePath, err := filepath.Abs(path)
			if err != nil {
				fmt.Println("Error getting absolute path:", err)
				return nil, err
			}

			fileInfo, err := os.Stat(absolutePath)
			if err != nil {
				fmt.Println("Error stating file or directory:", err)
				return nil, err
			}

			if fileInfo.IsDir() {
				err = filepath.Walk(absolutePath, func(filePath string, info os.FileInfo, err error) error {
					if err != nil {
						return err
					}
					if !info.IsDir() && (strings.HasSuffix(filePath, ".yaml") || strings.HasSuffix(filePath, ".yml")) {
						files = append(files, filePath)
					}
					return nil
				})
				if err != nil {
					fmt.Println("Error walking directory:", err)
					return nil, err
				}
			} else if strings.HasSuffix(absolutePath, ".yaml") || strings.HasSuffix(absolutePath, ".yml") {
				files = append(files, absolutePath)
			}
		}
	}
	return files, nil
}
