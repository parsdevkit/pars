package services

import (
	"encoding/json"
	"errors"
	"log"

	"parsdevkit.net/structs/project"
	applicationproject "parsdevkit.net/structs/project/application-project"

	"parsdevkit.net/core/utils"

	"parsdevkit.net/persistence/repositories"

	"parsdevkit.net/persistence/entities"

	"github.com/sirupsen/logrus"
)

type ApplicationProjectService struct {
	ApplicationProjectServiceInterface
	workspaceRespository *repositories.WorkspaceRepository
	groupRespository     *repositories.GroupRepository
	projectRespository   *repositories.ProjectRepository
	settingsRespository  *repositories.SettingsRepository
}

func NewApplicationProjectService(environment string) *ApplicationProjectService {
	return &ApplicationProjectService{
		workspaceRespository: repositories.NewWorkspaceRepository(environment),
		groupRespository:     repositories.NewGroupRepository(environment),
		projectRespository:   repositories.NewProjectRepository(environment),
		settingsRespository:  repositories.NewSettingsRepository(environment),
	}
}

func (s *ApplicationProjectService) Save(model applicationproject.ProjectBaseStruct) (*applicationproject.ProjectBaseStruct, error) {

	logrus.Debugf("project %v creating", model.Name)

	if _, err := s.saveProjectInformation(model); err != nil {
		// _, err := s.rollbackSaveProjectInformation(model)
		// if err != nil {
		// 	logrus.Warnf("rollback %v failed too!", model.Name)
		// }
		return nil, err
	}

	return &model, nil
}

func (s ApplicationProjectService) GetByName(name string) (*applicationproject.ProjectBaseStruct, error) {
	var template *applicationproject.ProjectBaseStruct

	entity, err := s.projectRespository.GetByName(name)
	if err != nil {
		return nil, err
	}
	if entity != nil {
		err = json.Unmarshal([]byte(entity.Document), &template)
	} else {
		template = nil
	}

	return template, nil
}

// OK!
func (s *ApplicationProjectService) List() (*([]applicationproject.ProjectBaseStruct), error) {

	entityList, err := s.projectRespository.ListByKind(string(project.StructKinds.Application))
	if err != nil {
		return nil, err
	}

	projectList := make([]applicationproject.ProjectBaseStruct, 0)

	for _, entity := range *entityList {
		var project applicationproject.ProjectBaseStruct
		err = json.Unmarshal([]byte(entity.Document), &project)

		projectList = append(projectList, project)
	}

	return &projectList, nil
}

// OK!
func (s *ApplicationProjectService) ListBySet(set string) (*([]applicationproject.ProjectBaseStruct), error) {

	entityList, err := s.projectRespository.ListBySet(set)
	if err != nil {
		return nil, err
	}

	projectList := make([]applicationproject.ProjectBaseStruct, 0)

	for _, entity := range *entityList {
		var project applicationproject.ProjectBaseStruct
		err = json.Unmarshal([]byte(entity.Document), &project)

		projectList = append(projectList, project)
	}

	return &projectList, nil
}

// OK!
func (s *ApplicationProjectService) ListBySetAndLayers(set string, layers ...string) (*([]applicationproject.ProjectBaseStruct), error) {

	entityList, err := s.projectRespository.ListBySetAndLayers(set, layers...)
	if err != nil {
		return nil, err
	}

	projectList := make([]applicationproject.ProjectBaseStruct, 0)

	for _, entity := range *entityList {
		var project applicationproject.ProjectBaseStruct
		err = json.Unmarshal([]byte(entity.Document), &project)

		projectList = append(projectList, project)
	}

	return &projectList, nil
}

// OK!
func (s *ApplicationProjectService) ListByWorkspace(workspaceName string) (*([]applicationproject.ProjectBaseStruct), error) {

	entityList, err := s.projectRespository.ListByWorkspace(workspaceName)
	if err != nil {
		return nil, err
	}

	projectList := make([]applicationproject.ProjectBaseStruct, 0)

	for _, entity := range *entityList {
		var project applicationproject.ProjectBaseStruct
		err = json.Unmarshal([]byte(entity.Document), &project)

		projectList = append(projectList, project)
	}

	return &projectList, nil

}

