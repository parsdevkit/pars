package services

import sharedTemplate "parsdevkit.net/structs/template/shared-template"

type SharedTemplateServiceInterface interface {
	GetByName(name string) (*sharedTemplate.TemplateBaseStruct, error)
	Save(model sharedTemplate.TemplateBaseStruct) (*sharedTemplate.TemplateBaseStruct, error)
	List() (*([]sharedTemplate.TemplateBaseStruct), error)
	Remove(name string, permanent bool) (*sharedTemplate.TemplateBaseStruct, error)
	GetHash(name string) string
}
