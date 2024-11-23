package sharedTemplate

import (
	"fmt"
	"os"
	"strings"

	"github.com/sirupsen/logrus"
	"parsdevkit.net/core/utils"
	"parsdevkit.net/engines"
	"parsdevkit.net/operation/services"
	"parsdevkit.net/structs"
	"parsdevkit.net/structs/template"
	sharedtemplate "parsdevkit.net/structs/template/shared-template"
	"parsdevkit.net/structs/workspace"

	"gopkg.in/yaml.v3"
)

type SharedTemplateSerializer struct{}

func (s SharedTemplateSerializer) GetTemplateStructsFromString(data string) ([]sharedtemplate.TemplateBaseStruct, error) {
	templates := make([]sharedtemplate.TemplateBaseStruct, 0)

	yamlLines := strings.Split(string(data), "---")

	for _, line := range yamlLines {
		var header structs.Header
		if err := yaml.Unmarshal([]byte(line), &header); err != nil {
			return nil, err
		}

		if header.Type == structs.StructTypes.Template {
			var resourceHeader template.Header
			if err := yaml.Unmarshal([]byte(line), &resourceHeader); err != nil {
				return nil, err
			}
			if resourceHeader.Kind == template.StructKinds.Shared {
				var templateDefinitionStruct = sharedtemplate.TemplateBaseStruct{}
				if err := yaml.Unmarshal([]byte(line), &templateDefinitionStruct); err != nil {
					return nil, err
				}

				rawTemplate := templateDefinitionStruct
				if err := s.CompleteTemplateInformation(&rawTemplate); err != nil {
					return nil, err
				}

				templates = append(templates, rawTemplate)
			}
		}
	}

	return templates, nil
}

func (s SharedTemplateSerializer) GetTemplateStructsFromFile(files ...string) ([]sharedtemplate.TemplateBaseStruct, error) {
	templates := make([]sharedtemplate.TemplateBaseStruct, 0)
	for _, file := range files {

		data, err := os.ReadFile(file)
		if err != nil {
			return nil, err
		}
		templateStructs, err := s.GetTemplateStructsFromString(string(data))
		if err != nil {
			return nil, err
		}
		templates = append(templates, templateStructs...)

	}
	return templates, nil
}

func (s SharedTemplateSerializer) CompleteTemplateInformation(template *sharedtemplate.TemplateBaseStruct) error {

	logrus.Debugf("filling template (%v) information", template.Name)

	if strings.ToLower(template.Specifications.Workspace) != strings.ToLower("None") {
		activeWorkspace, err := s.GetWorkspace(*template)
		if err != nil {
			return err
		}

		//WARN: Doğru mu oldu?
		template.Specifications.Workspace = activeWorkspace.Name
		template.Specifications.WorkspaceObject = activeWorkspace.Specifications
		logrus.Debugf("workspace (%v) detected for (%v)", activeWorkspace.Name, template.Name)
	}

	return nil
}

func (s SharedTemplateSerializer) GetWorkspace(template sharedtemplate.TemplateBaseStruct) (*workspace.WorkspaceBaseStruct, error) {

	appContext := engines.GetContext()
	var result workspace.WorkspaceBaseStruct = *appContext.CurrentWorkspace

	workspaceName := template.Specifications.Workspace

	if !utils.IsEmpty(workspaceName) {
		workspaceService := services.NewWorkspaceService(utils.GetEnvironment())
		workspace, err := workspaceService.GetByName(workspaceName)
		if err != nil {
			return nil, err
		}
		if workspace == nil {
			return nil, fmt.Errorf("workspace name (%v) is not correct", workspaceName)
		}
		result = *workspace
	}

	return &result, nil
}