// OK!
func (s *ApplicationProjectService) ListByFullNameWorkspace(name string, workspaceName string) (*([]applicationproject.ProjectBaseStruct), error) {

	var projectList []applicationproject.ProjectBaseStruct = []applicationproject.ProjectBaseStruct{}

	projectGroup, projectName, err := project.ParseProjectFullName(name)
	if err != nil {
		log.Fatal(err)
	}

	projectWorkspaceEntity, err := s.workspaceRespository.GetByName(workspaceName)
	if err != nil {
		return nil, err
	}
	if projectWorkspaceEntity == nil {
		return nil, errors.New("invalid project workspace")
	}

	groupId := 0
	projectGroupEntity, err := s.groupRespository.GetByName(projectGroup)
	if err != nil {
		return nil, err
	}
	if projectGroupEntity != nil {
		groupId = projectGroupEntity.ID
	}

	if groupId > 0 {
		logrus.Debugf("project (%v) in the group (%v)", projectName, projectGroup)
	}

	//TODO: iyileştirilecek, kolay çözüm uygulandı
	if utils.IsEmpty(projectName) && !utils.IsEmpty(projectGroup) {
		projectEntities, err := s.projectRespository.ListByWorkspaceNameAndGroup(workspaceName, projectGroup)
		if err != nil {
			return nil, err
		}

		// for _, entity := range *projectEntities {
		// 	entity.Workspace = projectWorkspaceEntity
		// 	var project = s.projectMapper.ProjectEntityToStruct(entity)

		// 	projectList = append(projectList, project)
		// }

		for _, entity := range *projectEntities {
			var project applicationproject.ProjectBaseStruct
			err = json.Unmarshal([]byte(entity.Document), &project)
			if err != nil {
				return nil, err
			}

			projectList = append(projectList, project)
		}

		return &projectList, nil
	} else {
		entity, err := s.projectRespository.GetByNameGroupAndWorkspaceName(projectName, projectGroup, workspaceName)
		if err != nil {
			return nil, err
		}
		if entity == nil {
			return nil, errors.New("Project name (" + name + ") is not correct")
		}
		var project applicationproject.ProjectBaseStruct
		err = json.Unmarshal([]byte(entity.Document), &project)
		if err != nil {
			return nil, err
		}

		projectList = append(projectList, project)

		return &projectList, nil
	}
}

// OK!
func (s *ApplicationProjectService) GetByFullNameWorkspace(name string, workspaceName string) (*applicationproject.ProjectBaseStruct, error) {

	var result applicationproject.ProjectBaseStruct = applicationproject.ProjectBaseStruct{}
	logrus.Debugf("trying to find project with fullname (%v)", name)

	projectGroup, projectName, err := project.ParseProjectFullName(name)
	if err != nil {
		log.Fatal(err)
	}
	logrus.Debugf("fullname parsed to name (%v) and group (%v)", projectName, projectGroup)

	projectWorkspaceEntity, err := s.workspaceRespository.GetByName(workspaceName)
	if err != nil {
		return nil, err
	}
	if projectWorkspaceEntity == nil {
		return nil, errors.New("invalid project workspace")
	}

	if !utils.IsEmpty(projectName) {

		groupId := 0
		projectGroupEntity, err := s.groupRespository.GetByName(projectGroup)
		if err != nil {
			return nil, err
		}
		if projectGroupEntity != nil {
			groupId = projectGroupEntity.ID
		}

		if groupId > 0 {
			logrus.Debugf("project (%v) in the group (%v)", projectName, projectGroup)
		}

		entity, err := s.projectRespository.GetByNameGroupAndWorkspaceName(projectName, projectGroup, workspaceName)
		if err != nil {
			return nil, err
		}
		if entity == nil {
			return nil, nil
		}

		var project applicationproject.ProjectBaseStruct
		err = json.Unmarshal([]byte(entity.Document), &project)
		if err != nil {
			return nil, err
		}

		result = project

	}
	return &result, nil
}

