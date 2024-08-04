package services

import (
	applicationproject "parsdevkit.net/structs/project/application-project"
)

type ApplicationProjectServiceInterface interface {
	Save(model applicationproject.ProjectBaseStruct, init bool) (*applicationproject.ProjectBaseStruct, error)
	List() (*([]applicationproject.ProjectBaseStruct), error)
	ListBySet(set string) (*([]applicationproject.ProjectBaseStruct), error)
	ListBySetAndLayers(set string, layers ...string) (*([]applicationproject.ProjectBaseStruct), error)
	ListByWorkspace(workspaceName string) (*([]applicationproject.ProjectBaseStruct), error)
	GetByFullNameWorkspace(name string, workspaceName string) (*applicationproject.ProjectBaseStruct, error)
	ListByFullNameWorkspace(name string, workspaceName string) (*([]applicationproject.ProjectBaseStruct), error)
	GetHash(name string, workspaceName string) string
}
