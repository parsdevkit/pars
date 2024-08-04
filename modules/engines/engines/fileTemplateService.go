package engines

import (
	"bytes"
	"fmt"
	"log"
	"os"
	"path/filepath"
	textTemplate "text/template"

	filetemplate "parsdevkit.net/structs/template/file-template"

	"parsdevkit.net/operation/services"

	"parsdevkit.net/core/utils"

	"github.com/sirupsen/logrus"
)

type FileTemplateService struct{}

func (s FileTemplateService) CreateTemplatesFromTemplate(init bool, data any, templateFiles ...string) error {

	var allTemplates []filetemplate.TemplateBaseStruct = make([]filetemplate.TemplateBaseStruct, 0)

	for _, templateFilePath := range templateFiles {

		var tmplFile = filepath.Join(utils.GetManagerTemplatesLocation(), templateFilePath)
		tmplContent, err := os.ReadFile(tmplFile)
		if err != nil {
			log.Fatal(err)
		}
		var outputBuffer bytes.Buffer
		err = textTemplate.Must(textTemplate.New("TemplateFromTemplate").Parse(string(tmplContent))).Execute(&outputBuffer, data)
		if err != nil {
			log.Fatal(err)
		}
		mainStr := outputBuffer.String()

		groupSerializer := FileTemplateSerializer{}
		templates, err := groupSerializer.GetTemplateStructsFromString(mainStr)
		if err != nil {
			return err
		}
		allTemplates = append(allTemplates, templates...)
	}

	if err := s.CreateTemplates(allTemplates, init); err != nil {
		return err
	}

	return nil
}
func (s FileTemplateService) CreateTemplatesFromFile(init bool, files ...string) error {
	if len(files) > 0 {

		allFiles := make([]string, 0)
		for _, path := range files {
			if !utils.IsEmpty(path) {
				files, err := utils.GetFilesInPath(path)
				if err != nil {
					return err
				}

				allFiles = append(allFiles, files...)
			}
		}

		logrus.Debugf("found %v files", len(allFiles))
		groupSerializer := FileTemplateSerializer{}
		templatesFromFile, err := groupSerializer.GetTemplateStructsFromFile(allFiles...)
		if err != nil {
			return err
		}

		logrus.Debugf("found %v template", len(templatesFromFile))
		if err := s.CreateTemplates(templatesFromFile, init); err != nil {
			return err
		}
	}
	return nil
}

func (s FileTemplateService) RemoveTemplatesFromFile(permanent bool, files ...string) error {
	if len(files) > 0 {

		allFiles := make([]string, 0)
		for _, path := range files {
			if !utils.IsEmpty(path) {

				files, err := utils.GetFilesInPath(path)
				if err != nil {
					return err
				}

				allFiles = append(allFiles, files...)
			}
		}

		groupSerializer := FileTemplateSerializer{}
		templatesFromFile, err := groupSerializer.GetTemplateStructsFromFile(allFiles...)
		if err != nil {
			return err
		}

		if err := s.RemoveTemplates(templatesFromFile, permanent); err != nil {
			return err
		}
	}
	return nil
}
func (s FileTemplateService) CreateTemplates(templates []filetemplate.TemplateBaseStruct, init bool) error {

	templatesReadyToCreate := make([]filetemplate.TemplateBaseStruct, 0)
	templatesForUpdate := make([]filetemplate.TemplateBaseStruct, 0)
	templateService := services.NewFileTemplateService(utils.GetEnvironment())

	for _, template := range templates {
		if ok := templateService.IsExists(template.Name, template.Specifications.Workspace); ok {
			newModelHash, err := utils.CalculateHashFromObject(template)
			if err != nil {
				return err
			}
			structHash := templateService.GetHash(template.Name)

			if newModelHash != structHash {
				templatesForUpdate = append(templatesForUpdate, template)
			}
		} else {
			templatesReadyToCreate = append(templatesReadyToCreate, template)
		}
	}
	logrus.Debugf("'%d' template(s) detected that will create", len(templatesReadyToCreate))
	logrus.Debugf("'%d' template(s) detected that will update", len(templatesForUpdate))

	logrus.Debugf("creating %v new templates ", len(templatesReadyToCreate))
	logrus.Debugf("updating %v templates ", len(templatesForUpdate))
	for _, template := range templatesReadyToCreate {

		fmt.Printf("Creating %v Template\n", template.Name)
		if _, err := templateService.Save(template); err != nil {
			return err
		}

		if _, err := templateService.Generate(template); err != nil {
			return err
		}

		fmt.Printf("%v Template created\n", template.Name)
	}

	logrus.Debugf("updating %v templates ", len(templatesForUpdate))
	for _, template := range templatesForUpdate {

		if _, err := templateService.Save(template); err != nil {
			return err
		}

		if _, err := templateService.Generate(template); err != nil {
			return err
		}

		fmt.Printf("%v Template updated\n", template.Name)
	}
	return nil
}

func (s FileTemplateService) RemoveTemplates(templates []filetemplate.TemplateBaseStruct, permanent bool) error {

	templateService := services.NewFileTemplateService(utils.GetEnvironment())
	templatesReadyToDelete := make([]filetemplate.TemplateBaseStruct, 0)
	for _, template := range templates {
		if ok := templateService.IsExists(template.Name, template.Specifications.Workspace); ok {
			templatesReadyToDelete = append(templatesReadyToDelete, template)
		}
	}

	for _, template := range templatesReadyToDelete {

		if _, err := templateService.Remove(template.Name, template.Specifications.Workspace, permanent); err != nil {
			return err
		}

		fmt.Printf("%v Template deleted\n", template.Name)

	}

	return nil
}