func (s *ApplicationProjectService) Remove(name string, workspaceName string, force bool, permanent bool) (*applicationproject.ProjectSpecification, error) {
	logrus.Debugf("project(s) will be %v removing", name)
	projectGroup, projectName, err := project.ParseProjectFullName(name)
	if err != nil {
		log.Fatal(err)
	}

	projectWorkspaceEntity, err := s.workspaceRespository.GetByName(workspaceName)
	if err != nil {
		return nil, err
	}
	if projectWorkspaceEntity == nil {
		return nil, errors.New("invalid project workspace")
	}

	groupId := 0
	projectGroupEntity, err := s.groupRespository.GetByName(projectGroup)
	if err != nil {
		return nil, err
	}
	if projectGroupEntity != nil {
		groupId = projectGroupEntity.ID
	}

	if groupId > 0 {
		logrus.Debugf("project (%v) in the group (%v)", projectName, projectGroup)
	}
	//TODO: iyileştirilecek, kolay çözüm uygulandı
	if utils.IsEmpty(projectName) && !utils.IsEmpty(projectGroup) {
		logrus.Debugf("all group projects %v removing", projectName)
		projectEntities, err := s.projectRespository.ListByWorkspaceNameAndGroup(workspaceName, projectGroup)
		if err != nil {
			return nil, err
		}

		var latestValue *applicationproject.ProjectSpecification
		for _, entity := range *projectEntities {
			var project applicationproject.ProjectBaseStruct
			err = json.Unmarshal([]byte(entity.Document), &project)
			if err != nil {
				return nil, err
			}
			latestValue, _ = s.Remove(project.GetFullName(), workspaceName, force, permanent)
		}

		return latestValue, nil
	} else {

		logrus.Debugf("project %v removing", projectName)
		entity, err := s.projectRespository.GetByNameGroupAndWorkspaceName(projectName, projectGroup, workspaceName)
		if err != nil {
			return nil, err
		}
		if entity == nil {
			logrus.Errorf("project '%v' not found in group '%v' (%d)", projectName, projectGroup, groupId)
			return nil, errors.New("Project name (" + name + ") is not correct")
		}
		// entity.Workspace = projectWorkspaceEntity

		var project applicationproject.ProjectBaseStruct
		err = json.Unmarshal([]byte(entity.Document), &project)
		if err != nil {
			return nil, err
		}

		logrus.Debugf("project (%v) information removing", projectName)
		err = s.projectRespository.Delete(entity)
		if err != nil {
			return nil, err
		}
		logrus.Debugf("project (%v) information removed", projectName)

		return &project.Specifications, nil
	}
}

func (s *ApplicationProjectService) IsExists(name string, workspaceName string) bool {
	projectGroup, projectName, err := project.ParseProjectFullName(name)
	if err != nil {
		log.Fatal(err)
	}

	projectWorkspaceEntity, err := s.workspaceRespository.GetByName(workspaceName)
	if err != nil {
		return false
	}
	if projectWorkspaceEntity == nil {
		return false
	}

	_, err = s.groupRespository.GetByName(projectGroup)
	if err != nil {
		return false
	}

	entity, err := s.projectRespository.GetByNameGroupAndWorkspaceName(projectName, projectGroup, workspaceName)
	if err != nil {
		return false
	}
	if entity == nil {
		return false
	}

	return true
}

func (s ApplicationProjectService) GetHash(name string, workspaceName string) string {
	projectGroup, projectName, err := project.ParseProjectFullName(name)
	if err != nil {
		log.Fatal(err)
	}

	projectWorkspaceEntity, err := s.workspaceRespository.GetByName(workspaceName)
	if err != nil {
		return ""
	}
	if projectWorkspaceEntity == nil {
		return ""
	}

	_, err = s.groupRespository.GetByName(projectGroup)
	if err != nil {
		return ""
	}

	entity, err := s.projectRespository.GetByNameGroupAndWorkspaceName(projectName, projectGroup, workspaceName)
	if err != nil {
		return ""
	}
	if entity == nil {
		return ""
	}

	return entity.Hash
}

func (s *ApplicationProjectService) saveProjectInformation(projectModel applicationproject.ProjectBaseStruct) (*applicationproject.ProjectBaseStruct, error) {

	logrus.Debugf("project %v information saving", projectModel.Name)

	jsonData, err := json.Marshal(projectModel)
	if err != nil {
		return nil, err
	}

	projectEntity := entities.Project{
		Name:     projectModel.Name,
		Document: string(jsonData),
	}

	err = s.projectRespository.Save(&projectEntity)
	if err != nil {
		return nil, err
	}

	logrus.Debugf("project %v information saved", projectModel.Name)
	return &projectModel, nil
}
